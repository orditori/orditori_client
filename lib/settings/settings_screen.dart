import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_compute_tree/flutter_compute_tree.dart';

class SettingsScreen extends CTWidget {
  final Trigger<Brightness> setBrightness;

  final String token;
  final Trigger<void> deleteToken;

  final Widget brightnessTile;

  @override
  bool get static => true;

  const SettingsScreen({
    super.key,
    required this.setBrightness,
    required this.token,
    required this.deleteToken,
    required this.brightnessTile,
  });

  @override
  Widget build(CTNode n) {
    final paddingRef = Ref.consume<EdgeInsets>(n);
    final padding = n.subscribeToRef(paddingRef.just().value);

    return Scaffold(
      body: ListView(
        padding: padding,
        children: [
          brightnessTile,
          TokenSettingTile(
            token: token,
            deleteToken: deleteToken,
          ),
        ],
      ),
    );
  }
}

class BrightnessSettingTile extends CTWidget {
  final Ref<Brightness> ref;
  final Trigger<Brightness> setBrightness;

  const BrightnessSettingTile({
    super.key,
    required this.ref,
    required this.setBrightness,
  });

  @override
  Widget build(CTNode n) {
    final brightness = n.subscribeToRef(ref);
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

const _apiKeyCopiedSnackbar = SnackBar(
  content: Text('Copied API key to clipboard'),
);

class TokenSettingTile extends StatelessWidget {
  final String token;
  final void Function() deleteToken;

  const TokenSettingTile({
    super.key,
    required this.token,
    required this.deleteToken,
  });

  @override
  Widget build(BuildContext context) {
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
              ScaffoldMessenger.of(context).showSnackBar(_apiKeyCopiedSnackbar);
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
