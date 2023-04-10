import 'package:flutter/material.dart';
import 'package:flutter_compute_tree/flutter_compute_tree.dart';

class SearchBar extends StatelessWidget {
  final VoidCallback onExit;
  final TextEditingController controller;
  final Trigger<String> search;

  const SearchBar({
    super.key,
    required this.onExit,
    required this.controller,
    required this.search,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: onExit,
        ),
        Expanded(
          child: TextField(
            controller: controller,
            autofocus: true,
            onSubmitted: search,
            decoration: const InputDecoration(hintText: 'Search'),
            textInputAction: TextInputAction.search,
          ),
        ),
        AnimatedBuilder(
          animation: controller,
          builder: (context, child) {
            return AnimatedOpacity(
              opacity: controller.text.isEmpty ? 0 : 1,
              duration: const Duration(milliseconds: 200),
              child: child,
            );
          },
          child: TextButton(
            onPressed: controller.clear,
            child: const Text('Clear'),
          ),
        )
      ],
    );
  }
}
