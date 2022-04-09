import 'package:chopper/chopper.dart';
import 'package:flutter/material.dart';
import 'package:orditori/services.dart';
import 'package:orditori/swagger_generated_code/orditori.swagger.dart';
import 'package:orditori/widgets/async_widget.dart';
import 'package:orditori/widgets/loading_indicator.dart';

import 'search_results.dart';

class SearchScreen extends StatefulWidget {
  final int notebookId;
  final List<NotebookEntryR> entries;

  const SearchScreen({
    Key? key,
    required this.entries,
    required this.notebookId,
  }) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  bool hasResult = false;
  bool isSearching = false;
  List<DefinitionsWithSource> items = [];
  String? error;
  NotebookEntryR? entry;
  Set<String> defsSet = {};

  final ctrl = TextEditingController();

  Future<void> _search() async {
    if (ctrl.text.isEmpty) {
      return;
    }

    setState(() {
      isSearching = true;
      items = [];
      error = null;
      hasResult = false;
      entry = null;
      defsSet = {};
    });

    try {
      final res = await client.definitionsGet(query: ctrl.text);

      setState(() {
        items = res.body!;
        hasResult = true;
        isSearching = false;

        try {
          entry = widget.entries.firstWhere(
            (element) => element.definitions!.first.word == ctrl.text,
          );

          _buildDefinitionsMap();
        } catch (err) {
          entry = null;
          defsSet = {};
        }
      });
    } catch (err) {
      setState(() {
        error = err.toString();
        isSearching = false;
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
    final d = DateTime.now().toIso8601String().substring(0, 23) + 'Z';

    final res = await client.notebookEntriesPost(
      apiKey: Auth.getToken(context),
      body: NotebookEntryW(
        addedDate: d,
        notebook: widget.notebookId,
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
        isSearching = false;
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
            Padding(
              padding: const EdgeInsets.all(16.0).copyWith(top: 0),
              child: Row(
                children: [
                  BackButton(),
                  Expanded(
                    child: TextField(
                      controller: ctrl,
                      autofocus: true,
                      onSubmitted: (_) => _search(),
                      decoration: InputDecoration(hintText: 'Search'),
                    ),
                  ),
                  ValueListenableBuilder<TextEditingValue>(
                    valueListenable: ctrl,
                    builder: (context, value, _) {
                      return AnimatedOpacity(
                        opacity: value.text.isEmpty ? 0 : 1,
                        duration: const Duration(milliseconds: 200),
                        child: TextButton(
                          child: Text('Clear'),
                          onPressed: () {
                            ctrl.clear();
                          },
                        ),
                      );
                    },
                  )
                ],
              ),
            ),
            Expanded(
              child: SearchResults(
                items: items,
                query: ctrl.text,
                definitionsSet: defsSet,
                error: error,
                hasResult: hasResult,
                onAdd: _addDefinition,
              ),
            ),
            ValueListenableBuilder<TextEditingValue>(
              valueListenable: ctrl,
              builder: (context, value, _) {
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ElevatedButton(
                    onPressed: value.text.isEmpty ? null : _search,
                    child: SizedBox(
                      height: 16,
                      width: isSearching ? 16 : null,
                      child: isSearching
                          ? const LoadingIndicator(
                              color: Colors.white,
                              strokeWidth: 1,
                            )
                          : const Text('Search'),
                    ),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
