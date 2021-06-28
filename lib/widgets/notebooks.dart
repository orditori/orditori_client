import 'package:flutter/material.dart';
import 'package:microfrontends/microfrontends.dart';
import 'package:orditori/domains/auth/state.dart';
import 'package:orditori/domains/notebooks/state.dart';
import 'package:orditori/domains/search/state.dart';
import 'package:orditori/domains/search/state_container.dart';
import 'package:orditori/widgets/def_picker.dart';

import 'notes_list.dart';
import 'searchbar.dart';

class Notebooks extends StatelessWidget {
  showDefsPicker(BuildContext context, DefinitionsSearchState state) async {
    await showModalBottomSheet(
      context: context,
      builder: (_) {
        final defs = state.definitiaons;

        return DefPicker(defs: defs)
            .withContainer<NotebookState>(context)
            .withContainer<AuthState>(context);
      },
    );

    context.mutation(ResetSearch());
  }

  @override
  Widget build(BuildContext context) {
    final e = Effect<Async<DefinitionsSearchState>>((context, value) {
      showDefsPicker(
        context,
        (value as Loaded<DefinitionsSearchState>).state,
      );
    })
      ..whenType<Loaded<DefinitionsSearchState>>();

    return context.subscribe<NotebookState>(
      child: Column(
        children: [
          Expanded(child: NotesList()),
          SearchStateContainer().mount(
            builder: (context) {
              e.bind(context);
              return SearchBar<DefinitionsSearchState>();
            },
          ),
        ],
      ),
      builder: (context, state, child) {
        if (state is LoadingNotebookState) {
          return Center(child: CircularProgressIndicator());
        }

        return child!;
      },
    );
  }
}
