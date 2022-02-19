import 'package:chopper/chopper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'swagger_generated_code/orditori.swagger.dart';

late Orditori _client;

void main() {
  _client = Orditori.create(baseUrl: 'http://3.127.125.21');
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AsyncWidget<Brightness>(
      load: () => SharedPreferences.getInstance().then(
        (p) => (p.getString('brightness') ?? 'light') == 'light'
            ? Brightness.light
            : Brightness.dark,
      ),
      error: const SizedBox(),
      loading: const SizedBox(),
      builder: (context, value) {
        SystemChrome.setSystemUIOverlayStyle(
          SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness:
                value == Brightness.dark ? Brightness.light : Brightness.dark,
          ),
        );

        return MaterialApp(
          title: 'Orditori',
          theme: ThemeData(
            brightness: value,
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ButtonStyle(
                padding: MaterialStateProperty.all(
                  const EdgeInsets.all(20.0),
                ),
                shape: MaterialStateProperty.all(
                  const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.0),
                    ),
                  ),
                ),
              ),
            ),
            inputDecorationTheme: InputDecorationTheme(
              border: InputBorder.none,
            ),
            cardTheme: const CardTheme(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(10.0),
                ),
              ),
            ),
          ),
          home: const Home(),
        );
      },
    );
  }
}

typedef ResultBuilder<T> = Widget Function(BuildContext context, T? value);
typedef ErrorBuilder<T> = Widget Function(BuildContext context, Object? err);

class _Provider<T> extends InheritedWidget {
  const _Provider({
    Key? key,
    required Widget child,
    required this.value,
  }) : super(key: key, child: child);

  final T? value;

  @override
  bool updateShouldNotify(_Provider<T> old) => value != old.value;
}

class AsyncWidget<T> extends StatefulWidget {
  final Future<T> Function() load;
  final Widget? child;
  final ResultBuilder<T>? builder;

  final Widget? error;
  final ErrorBuilder? errorBuilder;

  final Widget loading;

  const AsyncWidget({
    Key? key,
    required this.load,
    required this.loading,
    this.child,
    this.builder,
    this.error,
    this.errorBuilder,
  })  : assert(child != null || builder != null),
        assert(error != null || errorBuilder != null),
        super(key: key);

  static T? read<T>(BuildContext context) {
    final w = context.dependOnInheritedWidgetOfExactType<_Provider<T>>();
    return w?.value;
  }

  static final Map<Type, _AsyncWidgetState> _widgets = {};

  static void reload<T>() {
    final s = _widgets[T] as _AsyncWidgetState<T>?;
    s?._reload();
  }

  @override
  _AsyncWidgetState createState() => _AsyncWidgetState<T>();
}

enum AsyncState {
  loading,
  success,
  error,
}

class _AsyncWidgetState<T> extends State<AsyncWidget> {
  @override
  AsyncWidget<T> get widget => super.widget as AsyncWidget<T>;

  AsyncState _state = AsyncState.loading;

  T? value;
  Object? error;

  Widget _defaultBuilder(BuildContext _, T? __) => widget.child!;
  Widget _defaultErrorBuilder(BuildContext _, Object? __) => widget.error!;

  ResultBuilder<T> get builder => widget.builder ?? _defaultBuilder;
  ErrorBuilder get errorBuilder => widget.errorBuilder ?? _defaultErrorBuilder;

  bool _debugNeedsReload = true;

  @override
  void initState() {
    AsyncWidget._widgets[T] = this;

    _load();
    super.initState();
  }

  void _reload() {
    setState(() {
      _load();
    });
  }

  void _load() {
    _state = AsyncState.loading;

    widget
        .load()
        .then((value) => setState(() {
              _state = AsyncState.success;
              this.value = value;
            }))
        .catchError((err) => setState(() {
              _state = AsyncState.error;
              error = err;
            }));
  }

  @override
  void didUpdateWidget(covariant AsyncWidget oldWidget) {
    if (_debugNeedsReload) {
      setState(() => _load());
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    AsyncWidget._widgets.remove(T);
    super.dispose();
  }

  @override
  void reassemble() {
    _debugNeedsReload = false;
    super.reassemble();
    _debugNeedsReload = false;
  }

  @override
  Widget build(BuildContext context) {
    switch (_state) {
      case AsyncState.loading:
        return widget.loading;
      case AsyncState.success:
        return _Provider<T>(
          value: value,
          child: builder(context, value),
        );
      case AsyncState.error:
        return errorBuilder(context, error);
    }
  }
}

class LoadingIndicator extends StatelessWidget {
  final Color? color;
  final double? strokeWidth;

