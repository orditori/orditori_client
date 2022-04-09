import 'package:flutter/material.dart';

typedef ExerciseOptionCallback = void Function(String option);

class ExerciseOptions extends StatelessWidget {
  final List<String> options;
  final ExerciseOptionCallback onOptionSelect;
  const ExerciseOptions({
    Key? key,
    required this.options,
    required this.onOptionSelect,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ...options.map(
          (option) => OutlinedButton(
            onPressed: () => onOptionSelect(option),
            child: Text(option),
          ),
        )
      ],
    );
  }
}
