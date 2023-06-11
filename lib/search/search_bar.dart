import 'package:flutter/material.dart';
import 'package:flutter_compute_tree/flutter_compute_tree.dart';

typedef SearchBarContext = ({
  Token<Trigger<String>> search,
});

class SearchBar extends CTWidget<SearchBarContext> {
  final VoidCallback? onExit;
  final TextEditingController controller;
  final bool autofocus;

  const SearchBar({
    super.key,
    required super.context,
    this.onExit,
    required this.controller,
    this.autofocus = true,
  });

  @override
  Widget build(CTNode n, SearchBarContext context) {
    final search = n.consume(context.search);

    return Row(
      children: [
        if (onExit != null)
          IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: onExit,
          )
        else
          const SizedBox(width: 16),
        Expanded(
          child: TextField(
            controller: controller,
            autofocus: autofocus,
            onSubmitted: search.call,
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
