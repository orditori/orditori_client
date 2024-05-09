import 'package:flutter/material.dart';
import 'package:flutter_compute_tree/flutter_compute_tree.dart';
import 'package:orditori/services.dart';
import 'package:orditori/swagger_generated_code/orditori.swagger.dart';

class DefinitionScreen extends StatelessWidget {
  final DefinitionContentItemR def;
  final Consumed<VoidTrigger> refreshNotebook;

  const DefinitionScreen({
    super.key,
    required this.def,
    required this.refreshNotebook,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(def.word),
      ),
      body: SafeArea(
        child: ListView(
          children: [
            ListTile(
              title: const Text('Language'),
              subtitle: Text(def.language.name),
            ),
            if (def.partOfSpeech != null)
              ListTile(
                title: const Text('Part of speech'),
                subtitle: Text(def.partOfSpeech!.name),
              ),
            ListTile(
              title: const Text('Definition'),
              subtitle: Text(def.definition),
            ),
            if (def.examples.isNotEmpty) ...[
              Padding(
                padding: const EdgeInsets.all(16.0).copyWith(bottom: 0),
                child: Text(
                  'Examples',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              for (final example in def.examples) ...[
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(example.$string),
                ),
                if (example.translation != null) ...[
                  ListTile(
                    title: const Text('Translation'),
                    subtitle: Text(example.translation!),
                  ),
                ],
              ],
            ],
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: CTBuilder((n, context) {
                final delete = n.trigger();

                final r = delete.asyncHandler(() async {
                  await client
                      .definitionContentItemsDefinitionContentItemIdDelete(
                          apiKey: null,
                          definitionContentItemId: def.definitionId);
                  refreshNotebook();

                  // ignore: use_build_context_synchronously
                  Navigator.of(n.context).pop();
                });

                return ElevatedButton.icon(
                  onPressed: delete.call,
                  icon: const Icon(Icons.delete),
                  label: Stack(
                    alignment: Alignment.center,
                    children: [
                      Opacity(
                        opacity: r is Loading ? 0 : 1,
                        child: const Text('Delete'),
                      ),
                      if (r is Loading)
                        const SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(strokeWidth: 1),
                        ),
                    ],
                  ),
                );
              }, context: ()),
            ),
          ],
        ),
      ),
    );
  }
}