  const LoadingIndicator({
    Key? key,
    this.color,
    this.strokeWidth = 2.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation(color),
        strokeWidth: strokeWidth!,
      ),
    );
  }
}

final _tokenKey = Object();

String getToken(BuildContext context) {
  return SharedAppData.getValue<Object, String>(
    context,
    _tokenKey,
    () => '',
  );
}

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AsyncWidget<String>(
      load: () => SharedPreferences.getInstance().then((prefs) {
        final token = prefs.getString('token') ?? '';
        SharedAppData.setValue(context, _tokenKey, token);
        return token;
      }),
      loading: const SizedBox.shrink(),
      error: const Center(
        child: Material(child: Text('Failed to get token')),
      ),
      builder: (context, _) {
        final token = getToken(context);
        if (token.isEmpty) {
          return const TokenPrompt();
        }

        return Builder(
          builder: (context) {
            final token = getToken(context);

            return AsyncWidget<Response<NotebookR>>(
              load: () => _client.notebooksGet(apiKey: token),
              loading: const LoadingIndicator(),
              error: const Material(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Center(
                    child: Text("Something went wrong"),
                  ),
                ),
              ),
              child: const AppPages(),
            );
          },
        );
      },
    );
  }
}

class TokenPrompt extends StatelessWidget {
  const TokenPrompt({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ctrl = TextEditingController();

    return Scaffold(
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 500),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        autofocus: true,
                        controller: ctrl,
                        decoration: const InputDecoration(
                          hintText: 'API Token',
                          border: InputBorder.none,
                        ),
                        onSubmitted: (token) => SharedAppData.setValue(
                          context,
                          _tokenKey,
                          token,
                        ),
                      ),
                    ),
                    IconButton(
                      color: Theme.of(context).colorScheme.secondary,
                      icon: const Icon(Icons.paste),
                      onPressed: () async {
                        final data = await Clipboard.getData('text/plain');
                        if (data == null || data.text == null) return;
                        ctrl.text = data.text!;
                      },
                    ),
                  ],
                ),
                TextButton(
                  onPressed: () {
                    SharedAppData.setValue(context, _tokenKey, ctrl.text);
                    SharedPreferences.getInstance().then(
                      (value) => value.setString('token', ctrl.text),
                    );
                  },
                  child: const Text('Done'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// formats date to YYYY-MM-DD

String formatDate(DateTime date) {
  return DateFormat.MMMd().format(date);
}

class DefinitionsDateGroup {
  final String date;
  final List<NotebookEntryR> entries;

  DefinitionsDateGroup(this.date, this.entries);
}

class DateTile extends StatelessWidget {
  final String month;
  final String day;
  const DateTile({Key? key, required this.month, required this.day})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 40,
      child: Column(
        children: [
          Text(month),
          Text(day, style: Theme.of(context).textTheme.headline6),
        ],
      ),
    );
  }
}

class Notebooks extends StatelessWidget {
  final GlobalKey<NotebookEntriesListState>? notebooksKey;

  const Notebooks({
    Key? key,
    this.notebooksKey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final r = AsyncWidget.read<Response<NotebookR>>(context)!.body!;
    final g = r.entries!.fold<List<DefinitionsDateGroup>>([], (acc, v) {
      final date = formatDate(DateTime.parse(v.addedDate!));

      if (acc.isEmpty) {
        return [
          DefinitionsDateGroup(date, [v])
        ];
      }

      if (acc.last.date == date) {
        return [
          ...acc.take(acc.length - 1),
          DefinitionsDateGroup(date, [...acc.last.entries, v])
        ];
      }

      return [
        ...acc,
        DefinitionsDateGroup(date, [v])
      ];
    });

    final entries = g.reversed
        .expand((element) => element.entries.reversed)
        .where((element) => element.definitions?.isNotEmpty ?? false)
        .toList();

    final child = NotebookEntriesList(
      key: notebooksKey,
      entries: entries,
      notebookId: r.id!,
    );

    return child;
  }
}

class AppPages extends StatefulWidget {
  const AppPages({Key? key}) : super(key: key);

  @override
  State<AppPages> createState() => _AppPagesState();
}

class _AppPagesState extends State<AppPages> {
  int pageIndex = 0;
  late final ctrl = PageController(
    initialPage: getToken(context).isEmpty ? 1 : 0,
  );
  final _notebooksKey = GlobalKey<NotebookEntriesListState>();

