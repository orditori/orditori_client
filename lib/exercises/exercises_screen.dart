import 'package:flutter/material.dart';
import 'package:flutter_compute_tree/flutter_compute_tree.dart';
import 'package:orditori/services.dart';

import 'definition_exercise.dart';

typedef ExercisesScreenContext = ({Token<Ref<EdgeInsets>> padding});

class ExercisesScreen extends CTWidget<ExercisesScreenContext> {
  final VoidCallback onExit;

  const ExercisesScreen({
    super.key,
    required super.context,
    required this.onExit,
  });

  @override
  Widget build(CTNode n, ExercisesScreenContext context) {
    final loadExercise = n.trigger();

    final r = loadExercise.asyncHandler(() {
      return client.exercisesDefinitionRandomGet(apiKey: null);
    }, invoke: true);

    switch (r) {
      case Loading() || Pending():
        return const Center(child: CircularProgressIndicator());
      case Failure(exception: final e):
        return Text(e.toString());
      case Success(value: final v):
        final exercise = v.body!;
        final padding = n.consume(context.padding).subscribe();

        return Stack(
          children: [
            Padding(
              padding: padding,
              child: DefinitionExercise(
                exercise: exercise,
                loadExercise: loadExercise,
              ),
            ),
            Positioned(
              top: 0,
              right: 0,
              child: IconButton(
                icon: const Icon(Icons.close),
                onPressed: onExit,
              ),
            ),
          ],
        );
    }
  }
}
