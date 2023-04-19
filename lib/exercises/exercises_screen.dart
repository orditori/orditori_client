import 'package:flutter/material.dart';
import 'package:flutter_compute_tree/flutter_compute_tree.dart';
import 'package:flutter_context/flutter_context.dart';
import 'package:orditori/services.dart';
import 'package:orditori/auth.dart';

import 'definition_exercise.dart';

class ExercisesScreen extends CTWidget {
  final VoidCallback onExit;
  const ExercisesScreen({
    super.key,
    required this.onExit,
  });

  @override
  Widget build(CTNode n) {
    final token = n.context.read(tokenContext);
    final loadExercise = n.trigger();

    final r = loadExercise.asyncHandler((_) {
      return client.exercisesDefinitionRandomGet(apiKey: token);
    });

    n.invoke.immediate(loadExercise);

    if (r is Loading || r is Pending) {
      return const Center(child: CircularProgressIndicator());
    }

    if (r is Failure) {
      return Text(r.failure().exception.toString());
    }

    final exercise = r.success().value.body!;

    return Stack(
      children: [
        DefinitionExercise(
          key: ValueKey(exercise.id),
          exercise: exercise,
          loadExercise: loadExercise,
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
