import 'package:flutter/material.dart';
import 'package:orditori/overrides.dart';

class ExerciseResult extends StatelessWidget {
  final SolutionCheckResult? result;

  const ExerciseResult({
    super.key,
    required this.result,
  });

  @override
  Widget build(BuildContext context) {
    late Widget child;

    if (result == null) {
      child = const SizedBox();
    } else if (result is IncorrectResult) {
      child = Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.error,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Text(
            (result as IncorrectResult).value,
            style: TextStyle(color: Theme.of(context).colorScheme.onError),
          ),
        ),
      );
    } else {
      child = Container(
        decoration: BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Center(
          child: Text(
            'Correct!',
            style: TextStyle(color: Colors.white),
          ),
        ),
      );
    }

    return AnimatedScale(
      scale: result == null ? 0 : 1,
      curve: Curves.easeInOutBack,
      duration: const Duration(milliseconds: 200),
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 150),
        opacity: result == null ? 0 : 1,
        child: child,
      ),
    );
  }
}
