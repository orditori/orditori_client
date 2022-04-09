import 'package:flutter/material.dart';
import 'package:orditori/swagger_generated_code/orditori.swagger.dart';

class DefinitionTile extends StatelessWidget {
  final DefinitionContentItemR def;
  final Widget? leading;

  const DefinitionTile({
    Key? key,
    required this.def,
    this.leading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: leading,
      title: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Chip(label: Text(def.language!.code!)),
          const SizedBox(width: 8),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 14.0),
              child: SelectableText(
                def.word!,
              ),
            ),
          )
        ],
      ),
      subtitle: Padding(
        padding: const EdgeInsets.only(left: 60.0),
        child: SelectableText(def.definition!),
      ),
    );
  }
}
