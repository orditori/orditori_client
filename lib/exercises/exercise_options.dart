import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_compute_tree/flutter_compute_tree.dart';
import 'package:orditori/overrides.dart';

final _keys = [
  LogicalKeyboardKey.digit1,
  LogicalKeyboardKey.digit2,
  LogicalKeyboardKey.digit3,
  LogicalKeyboardKey.digit4,
];

class SelectOptionIntent extends Intent {
  final String option;

  const SelectOptionIntent(this.option);
}

typedef ExerciseOptionsContext = ({Token<Ref<String?>> selectedOption});

class ExerciseOptions extends CTWidget<ExerciseOptionsContext> {
  final List<String> options;
  final Trigger<String> selectOption;
  final Maybe<SolutionCheckResult> result;

  const ExerciseOptions({
    super.key,
    required super.context,
    required this.options,
    required this.selectOption,
    required this.result,
  });

  Color resolveColorForOption(
    BuildContext context,
    String? option,
    String? selectedOption,
    Maybe<SolutionCheckResult> result,
  ) {
    if (result is Nothing && option == selectedOption) return Colors.yellow;

    if (result case Just(value: final r)) {
      return switch (r) {
        Correct() => selectedOption == option ? Colors.green : Colors.grey,
        IncorrectResult(value: final correct) => correct == option
            ? Colors.green
            : selectedOption == option
                ? Colors.red
                : Colors.grey,
      };
    }

    return Theme.of(context).colorScheme.primary;
  }

  @override
  Widget build(CTNode n, ExerciseOptionsContext context) {
    final selectedOption = n.consume(context.selectedOption).subscribe();

    return CallbackShortcuts(
      bindings: {
        if (selectedOption == null)
          for (var i = 0; i < options.length; i++)
            SingleActivator(_keys[i]): () => selectOption(options[i]),
      },
      child: Focus(
        autofocus: true,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ...() sync* {
              for (var i = 0; i < options.length; i++) {
                final option = options[i];

                final color = resolveColorForOption(
                  n.context,
                  option,
                  selectedOption,
                  result,
                );

                final backgroundColor = color == Colors.red ||
                        color == Colors.green ||
                        color == Colors.yellow
                    ? color
                    : null;

                final textColor = backgroundColor != null
                    ? color.computeLuminance() > 0.5
                        ? Colors.black
                        : Colors.white
                    : null;

                yield Padding(
                  padding: EdgeInsets.all(
                      defaultTargetPlatform == TargetPlatform.iOS ||
                              defaultTargetPlatform == TargetPlatform.android
                          ? 0
                          : 8),
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      backgroundColor: backgroundColor,
                    ),
                    onPressed: selectedOption == null
                        ? () => selectOption(option)
                        : null,
                    child: Stack(
                      children: [
                        if (selectedOption == null)
                          KeyboardKey(label: '${i + 1}', color: color),
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            option,
                            style: TextStyle(color: textColor),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }
            }(),
          ],
        ),
      ),
    );
  }
}

class KeyboardKey extends StatelessWidget {
  final String label;
  final Color color;

  const KeyboardKey({
    super.key,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 20,
      height: 20,
      decoration: BoxDecoration(
        color: color.withAlpha(30),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Center(
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: color,
          ),
        ),
      ),
    );
  }
}
