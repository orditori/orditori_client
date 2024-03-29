import 'package:flutter/material.dart' hide Chip;
import 'package:orditori/swagger_generated_code/orditori.swagger.dart';

import '../widgets/chip.dart';

class DefinitionTile extends StatelessWidget {
  final DefinitionContentItemR def;
  const DefinitionTile({
    super.key,
    required this.def,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Chip(label: def.language.code),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15.0),
                child: Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Text(
                      def.word,
                      style: textTheme.titleSmall,
                    ),
                    if (def.partOfSpeech != null &&
                        def.partOfSpeech !=
                            PartOfSpeech.swaggerGeneratedUnknown)
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          def.partOfSpeech!.name,
                          style: textTheme.bodySmall!
                              .copyWith(fontStyle: FontStyle.italic),
                        ),
                      )
                  ],
                ),
              ),
              Text(
                def.definition,
                style: textTheme.bodySmall,
              )
            ],
          ),
        ),
      ],
    );
  }
}
