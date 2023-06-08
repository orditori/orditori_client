import 'package:flutter/material.dart';
import 'package:flutter_compute_tree/flutter_compute_tree.dart';

class SearchBar extends CTWidget {
  final VoidCallback? onExit;
  final TextEditingController controller;

  const SearchBar({
    super.key,
    this.onExit,
    required this.controller,
  });

  @override
  Widget build(CTNode n, CTContext context) {
    final search = context.trigger.withArg<String>();

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
