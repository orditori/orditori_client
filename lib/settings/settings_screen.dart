import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_context/flutter_context.dart';

class SettingsScreen extends StatelessWidget {
  final Context<Brightness> brightnessContext;
  final void Function(Brightness brightness) setBrightness;

  final String token;
  final void Function() deleteToken;

  const SettingsScreen({
    super.key,
    required this.brightnessContext,
    required this.setBrightness,
    required this.token,
    required this.deleteToken,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          BrightnessSettingTile(
            brightnessContext: brightnessContext,
            setBrightness: setBrightness,
          ),
          TokenSettingTile(
            token: token,
            deleteToken: deleteToken,
          ),
        ],
      ),
    );
  }
}

class BrightnessSettingTile extends StatelessWidget {
  final Context<Brightness> brightnessContext;
  final void Function(Brightness brightness) setBrightness;

  const BrightnessSettingTile({
    super.key,
    required this.brightnessContext,
    required this.setBrightness,
  });

  @override
  Widget build(BuildContext context) {
    final brightness = context.watch(brightnessContext);
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
      onTap: toggleBrightness,
      title: const Text('Dark Mode'),
      leading: Icon(icon),
      trailing: Switch(
        value: isDarkMode,
        onChanged: (v) => toggleBrightness(),
      ),
    );
  }
}

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
