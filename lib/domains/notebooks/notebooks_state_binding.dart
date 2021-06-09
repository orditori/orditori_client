import 'dart:convert';

import 'package:fetch/fetch.dart' hide Response;
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:microfrontends/microfrontends.dart';
import 'package:orditori/domains/auth/binding.dart';
import 'package:orditori/models/definition.dart';
import 'package:orditori/models/notebookentry.dart';
import 'package:orditori/models/response.dart';
import 'package:orditori/domains/notebooks/notebooks_state.dart';

class DeleteNote extends Mutation<int> {
  DeleteNote(int payload) : super(payload);
}

class AddDefinition extends Mutation<Definition> {
  AddDefinition(Definition payload) : super(payload);
}

final fmt = DateFormat('yyyy-MM-ddTHH:mm:ss.mmm');

class NotebooksStateBinding extends Binding<NotebookState> {
  NotebooksStateBinding({Key? key, required Widget child})
      : super(key: key, child: child);

  deleteEntry(String token, NotebookState state, DeleteNote mutation) {
    return () async* {
      await fetch(
        '/notebookEntries/${mutation.payload}/?apiKey=$token',
        method: 'DELETE',
      );

      yield state.copyWith(
        entries: [
          ...state.entries
              .where((element) => element.id != mutation.payload)
              .toList()
        ],
      );
    };
  }

  @override
  StateContainer<NotebookState> create(BuildContext context) {
    final token = context.query<Token>()!.payload;

    return container(LoadingNotebookState())
      ..boot((context) async* {
        final r = await fetch('/notebooks?apiKey=$token');
        final data = await r.json();
        final res = Response.fromJson(data);
        yield NotebookState(id: res.id, entries: res.entries);
      })
      ..query<List<NotebookEntry>>((ctrl, state, params) => state.entries)
      ..mutation<DeleteNote>((ctrl, state, mutation) {
        final token = context.query<Token>();
        ctrl.run(deleteEntry(token!.payload, state, mutation!));
        return state;
      })
      ..mutation<AddDefinition>((ctrl, state, m) {
        ctrl.run(() async* {
          final date = fmt.format(DateTime.now().toUtc());

          final entry = {
            'addedDate': '${date}Z',
            'notebook': state.id,
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
              ...m!.payload.toJson(),
              'entry': entryId,
            }),
          ).then((value) => value.json());

          final e = NotebookEntry(
            addedDate: date,
            id: entryId,
            definitions: [m.payload],
          );

          yield state.copyWith(entries: [...state.entries, e]);
        });

        return state;
      });
  }
}
