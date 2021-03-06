import 'package:flutter/material.dart';
import 'package:orditori/overrides.dart';

class ExerciseResult extends StatelessWidget {
  final SolutionCheckResult? result;

  const ExerciseResult({
    Key? key,
    required this.result,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    late Widget child;

    if (result == null) {
      child = SizedBox();
    } else if (result is IncorrectResult) {
      child = Container(
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(child: Text((result as IncorrectResult).value)),
      );
    } else {
      child = Container(
        decoration: BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(child: Text('Correct!')),
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
