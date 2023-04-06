import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:orditori/swagger_generated_code/orditori.swagger.dart';

import 'exercise_controls.dart';

class DefinitionExercise extends StatelessWidget {
  final DefinitionExerciseR exercise;

  const DefinitionExercise({
    Key? key,
    required this.exercise,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Chip(label: Text(exercise.language.name)),
          ),
          Expanded(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: SizedBox(
                  height: 100,
                  child: AutoSizeText(
                    exercise.definition,
                    minFontSize: 16,
                    stepGranularity: 4,
                    maxFontSize: 32,
                    style: const TextStyle(fontSize: 32),
                    maxLines: 4,
                  ),
                ),
              ),
            ),
          ),
          ExerciseControls(exercise: exercise),
        ],
      ),
    );
  }
}
