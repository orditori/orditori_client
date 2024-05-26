import 'package:brightness_drop/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_compute_tree/flutter_compute_tree.dart';

import 'package:cyclone/cyclone.dart' hide Ref;
import 'package:brightness_drop/queries.dart' as brightness_queries;
import 'package:orditori/auth.dart';

typedef SettingsScreenContext = ({
  Token<Ref<EdgeInsets>> padding,
  TokenContext tokenContext,
});

class SettingsScreen extends CTWidget<SettingsScreenContext> {
  @override
  bool get static => true;

  const SettingsScreen({
    super.key,
    required super.context,
  });

  @override
  Widget build(CTNode n, SettingsScreenContext context) {
    final padding = n.consume(context.padding).subscribe();

    return Scaffold(
      body: ListView(
        padding: padding,
        children: [
          const BrightnessSettingTile(),
          TokenSettingTile(
            context: context.tokenContext,
          ),
        ],
      ),
    );
  }
}

class BrightnessSettingTile extends StatelessWidget {
  const BrightnessSettingTile({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = brightness_queries.isDarkMode.bind(context).watch();
    final icon = isDarkMode ? Icons.dark_mode_sharp : Icons.dark_mode_outlined;

    return ListTile(
      title: const Text('Dark Mode'),
      leading: Icon(icon),
      trailing: const Slot<BrightnessToggle>(),
    );
  }
}

const _snackbar = SnackBar(
  content: Text('Copied API key to clipboard'),
);

class TokenSettingTile extends CTWidget<TokenContext> {
  const TokenSettingTile({
    super.key,
    required super.context,
  });

  @override
  Widget build(CTNode n, TokenContext context) {
    final token = n.consume(context.token).subscribe();
    final deleteToken = n.consume(context.deleteToken);

    return ListTile(
      title: const Text('API Key'),
      subtitle: Text(token, maxLines: 1),
      leading: const Icon(Icons.vpn_key),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            onPressed: () {
              Clipboard.setData(ClipboardData(text: token));
              ScaffoldMessenger.of(n.context).showSnackBar(_snackbar);
            },
            icon: const Icon(Icons.copy),
          ),
          IconButton(
            onPressed: deleteToken.call,
            icon: const Icon(Icons.delete),
          ),
        ],
      ),
    );
  }
}
