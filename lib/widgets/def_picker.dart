import 'package:flutter/material.dart';
import 'package:orditori/domains/notebooks/state_container.dart';
import 'package:orditori/models/definition.dart';
import 'package:microfrontends/microfrontends.dart';

class DefPicker extends StatelessWidget {
  final List<Definition> defs;

  const DefPicker({Key? key, required this.defs}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return defs.length > 0
        ? ListView.separated(
            padding: const EdgeInsets.only(top: 16),
            separatorBuilder: (context, index) {
              return Container(height: 1, color: Colors.white.withAlpha(10));
            },
            itemCount: defs.length,
            itemBuilder: (context, index) {
              final def = defs[index];
              return InkWell(
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0).copyWith(right: 0),
                        child: Text(def.definition.trim()),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Chip(
                        label: Text(def.language.code),
                      ),
                    ),
                  ],
                ),
                onTap: () {
                  Navigator.of(context).pop();
                  context.mutation(AddDefinition(def));
                },
              );
            },
          )
        : Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 32),
            child: Text('No results'),
          );
  }
}
