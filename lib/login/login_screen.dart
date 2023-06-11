import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_compute_tree/flutter_compute_tree.dart';

typedef LoginScreenContext = ({Token<Trigger<String>> setToken});

class LoginScreen extends CTWidget<LoginScreenContext> {
  const LoginScreen({
    super.key,
    required super.context,
  });

  @override
  Widget build(CTNode n, LoginScreenContext context) {
    final ctrl = TextEditingController();
    final setToken = n.consume(context.setToken);

    return Scaffold(
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 500),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: ctrl,
                        decoration: const InputDecoration(
                          hintText: 'API Token',
                          border: InputBorder.none,
                        ),
                        onSubmitted: setToken.call,
                      ),
                    ),
                    IconButton(
                      color: Theme.of(n.context).colorScheme.secondary,
                      icon: const Icon(Icons.paste),
                      onPressed: () async {
                        final data = await Clipboard.getData('text/plain');
                        if (data == null || data.text == null) return;
                        ctrl.text = data.text!;
                      },
                    ),
                  ],
                ),
                TextButton(
                  onPressed: () {
                    setToken(ctrl.text);
                  },
                  child: const Text('Done'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
