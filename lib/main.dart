import 'dart:async';
import 'dart:convert';
import 'package:fetch/fetch.dart';
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
        brightness: Brightness.dark,
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
  late final notebooks = readToken().then((t) => fetch(
        '/notebooks?key=$t',
      )
          .then((value) => value.json())
          .then((r) => json.decode(r['contents'])['values'][0]['entries']));

  @override
  Widget build(BuildContext context) {
    var prevDate;

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
          return ListView.builder(
              itemCount: items.length,
              reverse: false,
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
        } else if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        } else {
          return Text('No notebooks');
        }
      },
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
