import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_compute_tree/flutter_compute_tree.dart';

class SettingsScreen extends CTWidget {
  @override
  bool get static => true;

  const SettingsScreen({super.key});

  @override
  Widget build(CTNode n, CTContext context) {
    final padding = context.ref<EdgeInsets>().subscribe();

    return Scaffold(
      body: ListView(
        padding: padding,
        children: const [
          BrightnessSettingTile(),
          TokenSettingTile(),
        ],
      ),
    );
  }
}

class BrightnessSettingTile extends CTWidget {
  const BrightnessSettingTile({super.key});

  @override
  Widget build(CTNode n, CTContext context) {
    final brightness = context.ref<Brightness>().subscribe();
    final toggleBrightness = context.trigger(VoidTrigger.token<Brightness>());

    final isDarkMode = brightness == Brightness.dark;
    final icon = isDarkMode ? Icons.dark_mode_sharp : Icons.dark_mode_outlined;

    return ListTile(
      title: const Text('Dark Mode'),
      leading: Icon(icon),
      trailing: Switch(
        value: isDarkMode,
        onChanged: (v) => toggleBrightness(),
      ),
    );
  }
}

const _snackbar = SnackBar(
  content: Text('Copied API key to clipboard'),
);

class TokenSettingTile extends CTWidget {
  const TokenSettingTile({super.key});

  @override
  Widget build(CTNode n, CTContext context) {
    final token = context.ref<String>().subscribe();
    final deleteToken = context.trigger(VoidTrigger.token<String>());

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
            onPressed: deleteToken,
            icon: const Icon(Icons.delete),
          ),
        ],
      ),
    );
  }
}
