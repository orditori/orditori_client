import 'dart:convert';

import 'package:fetch/fetch.dart' hide Response;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:orditori/models/definition.dart';
import 'package:orditori/models/notebookentry.dart';
import 'package:microfrontends/microfrontends.dart';
import 'package:orditori/notes/notebooks_state.dart';
import 'package:orditori/notes/notebooks_state_binding.dart';

import 'notes_list.dart';
import 'searchbar.dart';

class Notebooks extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return context.subscribe<NotebookState>(
      child: Column(
        children: [
          Expanded(child: NotesList()),
          SearchBar(),
        ],
      ),
      builder: (context, state, child) {
        if (state is LoadingNotebookState) {
          return Center(child: CircularProgressIndicator());
        }

        final items = state.entries;

        if (items.isEmpty) {
          return Center(child: Text('No notebooks'));
        }

        return child!;
      },
    );
  }
}
