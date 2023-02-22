import 'package:flutter/material.dart';
import 'package:orditori/swagger_generated_code/orditori.swagger.dart';

class DefinitionTile extends StatelessWidget {
  final Definition def;
  final bool isSaved;
  final VoidCallback onBookmarkPressed;

  const DefinitionTile({
    Key? key,
    required this.def,
    required this.isSaved,
    required this.onBookmarkPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16).copyWith(bottom: 8),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Chip(label: Text(def.language!.code!)),
                const SizedBox(width: 12),
                Expanded(child: SelectableText(def.definition!)),
                const SizedBox(width: 16),
                IconButton(
                  icon: Icon(
                    isSaved
                        ? Icons.bookmark_added_sharp
                        : Icons.bookmark_add_outlined,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  onPressed: onBookmarkPressed,
                )
              ],
            ),
            if (def.examples?.isNotEmpty ?? false)
              Padding(
                padding: const EdgeInsets.all(8.0).copyWith(bottom: 0),
                child: IntrinsicHeight(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Divider(),
                      const SizedBox(height: 8),
                      Text(
                        'Examples:',
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      ...(def.examples!.map(
                        (e) => Padding(
                          padding:
                              const EdgeInsets.all(8.0).copyWith(bottom: 0),
                          child: Text(
                            e.$String!,
                            style: const TextStyle(fontStyle: FontStyle.italic),
                          ),
                        ),
                      )),
                      const SizedBox(height: 8),
                    ],
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}
