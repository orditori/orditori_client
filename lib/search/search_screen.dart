import 'package:flutter/material.dart' hide SearchBar;
import 'package:flutter_compute_tree/flutter_compute_tree.dart';

import 'package:orditori/search/search_bar.dart';
import 'package:orditori/search/search_button.dart';
import 'package:orditori/services.dart';
import 'package:orditori/swagger_generated_code/orditori.swagger.dart';
import 'search_results.dart';

typedef SearchScreenContext = ({
  Token<Ref<EdgeInsets>> padding,
  Token<Ref<int>> notebookId,
  Token<VoidTrigger> refreshNotebook,
  Token<Ref<Set<int>>> savedDefinitions,
});

class SearchScreen extends CTWidget<SearchScreenContext> {
  final VoidCallback? onExit;
  final String initialQuery;
  final ScrollController? scrollController;
  final bool autofocus;

  const SearchScreen({
    super.key,
    required super.context,
    required this.onExit,
    this.scrollController,
    this.initialQuery = '',
    this.autofocus = true,
  });

  @override
  Widget build(CTNode n, SearchScreenContext context) {
    final ctrlRef = n.ref(() => TextEditingController(text: initialQuery));
    final search = n.trigger.withArg<String>()..provide();

    final r = search.asyncHandler((query) {
      return client.definitionsGet(query: query);
    });

    final (hasResult, items, error) = switch (r) {
      Success(value: final v) => (v.body!.isNotEmpty, v.body!, null),
      _ => (false, const <DefinitionsWithSource>[], null),
    };

    final padding = n.consume(context.padding).subscribe();
    final controller = ctrlRef.value;

    n.invoke(() {
      if (initialQuery.isNotEmpty) {
        search(initialQuery);
      }
    });

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: padding,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  child: SearchBar(
                    onExit: onExit,
                    controller: controller,
                    autofocus: autofocus,
                    context: (search: search.provide(),),
                  ),
                ),
              ),
            ),
            Expanded(
              child: SearchResults(
                scrollController: scrollController,
                hasResult: hasResult,
                items: items,
                query: controller.text,
                error: error,
                context: context,
              ),
            ),
            Padding(
              padding: padding,
              child: SearchButton(
                controller: controller,
                isLoading: r is Loading,
                search: search,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
