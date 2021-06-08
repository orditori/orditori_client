import 'package:fetch/fetch.dart';
import 'package:flutter/widgets.dart';
import 'package:microfrontends/microfrontends.dart';
import 'package:orditori/auth/binding.dart';
import 'package:orditori/models/notebookentry.dart';
import 'package:orditori/notes/notebooks_state.dart';

class DeleteNote extends Mutation<int> {
  DeleteNote(int payload) : super(payload);
}

class NotebooksStateBinding extends Binding<NotebookState> {
  NotebooksStateBinding({required Widget child}) : super(child: child);

  deleteEntry(String token, NotebookState state, DeleteNote mutation) {
    return () async* {
      await fetch(
        '/notebookEntries/${mutation.payload}/?apiKey=$token',
        method: 'DELETE',
      );
      final entries = state.entries
        ..removeWhere((element) => element.id == mutation.payload);

      yield state.copyWith(entries: entries);
    };
  }

  @override
  StateContainer<NotebookState> create(BuildContext context) {
    return container(LoadingNotebookState())
      ..boot((context) async* {})
      ..query<List<NotebookEntry>>((ctrl, state, params) => state.entries)
      ..mutation<DeleteNote>((ctrl, state, mutation) {
        final token = context.query<Token>();
        ctrl.run(deleteEntry(token!.payload, state, mutation!));
        return state;
      });
  }
}
