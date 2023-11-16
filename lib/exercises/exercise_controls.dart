import 'dart:convert';

import 'package:flutter_compute_tree/flutter_compute_tree.dart';

import 'package:flutter/material.dart';
import 'package:orditori/services.dart';
import 'package:orditori/swagger_generated_code/orditori.swagger.dart'
    hide SolutionCheckResult;

import '../overrides.dart';
import 'exercise_options.dart';
import 'exercise_result.dart';

class ExerciseControls extends CTWidget<()> {
  final DefinitionExerciseR exercise;
  final VoidTrigger loadExercise;

  const ExerciseControls({
    super.key,
    super.context = (),
    required this.exercise,
    required this.loadExercise,
  });

  @override
  Widget build(CTNode n, () context) {
    final shouldShowOptionsRef = n.ref(
      () => exercise.difficultyScore > 0.3,
      (exercise.id,),
    );

    final showOptions = shouldShowOptionsRef.action((value) => true);

    final ctrlRef = n.ref(() => TextEditingController(), (exercise.id,));
    final ctrl = ctrlRef.value;

    final submit = n.trigger.withArg<String>();

    final selectedOption = n.ref<String?, (int,)>(() => null, (exercise.id,));
    final select = selectedOption.action.setValue();

    submit.handler(select.call);

    final res = submit.asyncHandler((answer) async {
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

    Maybe<SolutionCheckResult> result = const Nothing();

    if (res case Success(value: final v)) {
      result = Just(SolutionCheckResult.fromJson(jsonDecode(v.bodyString)));
    }

    final handler = switch (result) {
      Just() => loadNext,
      Nothing() => () => submit(ctrl.text),
    };

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (shouldShowOptionsRef.value)
          ExerciseOptions(
            options: exercise.options,
            selectOption: submit,
            result: result,
            context: (selectedOption: selectedOption.provide(),),
          )
        else ...[
          TextField(
            autofocus: true,
            autocorrect: false,
            controller: ctrl,
            decoration: InputDecoration(
              hintText: 'Answer',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onSubmitted: submit.call,
          ),
          const SizedBox(height: 16),
          TextButton(
            onPressed: showOptions.call,
            child: const Text('Show choices'),
          )
        ],
        const SizedBox(height: 16),
        if (!shouldShowOptionsRef.value) ...[
          SizedBox(
            height: 60,
            child: ExerciseResult(result: result),
          ),
          const SizedBox(height: 16),
        ],
        ElevatedButton(
          onPressed: handler,
          child: switch (res) {
            Loading() => const SizedBox(
                width: 12,
                height: 12,
                child: CircularProgressIndicator(strokeWidth: 1),
              ),
            _ => ValueListenableBuilder(
                valueListenable: ctrl,
                builder: (_, value, __) {
                  return Text(switch (result) {
                    Nothing() => value.text.isEmpty ? 'Skip' : 'Submit',
                    Just() => 'Next',
                  });
                },
              ),
          },
        )
      ],
    );
  }
}
