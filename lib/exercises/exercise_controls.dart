import 'dart:convert';

import 'package:flutter_compute_tree/flutter_compute_tree.dart';
import 'package:flutter_context/flutter_context.dart';

import 'package:flutter/material.dart';
import 'package:orditori/overrides.dart';
import 'package:orditori/services.dart';
import 'package:orditori/auth.dart';
import 'package:orditori/swagger_generated_code/orditori.swagger.dart'
    hide SolutionCheckResult;

import 'exercise_options.dart';
import 'exercise_result.dart';

final fn = FocusNode();

class ExerciseControls extends CTWidget {
  final DefinitionExerciseR exercise;

  const ExerciseControls({super.key, required this.exercise});

  @override
  Widget build(BuildContext context) {
    bool showOptions = exercise.difficultyScore > 0.4;

    final ctrlRef = ref(() => TextEditingController(), [exercise.id]);
    final ctrl = ctrlRef.value;

    final submit = trigger<String>();

    final res = submit.asyncHandler((answer) {
      final solution = ExerciseSolutionDefinitionExercise(
        exercise: exercise.id,
        input: answer,
      );

      final token = context.read(tokenContext);

      return client.exercisesDefinitionSolutionsPost(
        apiKey: token,
        body: solution,
      );
    });

    SolutionCheckResult? result;

    if (res is Success) {
      final json = jsonDecode(res.success().value.bodyString);
      result = SolutionCheckResult.fromJson(json);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (showOptions)
          ExerciseOptions(
            options: exercise.options,
            selectOption: submit,
          )
        else
          TextField(
            focusNode: fn,
            autocorrect: false,
            controller: ctrl,
            decoration: InputDecoration(
              hintText: 'Answer',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onSubmitted: submit,
          ),
        const SizedBox(height: 16),
        SizedBox(
          height: 60,
          child: ExerciseResult(result: result),
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: () => submit(ctrl.text),
          child: ValueListenableBuilder<TextEditingValue>(
            valueListenable: ctrl,
            builder: (_, value, __) {
              return Text(
                result != null
                    ? 'Next'
                    : value.text.isEmpty
                        ? 'Skip'
                        : 'Submit',
              );
            },
          ),
        )
      ],
    );
  }
}
