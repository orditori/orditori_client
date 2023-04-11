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
  Widget build(BuildContext context) {
    final token = context.read(tokenContext);
    final r = invokeAsync(() {
      return client.exercisesDefinitionRandomGet(apiKey: token);
    });

    if (r is Loading) {
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
