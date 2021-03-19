import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:fetch/fetch.dart' hide Response;
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import 'package:flutter/material.dart';
import 'package:orditori/model/notebookentry.dart';
import 'package:orditori/model/response.dart';
import 'package:shared_preferences/shared_preferences.dart';

import './model/response.dart';
import 'model/definition.dart';
import 'model/language.dart';

void main() {
  FetchConfig.setBaseUrl('http://3.127.125.21/');

  runApp(Orditori());
}

Future<String?> readToken() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString('api_key');
}

class Orditori extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        accentColor: Colors.pink,
        brightness: Brightness.dark,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(32),
              ),
            ),
          ),
        ),
        bottomSheetTheme: BottomSheetThemeData(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
          ),
        ),
      ),
      home: FutureBuilder(
        future: readToken(),
        builder: (context, AsyncSnapshot<String?> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            final apiKey = snapshot.data;

            if (apiKey == null) {
              return Settings();
            } else {
              return Home();
            }
          } else if (snapshot.hasError) {
            return Text(snapshot.data.toString());
          } else {
            return Container();
          }
        },
      ),
    );
  }
}

final loadReq = ValueNotifier<double>(0.0);
final _r = Random();

void reloadNotebooks() {
  var v = _r.nextDouble();
  while (loadReq.value == v) {
    v = _r.nextDouble();
  }

  loadReq.value = v;
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => Settings(),
                ),
              );
            },
          ),
        ],
        title: Text("Orditori"),
      ),
      body: Notebooks(),
    );
  }
}

final _fmt = DateFormat.yMd();

class Notebooks extends StatefulWidget {
  const Notebooks({Key? key}) : super(key: key);
  @override
  _NotebooksState createState() => _NotebooksState();
}

class _NotebooksState extends State<Notebooks> {
  late String token;
  late final notebooks = _load();

  @override
  void initState() {
    loadReq.addListener(_load);
    super.initState();
  }

  @override
  dispose() {
    loadReq.removeListener(_load);
    super.dispose();
  }

  Future<Response> _load() {
    return readToken().then((t) {
      token = t!;
      final r = fetch(
        '/notebooks?apiKey=$t',
      ).then((value) => value.json()).then((r) => Response.fromJson(r));

      r.whenComplete(() => setState(() {}));

      return r;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: notebooks,
      builder: (context, AsyncSnapshot<Response> snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (snapshot.hasData) {
          final items = snapshot.data!.entries;

          return Column(
            children: [
              Expanded(
                child: NotesList(
                  notes: items,
                  token: token,
                ),
              ),
              SearchBar(onPicked: (String word, Definition _def) async {
                final f = DateFormat('yyyy-MM-ddTHH:mm:ss.mmm');
                final date = f.format(DateTime.now().toUtc());

                final entry = {
                  'addedDate': '${date}Z',
                  'notebook': snapshot.data!.id,
                };

                final entryId = await fetch(
                  '/notebookEntries?apiKey=$token',
                  method: 'POST',
                  body: json.encode(entry),
                  headers: {'content-type': 'application/json'},
                ).then((res) => res.json());

                await fetch(
                  '/definitionContentItems?apiKey=$token',
                  headers: {'content-type': 'application/json'},
                  method: 'POST',
                  body: json.encode({
                    ..._def.toJson(),
                    'entry': entryId,
                  }),
                ).then((value) => value.json()).then(print);

                setState(() {
                  snapshot.data!.entries.add(
                    NotebookEntry(
                      addedDate: date,
                      id: entryId,
                      definitions: [_def],
                    ),
                  );
                });
              }),
            ],
          );
        } else if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        } else {
          return Text('No notebooks');
        }
      },
    );
  }
}

class SearchBar extends StatefulWidget {
  final Function(String word, Definition def) onPicked;

  const SearchBar({Key? key, required this.onPicked}) : super(key: key);
  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  bool isSearching = false;
  final ctrl = TextEditingController();

  _search() async {
    if (ctrl.text.isEmpty) return;

    setState(() {
      isSearching = true;
    });

    try {
      final data = await fetch('/definitions?query=${ctrl.text}')
          .then((res) => res.json())
          .then(
            (json) => List<Definition>.from(
              json.map(
                (d) => Definition.fromJson(d),
              ),
            ),
          );
      final word = ctrl.text;

      ctrl.clear();
      final def = await showModalBottomSheet(
          context: context,
          builder: (context) {
            return DefPicker(defs: data);
          });

      if (def != null) {
        widget.onPicked(word, def);
      }
    } catch (err) {
      print(err);
    }

    setState(() {
      isSearching = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: ctrl,
              keyboardAppearance: Brightness.dark,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                hintText: 'Type a word',
                border: InputBorder.none,
              ),
              onSubmitted: (_) => _search(),
              textInputAction: TextInputAction.search,
            ),
          ),
          ElevatedButton.icon(
            icon: isSearching
                ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(
                        strokeWidth: 1,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    ),
                  )
                : Icon(Icons.search),
            label: Text(
              'Search',
              style: TextStyle(height: 1),
            ),
            onPressed: _search,
          )
        ],
      ),
    );
  }
}

class DefPicker extends StatelessWidget {
  final List<Definition> defs;

  const DefPicker({Key? key, required this.defs}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return defs.length > 0
        ? ListView.separated(
            padding: const EdgeInsets.only(top: 16),
            separatorBuilder: (context, index) {
              return Container(height: 1, color: Colors.white.withAlpha(10));
            },
            itemCount: defs.length,
            itemBuilder: (context, index) {
              final def = defs[index];
              return InkWell(
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0).copyWith(right: 0),
                        child: Text(def.definition.trim()),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Chip(
                        label: Text(def.language.code),
                      ),
                    ),
                  ],
                ),
                onTap: () {
                  Navigator.of(context).pop(def);
                },
              );
            },
          )
        : Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 32),
            child: Text('No results'),
          );
  }
}

