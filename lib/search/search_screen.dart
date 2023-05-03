import 'package:flutter/material.dart' hide SearchBar;
import 'package:flutter_compute_tree/flutter_compute_tree.dart';

import 'package:orditori/search/search_bar.dart';
import 'package:orditori/search/search_button.dart';
import 'package:orditori/services.dart';
import 'package:orditori/swagger_generated_code/orditori.swagger.dart';
import 'search_results.dart';

class SearchScreen extends CTWidget {
  final VoidCallback onExit;

  const SearchScreen({
    super.key,
    required this.onExit,
  });

  @override
  Widget build(CTNode n, CTContext context) {
    final ctrlRef = n.ref(() => TextEditingController());
    final search = n.trigger.withArg<String>();

    final r = search.asyncHandler((query) {
      return client.definitionsGet(query: query);
    });

    final (hasResult, items, error) = switch (r) {
      Success(value: final v) => (v.body!.isNotEmpty, v.body!, null),
      _ => (false, const <DefinitionsWithSource>[], null),
    };

    final padding = context.ref<EdgeInsets>().subscribe();
    final controller = ctrlRef.value;

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
                    search: search,
                  ),
                ),
              ),
            ),
            Expanded(
              child: SearchResults(
                hasResult: hasResult,
                items: items,
                query: controller.text,
                error: error,
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
