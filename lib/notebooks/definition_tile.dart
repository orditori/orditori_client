import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:orditori/swagger_generated_code/orditori.swagger.dart';

class DefinitionTile extends StatelessWidget {
  final DefinitionContentItemR def;
  final Widget leading;

  const DefinitionTile({
    Key? key,
    required this.def,
    required this.leading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.only(top: 4.0, right: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 12.0, right: 12.0, top: 7.0),
            child: leading,
          ),
          Chip(label: Text(def.language!.code!)),
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
                      SelectableText(
                        def.word!,
                        style: textTheme.titleSmall,
                      ),
                      if (def.partOfSpeech != null &&
                          def.partOfSpeech !=
                              PartOfSpeech.swaggerGeneratedUnknown)
                        Text(
                          describeEnum(def.partOfSpeech!),
                          style: textTheme.bodySmall!
                              .copyWith(fontStyle: FontStyle.italic),
                        )
                    ],
                  ),
                ),
                SelectableText(
                  def.definition!,
                  style: textTheme.caption,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
