import 'dart:async';
import 'dart:convert';
import 'package:fetch/fetch.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  @override
  _NotebooksState createState() => _NotebooksState();
}

class _NotebooksState extends State<Notebooks> {
  late final token;
  late final Future<dynamic> notebooks = readToken().then((t) {
    token = t!;

    return fetch(
      '/notebooks?key=$t',
    )
        .then((value) => value.json())
        .then((r) => json.decode(r['contents'])['values'][0]['entries']);
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: notebooks,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (snapshot.hasData) {
          final items = snapshot.data! as List;
          return Column(
            children: [
              Expanded(
                child: NotesList(notes: items),
              ),
              SearchBar(onPicked: (word, _def) async {
                final def = {
                  'values': [
                    {
                      'definition': _def,
                      'addedDate': DateTime.now().toIso8601String(),
                      'word': {
                        'tag': 'Word',
                        'values': [
                          {
                            'language': _def['language'],
                            'string': word,
                          }
                        ]
                      }
                    }
                  ],
                  'tag': 'Entry',
                };

                final body = json.encode({
                  'contents': json.encode({
                    'tag': 'Notebook',
                    'values': [
                      {
                        'entries': [
                          ...items,
                          def,
                        ],
                      }
                    ]
                  }),
                  'key': token,
                });

                await fetch('/notebooks', method: 'POST', body: body, headers: {
                  'content-type': 'application/json',
                });

                (snapshot.data as List).add(def);
                setState(() {});
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
  final Function(String word, dynamic) onPicked;

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
          .then((res) => res.json());
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
            label: Text('Search'),
            onPressed: _search,
          )
        ],
      ),
    );
  }
}

class DefPicker extends StatelessWidget {
  final List<dynamic> defs;

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
              return InkWell(
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0).copyWith(right: 0),
                        child:
                            Text((defs[index]['definition'] as String).trim()),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Chip(
                        label: Text(defs[index]['language']['code']),
                      ),
                    ),
                  ],
                ),
                onTap: () {
                  Navigator.of(context).pop(defs[index]);
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

class NotesList extends StatefulWidget {
  final List<dynamic> notes;

  const NotesList({Key? key, required this.notes}) : super(key: key);
  @override
  _NotesListState createState() => _NotesListState();
}

class _NotesListState extends State<NotesList> {
  var prevDate;
  final ctrl = ScrollController();

  @override
  Widget build(BuildContext context) {
    final items = widget.notes.reversed.toList();

    return ListView.builder(
        controller: ctrl,
        itemCount: items.length,
        reverse: true,
        itemBuilder: (context, index) {
          final item = items[index]['values'][0];
          final def = item['definition'];
          Widget leading = SizedBox(width: 50);
          final date = _fmt.format(DateTime.parse(item['addedDate']));

          if (prevDate != date) {
            leading = DateTile(date: DateTime.parse(item['addedDate']));
          }

          prevDate = date;

          return ListTile(
            leading: leading,
            trailing: Chip(
              label: Text(def['language']['code']),
            ),
            title: Text(item['word']['values'][0]['string']),
            subtitle: Text((def['definition'] as String)),
            isThreeLine: true,
          );
        });
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
    return Container(
      width: 50,
      child: Column(
        children: [
          Text(
            _month.format(date),
          ),
          SizedBox(height: 8),
          Text(
            _day.format(date),
            style: Theme.of(context).textTheme.headline6,
          ),
        ],
      ),
    );
  }
}
