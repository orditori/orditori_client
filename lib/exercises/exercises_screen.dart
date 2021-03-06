import 'package:chopper/chopper.dart';
import 'package:flutter/material.dart';
import 'package:orditori/services.dart';
import 'package:orditori/swagger_generated_code/orditori.swagger.dart';
import 'package:orditori/widgets/async_widget.dart';

import 'definition_exercise.dart';

class ExercisesScreen extends StatelessWidget {
  const ExercisesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final token = Auth.getToken(context);
    return AsyncWidget<Response<DefinitionExerciseR>>(
      load: () async {
        while (true) {
          final res = await client.exercisesDefinitionRandomGet(apiKey: token);
          if (res.body != null) {
            return res;
          } else {
            await Future.delayed(const Duration(milliseconds: 200));
          }
        }
      },
      loading: const SizedBox(),
      errorBuilder: (_, err) => Text(err.toString()),
      showDataWhenLoading: true,
      builder: (context, value) {
        if (value!.body == null) {
          AsyncWidget.reload<Response<DefinitionExerciseR>>();
          return const SizedBox();
        }
        return DefinitionExercise(
          key: ValueKey(value.body?.id),
          exercise: value.body!,
        );
      },
    );
  }
}
