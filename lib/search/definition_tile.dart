import 'package:flutter/material.dart';
import 'package:flutter_compute_tree/flutter_compute_tree.dart';
import 'package:flutter_context/flutter_context.dart';
import 'package:orditori/auth.dart';
import 'package:orditori/notebooks.dart';
import 'package:orditori/services.dart';
import 'package:orditori/swagger_generated_code/orditori.swagger.dart';

class DefinitionTile extends CTWidget {
  final DefinitionR definition;
  final DefinitionSource source;
  final Trigger refreshNotebook;

  const DefinitionTile({
    super.key,
    required this.definition,
    required this.source,
    required this.refreshNotebook,
  });

  @override
  Widget build(CTNode n) {
    final savedDefinitions = n.context.watch(savedDefinitionsContext);
    final token = n.context.read(tokenContext);
    final notebook = n.context.read(notebookContext);

    final isSaved = savedDefinitions.contains(definition.id);
    final addDefinition = n.trigger();

    final addResult = addDefinition.asyncHandler((_) async {
      final addedDate = '${DateTime.now().toIso8601String().substring(0, 23)}Z';
      final entryW = NotebookEntryW(
        addedDate: addedDate,
        notebook: notebook.id,
      );

      final entryRes = await client.notebookEntriesPost(
        apiKey: token,
        body: entryW,
      );

      final entryId = entryRes.body!;

      final definitionW = DefinitionContentItemW(
        definition: definition.id,
        entry: entryId,
      );

      await client.definitionContentItemsPost(
        apiKey: token,
        body: definitionW,
      );

      refreshNotebook();
    });

    final icon = IconButton(
      icon: Icon(
        isSaved ? Icons.bookmark_added_sharp : Icons.bookmark_add_outlined,
      ),
      color: Theme.of(n.context).colorScheme.primary,
      onPressed: addDefinition,
    );

    return Card(
      margin: const EdgeInsets.all(16).copyWith(bottom: 8),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Chip(label: Text(definition.language.code)),
                const SizedBox(width: 12),
                Expanded(child: SelectableText(definition.definition)),
                const SizedBox(width: 16),
                addResult is Loading ? const CircularProgressIndicator() : icon,
              ],
            ),
            if (definition.examples.isNotEmpty)
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
                        style: Theme.of(n.context).textTheme.titleSmall,
                      ),
                      ...(definition.examples.map(
                        (e) => Padding(
                          padding:
                              const EdgeInsets.all(8.0).copyWith(bottom: 0),
                          child: Text(
                            e.$string,
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
