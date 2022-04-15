import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:chopper/chopper.dart';
import 'package:flutter/material.dart';
import 'package:orditori/overrides.dart';
import 'package:orditori/services.dart';
import 'package:orditori/swagger_generated_code/orditori.swagger.dart'
    hide SolutionCheckResult;
import 'package:orditori/widgets/async_widget.dart';

import 'exercise_options.dart';
import 'exercise_result.dart';

final fn = FocusNode();

class ExerciseControls extends StatefulWidget {
  final DefinitionExerciseR exercise;
  const ExerciseControls({
    Key? key,
    required this.exercise,
  }) : super(key: key);

  @override
  _ExerciseControlsState createState() => _ExerciseControlsState();
}

class _ExerciseControlsState extends State<ExerciseControls> {
  final ctrl = TextEditingController();
  SolutionCheckResult? result = null;
  late bool showOptions = widget.exercise.difficultyScore! > 0.4;

  @override
  void didUpdateWidget(covariant ExerciseControls oldWidget) {
    if (oldWidget.exercise.id != widget.exercise.id) {
      ctrl.clear();
      result = null;
      showOptions = widget.exercise.difficultyScore! > 0.4;
    }

    super.didUpdateWidget(oldWidget);
  }

  Future<void> _submit(String answer) async {
    if (result == null) {
      final solution = ExerciseSolutionDefinitionExercise(
        exercise: widget.exercise.id,
        input: answer,
      );

      final url =
          '$baseUrl/exercises/definition/solutions?apiKey=${Auth.getToken(context)}';

      final res = await http.post(
        Uri.parse(url),
        body: jsonEncode(solution.toJson()),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      setState(() {
        this.result = SolutionCheckResult.fromJson(jsonDecode(res.body));
      });
    } else {
      setState(() {
        result = null;
      });
      AsyncWidget.reload<Response<DefinitionExerciseR>>();

      fn.requestFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (showOptions)
          ExerciseOptions(
            options: widget.exercise.options!,
            onOptionSelect: _submit,
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
            onSubmitted: _submit,
          ),
        SizedBox(height: 16),
        Container(
          height: 60,
          child: ExerciseResult(result: result),
        ),
        SizedBox(height: 16),
        ElevatedButton(
          onPressed: () => _submit(ctrl.text),
          child: ValueListenableBuilder<TextEditingValue>(
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