class DateGroup {
  late final String? date;
  late final List<NotebookEntry> entries;
}

class NotesList extends StatefulWidget {
  final List<NotebookEntry> notes;
  final String token;

  const NotesList({Key? key, required this.notes, required this.token})
      : super(key: key);
  @override
  _NotesListState createState() => _NotesListState();
}

class _NotesListState extends State<NotesList> {
  var prevDate;
  final ctrl = ScrollController();
  late List<NotebookEntry> notes = widget.notes;

  @override
  Widget build(BuildContext context) {
    final items = notes.reversed.toList();

    final groupedByDate =
        items.fold<List<DateGroup>>([], (previousValue, element) {
      final k = _fmt.format(DateTime.parse(element.addedDate));

      if (previousValue.isEmpty) {
        previousValue.add(DateGroup()
          ..date = k
          ..entries = [element]);
        return previousValue;
      }

      if (previousValue.last.date == k) {
        previousValue.last.entries.add(element);
        return previousValue;
      }

      previousValue.add(
        DateGroup()
          ..date = k
          ..entries = [element],
      );

      return previousValue;
    }).toList();

    return ListView.separated(
        controller: ctrl,
        reverse: true,
        itemCount: groupedByDate.length,
        separatorBuilder: (context, index) {
          return Container(height: 1, color: Colors.white.withAlpha(10));
        },
        itemBuilder: (context, index) {
          final g = groupedByDate[index];
          final entries = g.entries.reversed
              .toList()
              .where((e) => e.definitions.isNotEmpty)
              .toList();

          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: DateTile(
                    date: _fmt.parse(g.date!),
                  ),
                ),
                Expanded(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        for (int i = 0; i < entries.length; i++) ...[
                          WordTile(
                            language: entries[i].definitions.first.language,
                            word: entries[i].definitions.first.word,
                            definition: entries[i].definitions.first.definition,
                            examples: entries[i]
                                .definitions
                                .first
                                .examples
                                .map((e) => e.string)
                                .toList(),
                            onDelete: () async {
                              await fetch(
                                '/notebookEntries/${entries[i].id}/?apiKey=${widget.token}',
                                method: 'DELETE',
                              );

                              Navigator.of(context).pop();
                              await Future.delayed(Duration(milliseconds: 300));

                              setState(() {
                                notes = notes
                                  ..removeWhere(
                                      (element) => element.id == entries[i].id);
                              });
                            },
                          ),
                          if (i != entries.length - 1) Divider(),
                        ]
                      ]),
                ),
              ],
            ),
          );
        });
  }
}

class WordTile extends StatelessWidget {
  final String word;
  final String definition;
  final List<String> examples;
  final Language? language;
  final VoidCallback? onDelete;

  const WordTile({
    Key? key,
    required this.word,
    required this.definition,
    required this.examples,
    this.language,
    this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        showModalBottomSheet(
          context: context,
          builder: (context) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    title: Text('Delete'),
                    leading: Icon(Icons.delete),
                    onTap: onDelete,
                  ),
                ],
              ),
            );
          },
        );
      },
      child: Container(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(word, style: textTheme.headline6),
                  SizedBox(height: 6.0),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 4.0),
                        child: Text('≝', style: TextStyle(fontSize: 30)),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 4.0, left: 8.0),
                          child: Text(definition, style: textTheme.bodyText2),
                        ),
                      ),
                    ],
                  ),
                  if (examples.isNotEmpty)
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Icon(Icons.format_quote_outlined, size: 17),
                        ),
                        Expanded(
                          child: Text(examples[0]),
                        ),
                      ],
                    )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Chip(
                label: Text(language?.code ?? '???'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () {
            Navigator.of(context).maybePop().then((value) => {
                  if (!value)
                    {
                      Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (c) => Home()))
                    }
                });
          },
        ),
        title: Text('Settings'),
      ),
      body: Column(
        children: [
          FutureBuilder(
              future: readToken(),
              builder: (context, snapshot) {
                return ListTile(
                  title: Text("API Key"),
                  subtitle: snapshot.data != null
                      ? Text(
                          snapshot.data.toString(),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        )
                      : null,
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.paste),
                        tooltip: 'Paste',
                        onPressed: () async {
                          final token = await Clipboard.getData('text/plain');
                          final prefs = await SharedPreferences.getInstance();
                          if (token?.text != null) {
                            await prefs.setString('api_key', token!.text!);
                          }

                          setState(() {});
                          reloadNotebooks();
                        },
                      ),
                      IconButton(
                        tooltip: 'Copy',
                        icon: Icon(Icons.copy),
                        onPressed: () async {
                          await Clipboard.setData(
                            ClipboardData(text: snapshot.data!.toString()),
                          );

                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("Token copied!")));
                        },
                      )
                    ],
                  ),
                );
              }),
        ],
      ),
    );
  }
}

final _month = DateFormat('MMM');
final _day = DateFormat('dd');

class DateTile extends StatelessWidget {
  final DateTime date;

  const DateTile({Key? key, required this.date}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final color = textTheme.headline4!.color;
    return Container(
      width: 70,
      child: Column(
        children: [
          Text(
            _month.format(date),
            style: textTheme.subtitle1!.copyWith(color: color),
          ),
          SizedBox(height: 8),
          Text(
            _day.format(date),
            style: textTheme.headline5!.copyWith(color: color),
          ),
        ],
      ),
    );
  }
}
