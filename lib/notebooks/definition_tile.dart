import 'package:flutter/material.dart';
import 'package:flutter_compute_tree/flutter_compute_tree.dart';
import 'package:orditori/definitions/definition_tile.dart';
import 'package:orditori/swagger_generated_code/orditori.swagger.dart';

import '../definitions/definition_screen.dart';

class NotebookEntryTile extends StatelessWidget {
  final DefinitionContentItemR def;
  final NotebookEntryR entry;
  final Widget leading;
  final VoidTrigger refreshNotebook;

  const NotebookEntryTile({
    super.key,
    required this.def,
    required this.leading,
    required this.entry,
    required this.refreshNotebook,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashFactory: InkSparkle.splashFactory,
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => DefinitionScreen(
              def: def,
              entry: entry,
              refreshNotebook: refreshNotebook,
            ),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 4.0, right: 16.0, bottom: 8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 12.0, right: 12.0, top: 7.0),
              child: leading,
            ),
            Expanded(
              child: DefinitionTile(def: def),
            ),
          ],
        ),
      ),
    );
  }
}