  void _setPageIndex(int index) {
    setState(() {
      pageIndex = index;
    });

    if (ctrl.page != index) {
      ctrl.animateToPage(
        index,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    const navItems = [
      BottomNavigationBarItem(icon: Icon(Icons.book), label: 'Notes'),
      BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
    ];

    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: pageIndex,
        onTap: _setPageIndex,
        items: navItems,
      ),
      body: SafeArea(
        child: PageView(
          controller: ctrl,
          onPageChanged: _setPageIndex,
          children: [
            Notebooks(notebooksKey: _notebooksKey),
            const Settings(),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndDocked,
      floatingActionButton: pageIndex == 0
          ? FloatingActionButton(
              child: const Icon(Icons.search),
              onPressed: () {
                final r = MaterialPageRoute(
                  builder: (context) => Search(
                    notebookId: _notebooksKey.currentState!.notebookId,
                    entries: _notebooksKey.currentState!.entries,
                  ),
                );

                Navigator.of(context).push(r);
              },
            )
          : null,
    );
  }
}

class NotebookEntriesList extends StatefulWidget {
  final int notebookId;
  final List<NotebookEntryR> entries;
  const NotebookEntriesList({
    Key? key,
    required this.entries,
    required this.notebookId,
  }) : super(key: key);

  @override
  State<NotebookEntriesList> createState() => NotebookEntriesListState();
}

class NotebookEntriesListState extends State<NotebookEntriesList> {
  List<NotebookEntryR> get entries => widget.entries;
  int get notebookId => widget.notebookId;

  @override
  Widget build(BuildContext context) {
    return AnimatedList(
      reverse: true,
      padding: const EdgeInsets.only(bottom: 20),
      initialItemCount: widget.entries.length,
      itemBuilder: (context, index, _) {
        final item = widget.entries[index];
        final nextItem = index == widget.entries.length - 1
            ? null
            : widget.entries[index + 1];

        final date = formatDate(DateTime.parse(item.addedDate!));
        final nextDate =
            formatDate(DateTime.parse((nextItem ?? item).addedDate!));

        Widget leading = const SizedBox(width: 40);

        if (nextDate != date || nextItem == null) {
          final ch = date.split(' ');
          leading = DateTile(month: ch[0], day: ch[1]);
        }

        final def = item.definitions!.first;

        return DefinitionTile(def: def, leading: leading);
      },
    );
  }
}

class DefinitionTile extends StatelessWidget {
  final DefinitionContentItemR def;
  final Widget? leading;

  const DefinitionTile({
    Key? key,
    required this.def,
    this.leading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: leading,
      title: Row(
        children: [
          Chip(label: Text(def.language!.code!)),
          const SizedBox(width: 8),
          SelectableText(def.word!)
        ],
      ),
      subtitle: Padding(
        padding: const EdgeInsets.only(left: 60.0),
        child: SelectableText(def.definition!),
      ),
    );
  }
}

class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key);

  void _setDarkMode(bool isDarkMode) {
    SharedPreferences.getInstance()
        .then((p) => p.setString('brightness', isDarkMode ? 'dark' : 'light'))
        .then((value) => AsyncWidget.reload<Brightness>());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Builder(
            builder: (context) {
              final isDarkMode =
                  AsyncWidget.read<Brightness>(context)! == Brightness.dark;

              return ListTile(
                onTap: () {
                  _setDarkMode(!isDarkMode);
                },
                title: const Text('Dark Mode'),
                leading: Icon(isDarkMode
                    ? Icons.dark_mode_sharp
                    : Icons.dark_mode_outlined),
                trailing: Switch(
                  value: isDarkMode,
                  onChanged: (v) {
                    _setDarkMode(v);
                  },
                ),
              );
            },
          ),
          ListTile(
            title: const Text('API Key'),
            subtitle: Text(
              getToken(context),
              maxLines: 1,
            ),
            leading: const Icon(Icons.vpn_key),
            trailing: IconButton(
              onPressed: () {
                SharedAppData.setValue(context, _tokenKey, '');
                SharedPreferences.getInstance().then(
                  (value) => value.setString('token', ''),
                );
              },
              icon: const Icon(Icons.delete),
            ),
          ),
        ],
      ),
    );
  }
}

class DefTile extends StatelessWidget {
  final Definition def;
  final bool isSaved;
  final VoidCallback onBookmarkPressed;

  const DefTile({
    Key? key,
    required this.def,
    required this.isSaved,
    required this.onBookmarkPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16).copyWith(bottom: 8),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Chip(label: Text(def.language!.code!)),
                const SizedBox(width: 8),
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: SelectableText(def.definition!),
                )),
                const SizedBox(width: 16),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: GestureDetector(
                    onTap: onBookmarkPressed,
                    child: Icon(
                      isSaved
                          ? Icons.bookmark_added_sharp
                          : Icons.bookmark_add_outlined,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
              ],
            ),
            if (def.examples?.isNotEmpty ?? false)
              Padding(
                padding: const EdgeInsets.all(8.0).copyWith(bottom: 0),
                child: IntrinsicHeight(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Divider(),
                      SizedBox(height: 8),
                      Text(
                        'Examples:',
                        style: Theme.of(context).textTheme.subtitle2,
                      ),
                      ...(def.examples!.map(
                        (e) => Padding(
                          padding:
                              const EdgeInsets.all(8.0).copyWith(bottom: 0),
                          child: Text(
                            e.$String!,
                            style: const TextStyle(fontStyle: FontStyle.italic),
                          ),
                        ),
                      )),
                      const SizedBox(height: 8),
                    ],
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}

