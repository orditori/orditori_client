import 'package:flutter/material.dart';
import 'package:orditori/widgets/notebooks.dart';

import 'settings.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => Settings(),
                ),
              );
            },
          ),
        ],
        title: Text("Orditori"),
      ),
      body: Notebooks(),
    );
  }
}
