import 'package:flutter/material.dart';
import 'package:flutter_compute_tree/flutter_compute_tree.dart';
import 'package:orditori/overrides.dart';

class ExerciseResult extends StatelessWidget {
  final Maybe<SolutionCheckResult> result;

  const ExerciseResult({
    super.key,
    required this.result,
  });

  Color backgroundColor(ColorScheme colorScheme, SolutionCheckResult result) {
    return switch (result) {
      IncorrectResult() => colorScheme.error,
      Correct() => Colors.green,
    };
  }

  Color textColor(ColorScheme colorScheme, SolutionCheckResult result) {
    return switch (result) {
      IncorrectResult() => colorScheme.onError,
      Correct() => Colors.white,
    };
  }

  String text(SolutionCheckResult result) {
    return switch (result) {
      IncorrectResult(value: final r) => r,
      Correct() => 'Correct!',
    };
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    final (scale, opacity) = switch (result) {
      Nothing() => (0.0, 0.0),
      Just() => (1.0, 1.0),
    };

    return AnimatedScale(
      scale: scale,
      curve: Curves.easeInOutBack,
      duration: const Duration(milliseconds: 200),
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 150),
        opacity: opacity,
        child: switch (result) {
          Nothing() => const SizedBox.shrink(),
          Just(value: final v) => Container(
              decoration: BoxDecoration(
                color: backgroundColor(colorScheme, v),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Text(
                  text(v),
                  style: TextStyle(color: textColor(colorScheme, v)),
                ),
              ),
            )
        },
      ),
    );
  }
}
