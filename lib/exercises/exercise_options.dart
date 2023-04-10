import 'package:flutter/material.dart';
import 'package:flutter_compute_tree/flutter_compute_tree.dart';

class ExerciseOptions extends StatelessWidget {
  final List<String> options;
  final Trigger<String> selectOption;

  const ExerciseOptions({
    super.key,
    required this.options,
    required this.selectOption,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ...options.map(
          (option) => OutlinedButton(
            onPressed: selectOption.bind(option),
            child: Text(option),
          ),
        )
      ],
    );
  }
}
