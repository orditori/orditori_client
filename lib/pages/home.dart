import 'package:flutter/material.dart';
import 'package:orditori/domains/auth/state.dart';
import 'package:orditori/widgets/notebooks.dart';
import 'package:microfrontends/microfrontends.dart';

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
                  builder: (_) {
                    return Settings().withContainer<AuthState>(context);
                  },
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
