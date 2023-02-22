import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:orditori/services.dart';
import 'package:orditori/widgets/async_widget.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  void _setDarkMode(bool isDarkMode) {
    prefs
        .setString('brightness', isDarkMode ? 'dark' : 'light')
        .then((value) => AsyncWidget.reload<Brightness>());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Builder(
            builder: (context) {
              final isDarkMode =
                  AsyncWidget.read<Brightness>(context)! == Brightness.dark;

              return ListTile(
                onTap: () {
                  _setDarkMode(!isDarkMode);
                },
                title: const Text('Dark Mode'),
                leading: Icon(isDarkMode
                    ? Icons.dark_mode_sharp
                    : Icons.dark_mode_outlined),
                trailing: Switch(
                  value: isDarkMode,
                  onChanged: (v) {
                    _setDarkMode(v);
                  },
                ),
              );
            },
          ),
          ListTile(
            title: const Text('API Key'),
            subtitle: Text(
              Auth.getToken(context),
              maxLines: 1,
            ),
            leading: const Icon(Icons.vpn_key),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  onPressed: () {
                    final token = Auth.getToken(context);
                    Clipboard.setData(ClipboardData(text: token));
                  },
                  icon: const Icon(Icons.copy),
                ),
                IconButton(
                  onPressed: () {
                    Auth.deleteToken(context);
                  },
                  icon: const Icon(Icons.delete),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
