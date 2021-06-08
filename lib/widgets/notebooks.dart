import 'dart:convert';

import 'package:fetch/fetch.dart' hide Response;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:orditori/models/definition.dart';
import 'package:orditori/models/notebookentry.dart';
import 'package:orditori/models/response.dart';

import 'notes_list.dart';
import 'searchbar.dart';

class Notebooks extends StatefulWidget {
  const Notebooks({Key? key}) : super(key: key);
  @override
  _NotebooksState createState() => _NotebooksState();
}

class _NotebooksState extends State<Notebooks> {
  // late String token;

  // @override
  // void initState() {
  //   loadReq.addListener(_load);
  //   super.initState();
  // }

  // @override
  // dispose() {
  //   loadReq.removeListener(_load);
  //   super.dispose();
  // }

  // Future<Response> _load() {
  //   return readToken().then((t) {
  //     token = t!;
  //     final r = fetch(
  //       '/notebooks?apiKey=$t',
  //     ).then((value) => value.json()).then((r) => Response.fromJson(r));

  //     r.whenComplete(() => setState(() {}));

  //     return r;
  //   });
  // }

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
                child: NotesList(),
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
