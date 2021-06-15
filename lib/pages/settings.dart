import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:microfrontends/microfrontends.dart';
import 'package:orditori/domains/auth/state.dart';
import 'package:orditori/domains/auth/state_container.dart';

class Settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Column(children: [
        context.subscribe<AuthState>(builder: (context, state, child) {
          return ListTile(
            title: Text("API Key"),
            subtitle: state is Authenticated?
                ? Text(
                    (state as Authenticated).token.toString(),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  )
                : null,
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.paste),
                  tooltip: 'Paste',
                  onPressed: () async {
                    final token = await Clipboard.getData('text/plain');
                    if (token?.text != null) {
                      context.mutation(UpdateToken(token!.text!));
                    }
                  },
                ),
                IconButton(
                  tooltip: 'Copy',
                  icon: Icon(Icons.copy),
                  onPressed: () async {
                    if (state is Authenticated) {
                      await Clipboard.setData(
                        ClipboardData(text: state.token.toString()),
                      );

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Token copied!")),
                      );
                    }
                  },
                )
              ],
            ),
          );
        }),
      ]),
    );
  }
}
