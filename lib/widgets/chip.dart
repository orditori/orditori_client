import 'package:flutter/material.dart';

class Chip extends StatelessWidget {
  const Chip({super.key, required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: colorScheme.outline),
        borderRadius: BorderRadius.circular(5.0),
      ),
      padding: const EdgeInsets.all(4.0),
      child: Text(label),
    );
  }
}