class Search extends StatefulWidget {
  final int notebookId;
  final List<NotebookEntryR> entries;

  const Search({
    Key? key,
    required this.entries,
    required this.notebookId,
  }) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  bool hasResult = false;
  bool isSearching = false;
  List<Definition> items = [];
  String? error;
  NotebookEntryR? entry;
  Set<String> defsSet = {};

  final ctrl = TextEditingController();

  Future<void> _search() async {
    setState(() {
      isSearching = true;
      items = [];
      error = null;
      hasResult = false;
      entry = null;
      defsSet = {};
    });

    try {
      final res = await _client.definitionsGet(query: ctrl.text);

      setState(() {
        items = res.body!;
        hasResult = true;
        isSearching = false;

        try {
          entry = widget.entries.firstWhere(
            (element) => element.definitions!.first.word == ctrl.text,
          );

          _buildDefinitionsMap();
        } catch (err) {
          entry = null;
          defsSet = {};
        }
      });
    } catch (err) {
      setState(() {
        error = err.toString();
        isSearching = false;
        entry = null;
        defsSet = {};
      });
    }
  }

  void _buildDefinitionsMap() {
    defsSet =
        entry!.definitions!.fold<Set<String>>({}, (previousValue, element) {
      return {
        ...previousValue,
        element.definition!,
      };
    });
  }

  Future<void> _addEntry() async {
    final d = DateTime.now().toIso8601String().substring(0, 23) + 'Z';

    final res = await _client.notebookEntriesPost(
      apiKey: getToken(context),
      body: NotebookEntryW(
        addedDate: d,
        notebook: widget.notebookId,
      ),
    );

    setState(() {
      entry = NotebookEntryR(
        addedDate: d,
        definitions: [],
        id: res.body!,
      );

      _buildDefinitionsMap();
    });
  }

  Future<void> _addDefinition(Definition def) async {
    if (entry == null) await _addEntry();

    final body = DefinitionContentItemW(
      word: def.word,
      definition: def.definition,
      entry: entry!.id,
      language: def.language,
    );

    try {
      final res = await _client.definitionContentItemsPost(
        apiKey: getToken(context),
        body: body,
      );

      entry!.definitions!.add(DefinitionContentItemR(
        id: res.body!,
        definition: def.definition,
        language: def.language,
        word: def.word,
      ));

      _buildDefinitionsMap();

      AsyncWidget.reload<Response<NotebookR>>();

      setState(() {});
    } catch (err) {
      setState(() {
        error = err.toString();
        isSearching = false;
        entry = null;
        defsSet = {};
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0).copyWith(top: 0),
              child: Row(
                children: [
                  BackButton(),
                  Expanded(
                    child: TextField(
                      controller: ctrl,
                      autofocus: true,
                      onSubmitted: (_) => _search(),
                      decoration: InputDecoration(hintText: 'Search'),
                    ),
                  ),
                  TextButton(
                    child: Text('Cancel'),
                    onPressed: () {
                      ctrl.clear();
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              child: error != null
                  ? Center(child: Text(error!))
                  : hasResult && items.isNotEmpty
                      ? ListView.builder(
                          itemCount: items.length,
                          itemBuilder: (context, index) {
                            final def = items[index];
                            final isSaved = defsSet.contains(def.definition);

                            return DefTile(
                              def: def,
                              isSaved: isSaved,
                              onBookmarkPressed: () {
                                if (isSaved) return;
                                _addDefinition(def);
                              },
                            );
                          },
                        )
                      : hasResult
                          ? Center(
                              child: Text('Nothing found for "${ctrl.text}"'))
                          : const SizedBox(),
            ),
            ValueListenableBuilder<TextEditingValue>(
              valueListenable: ctrl,
              builder: (context, value, _) {
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ElevatedButton(
                    onPressed: value.text.isEmpty ? null : _search,
                    child: SizedBox(
                      height: 16,
                      width: isSearching ? 16 : null,
                      child: isSearching
                          ? const LoadingIndicator(
                              color: Colors.white,
                              strokeWidth: 1,
                            )
                          : const Text('Search'),
                    ),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
