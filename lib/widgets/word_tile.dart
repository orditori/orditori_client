import 'package:flutter/material.dart';
import 'package:orditori/models/language.dart';

class WordTile extends StatelessWidget {
  final String word;
  final String definition;
  final List<String> examples;
  final Language? language;
  final VoidCallback? onDelete;

  const WordTile({
    Key? key,
    required this.word,
    required this.definition,
    required this.examples,
    this.language,
    this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        showModalBottomSheet(
          context: context,
          builder: (context) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    title: Text('Delete'),
                    leading: Icon(Icons.delete),
                    onTap: onDelete,
                  ),
                ],
              ),
            );
          },
        );
      },
      child: Container(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(word, style: textTheme.headline6),
                  SizedBox(height: 6.0),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 4.0),
                        child: Text('≝',
                            style: TextStyle(fontSize: 30, height: 0.8)),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 4.0, left: 8.0),
                          child: Text(definition, style: textTheme.bodyText2),
                        ),
                      ),
                    ],
                  ),
                  if (examples.isNotEmpty)
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Icon(Icons.format_quote_outlined, size: 17),
                        ),
                        Expanded(
                          child: Text(examples[0]),
                        ),
                      ],
                    )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Chip(
                label: Text(language?.code ?? '???'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
