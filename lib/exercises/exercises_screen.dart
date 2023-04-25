import 'package:flutter/material.dart';
import 'package:flutter_compute_tree/flutter_compute_tree.dart';
import 'package:orditori/services.dart';

import 'definition_exercise.dart';

class ExercisesScreen extends CTWidget {
  final VoidCallback onExit;
  const ExercisesScreen({
    super.key,
    required this.onExit,
  });

  @override
  Widget build(CTNode n) {
    final loadExercise = n.trigger();

    final r = loadExercise.asyncHandler((_) {
      return client.exercisesDefinitionRandomGet(apiKey: null);
    });

    n.invoke(loadExercise);

    if (r is Loading || r is Pending) {
      return const Center(child: CircularProgressIndicator());
    }

    if (r is Failure) {
      return Text(r.failure().exception.toString());
    }

    final exercise = r.success().value.body!;

    final paddingRef = Ref.consume<EdgeInsets>(n);
    final padding = n.subscribeToRef(paddingRef);

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
