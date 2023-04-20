import 'dart:convert';

import 'package:flutter_compute_tree/flutter_compute_tree.dart';

import 'package:flutter/material.dart';
import 'package:orditori/overrides.dart';
import 'package:orditori/services.dart';
import 'package:orditori/swagger_generated_code/orditori.swagger.dart'
    hide SolutionCheckResult;

import 'exercise_options.dart';
import 'exercise_result.dart';

final fn = FocusNode();

class ExerciseControls extends CTWidget {
  final DefinitionExerciseR exercise;
  final Trigger loadExercise;

  const ExerciseControls({
    super.key,
    required this.exercise,
    required this.loadExercise,
  });

  @override
  Widget build(CTNode n) {
    bool showOptions = exercise.difficultyScore > 0.3;

    final ctrlRef = n.ref(() => TextEditingController(), exercise.id);
    final ctrl = ctrlRef.value;

    final submit = n.trigger<String>();
    final selectedOption = n.ref<String?, int>(() => null, exercise.id);

    selectedOption.provide();

    final res = submit.asyncHandler((answer) async {
      selectedOption.value = answer;

      final solution = ExerciseSolutionDefinitionExercise(
        exercise: exercise.id,
        input: answer,
      );

      await Future.delayed(const Duration(milliseconds: 300));

      return client.exercisesDefinitionSolutionsPost(
        apiKey: null,
        body: solution,
      );
    });

    final loadNext = n.memo(() {
      ctrl.clear();
      loadExercise();
    });

    SolutionCheckResult? result;

    if (res is Success) {
      final json = jsonDecode(res.success().value.bodyString);
      result = SolutionCheckResult.fromJson(json);
    }

    final handler = result == null ? () => submit(ctrl.text) : loadNext;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (showOptions)
          ExerciseOptions(
            options: exercise.options,
            selectOption: submit,
            result: result,
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
        if (!showOptions) ...[
          SizedBox(
            height: 60,
            child: ExerciseResult(result: result),
          ),
          const SizedBox(height: 16),
        ],
        ElevatedButton(
          onPressed: handler,
          child: res is Loading
              ? const SizedBox(
                  width: 12,
                  height: 12,
                  child: CircularProgressIndicator(strokeWidth: 1),
                )
              : ValueListenableBuilder<TextEditingValue>(
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
