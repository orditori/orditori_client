import 'package:flutter/material.dart';
import 'package:flutter_compute_tree/flutter_compute_tree.dart';

import 'package:orditori/search/search_bar.dart';
import 'package:orditori/search/search_button.dart';
import 'package:orditori/services.dart';
import 'search_results.dart';

class SearchScreen extends CTWidget {
  final VoidCallback onExit;
  final Trigger refreshNotebook;

  const SearchScreen({
    super.key,
    required this.onExit,
    required this.refreshNotebook,
  });

  @override
  Widget build(BuildContext context) {
    final ctrlRef = ref(() => TextEditingController());
    final controller = ctrlRef.value;
    final search = trigger<String>();

    final r = search.asyncHandler((query) {
      return client.definitionsGet(query: query);
    });

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SearchBar(
              onExit: onExit,
              controller: controller,
              search: search,
            ),
            Expanded(
              child: SearchResults(
                hasResult: r is Success && r.success().value.body!.isNotEmpty,
                items: r is! Success ? [] : r.success().value.body!,
                query: controller.text,
                error: r is Failure ? r.failure().exception.toString() : null,
                refreshNotebook: refreshNotebook,
              ),
            ),
            SearchButton(
              controller: controller,
              isLoading: r is Loading,
              search: search,
            ),
          ],
        ),
      ),
    );
  }
}
