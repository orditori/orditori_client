import 'dart:async';
import 'dart:convert';
import 'package:fetch/fetch.dart';
import 'package:intl/intl.dart';

import 'package:flutter/material.dart';

void main() {
  FetchConfig.setBaseUrl('http://3.127.125.21/');

  runApp(Orditori());
}

class Orditori extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
      ),
      home: Home(),
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
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => Settings()));
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
  late final notebooks = fetch(
    '/notebooks?key=9f34ff36-990d-43f0-ba76-9a395a9d7c84',
  )
      .then((value) => value.json())
      .then((r) => json.decode(r['contents'])['values'][0]['entries']);

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

class Settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
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
