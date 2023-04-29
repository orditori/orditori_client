import 'package:flutter/material.dart';
import 'package:flutter_compute_tree/flutter_compute_tree.dart';

import 'package:orditori/widgets/loading_indicator.dart';

class SearchButton extends StatelessWidget {
  final Trigger<String> search;
  final TextEditingController controller;
  final bool isLoading;

  const SearchButton({
    super.key,
    required this.search,
    required this.controller,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: AnimatedBuilder(
        animation: controller,
        builder: (context, child) {
          final query = controller.text;
          final action = controller.text.isEmpty ? null : search.bind(query);

          return ElevatedButton(
            onPressed: action?.call,
            child: SizedBox(
              height: 16,
              width: isLoading ? 16 : null,
              child: isLoading
                  ? const LoadingIndicator(strokeWidth: 1)
                  : const Text('Search'),
            ),
          );
        },
      ),
    );
  }
}
