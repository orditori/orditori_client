import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_compute_tree/flutter_compute_tree.dart';

class SettingsScreen extends CTWidget {
  @override
  bool get static => true;

  const SettingsScreen({super.key});

  @override
  Widget build(CTNode n) {
    final paddingRef = Ref.consume<EdgeInsets>(n);
    final padding = n.subscribeToRef(paddingRef.just().value);

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
  Widget build(CTNode n) {
    final ref = Ref.consume<Brightness>(n).just().value;
    final brightness = n.subscribeToRef(ref);

    final setBrightness = Trigger.consume<Brightness>(n).just().value;
    final isDarkMode = brightness == Brightness.dark;

    void toggleBrightness() {
      Brightness newBrightness;

      if (isDarkMode) {
        newBrightness = Brightness.light;
      } else {
        newBrightness = Brightness.dark;
      }

      setBrightness(newBrightness);
    }

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

class DeleteTokenTriggerToken extends TriggerToken {
  const DeleteTokenTriggerToken();
}

class TokenSettingTile extends CTWidget {
  const TokenSettingTile({super.key});

  @override
  Widget build(CTNode n) {
    final tokenRef = Ref.consume<String>(n).just().value;
    final token = n.subscribeToRef(tokenRef);

    final deleteToken = Trigger.consume(
      n,
      const DeleteTokenTriggerToken(),
    ).just().value;

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
