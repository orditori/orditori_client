import 'package:chopper/chopper.dart';
import 'package:flutter/material.dart';
import 'package:orditori/framework.dart';
import 'package:orditori/notebooks/notebooks_screen.dart';

import 'package:orditori/search/search_bar.dart';
import 'package:orditori/search/search_button.dart';
import 'package:orditori/services.dart';
import 'package:orditori/swagger_generated_code/orditori.swagger.dart';
import 'package:orditori/widgets/async_widget.dart';

import 'search_results.dart';

class SearchScreen extends StatefulWidget {
  final VoidCallback onExit;
  const SearchScreen({
    Key? key,
    required this.onExit,
  }) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  bool hasResult = false;
  List<DefinitionsWithSource> items = [];
  String? error;
  NotebookEntryR? entry;
  Set<String> defsSet = {};

  final query = LateReceive<TextEditingValue>();
  late final text = query.map((data) => data.text);

  late final submit = Broadcast.statusStreamGenerator(_search, text);

  Stream<Status<List<DefinitionsWithSource>>> _search(String query) async* {
    if (query.isEmpty) {
      return;
    }

    yield const StatusInProgress();

    setState(() {
      items = [];
      error = null;
      hasResult = false;
      entry = null;
      defsSet = {};
    });

    try {
      final res = await client.definitionsGet(query: query);
      bool ok = false;

      setState(() {
        items = res.body!;
        hasResult = true;

        try {
          entry = Notebooks.widgetKey.currentState!.entries.firstWhere(
            (element) => element.definitions!.first.word == query,
          );

          _buildDefinitionsMap();
        } catch (err) {
          entry = null;
          defsSet = {};
        }

        ok = true;
      });

      if (ok) {
        yield StatusOk(items);
      }
    } catch (err) {
      yield StatusError(err);
      setState(() {
        error = err.toString();
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
    final d = '${DateTime.now().toIso8601String().substring(0, 23)}Z';

    final res = await client.notebookEntriesPost(
      apiKey: Auth.getToken(context),
      body: NotebookEntryW(
        addedDate: d,
        notebook: Notebooks.widgetKey.currentState!.notebookId,
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

  Future<void> _addDefinition(
      Definition def, int sourceId, String sourceLink) async {
    if (entry == null) await _addEntry();

    final body = DefinitionContentItemW(
      word: def.word,
      definition: def.definition,
      entry: entry!.id,
      language: def.language,
      definitionSource: sourceId,
      sourceLink: sourceLink,
    );

    try {
      final res = await client.definitionContentItemsPost(
        // ignore: use_build_context_synchronously
        apiKey: Auth.getToken(context),
        body: body,
      );

      entry!.definitions!.add(DefinitionContentItemR(
          id: res.body!,
          definition: def.definition,
          language: def.language,
          word: def.word,
          definitionSource: sourceId));

      _buildDefinitionsMap();

      AsyncWidget.reload<Response<NotebookR>>();

      setState(() {});
    } catch (err) {
      setState(() {
        error = err.toString();
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
            SearchBar(
              query: query,
              querySubmit: submit,
              onExit: widget.onExit,
            ),
            Expanded(
              child: SearchResults(
                items: items,
                query: query,
                definitionsSet: defsSet,
                error: error,
                hasResult: hasResult,
                onAdd: _addDefinition,
              ),
            ),
            SearchButton(
              query: query,
              submit: submit,
            ),
          ],
        ),
      ),
    );
  }
}
