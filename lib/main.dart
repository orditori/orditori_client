import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_compute_tree/flutter_compute_tree.dart';
import 'package:orditori/login/login_screen.dart';
import 'package:orditori/search/search_screen.dart';
import 'package:orditori/settings/settings_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'exercises/exercises_screen.dart';
import 'notebooks.dart';
import 'notebooks/notebooks_screen.dart';

import 'auth.dart';
import 'brightness.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();

  runApp(
    CTBuilder((context) {
      final brightness = withBrightness(prefs);
      final auth = withAuth(prefs);

      final settingsScreen = SettingsScreen(
        brightnessContext: brightness.context,
        setBrightness: brightness.setBrightness,
        token: auth.token,
        deleteToken: auth.deleteToken,
      );

      final firstScreen = auth.isAuthenticated
          ? withNotebooks(auth.token, (refreshNotebook, child) {
              return AppPages(
                settings: settingsScreen,
                refreshNotebook: refreshNotebook,
                child: child,
              );
            })
          : LoginScreen(setToken: auth.setToken);

      return auth.Provider(
        child: brightness.Provider(
          child: App(
            brightness: brightness.value,
            child: firstScreen,
          ),
        ),
      );
    }),
  );
}

const borderRadius = BorderRadius.all(Radius.circular(10.0));
const shape = RoundedRectangleBorder(borderRadius: borderRadius);
const padding = EdgeInsets.all(20.0);

class App extends StatelessWidget {
  final Brightness brightness;
  final Widget child;

  const App({
    super.key,
    required this.brightness,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Orditori',
      theme: ThemeData(
        brightness: brightness,
        useMaterial3: true,
        colorSchemeSeed: Colors.blue,
        chipTheme: const ChipThemeData(
          padding: EdgeInsets.all(4.0),
        ),
        inputDecorationTheme: const InputDecorationTheme(
          border: InputBorder.none,
        ),
        cardTheme: const CardTheme(shape: shape),
      ),
      home: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          statusBarBrightness: brightness == Brightness.dark
              ? Brightness.dark
              : Brightness.light,
          statusBarIconBrightness: brightness == Brightness.dark
              ? Brightness.light
              : Brightness.dark,
        ),
        child: child,
      ),
    );
  }
}

class AppPages extends CTWidget {
  final Widget settings;
  final Trigger refreshNotebook;
  final Widget? child;

  const AppPages({
    super.key,
    required this.settings,
    required this.refreshNotebook,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    final pageIndex = ref(() => 0);
    final onExit = memo(() => pageIndex.write(0));

    final children = ref(
      () => [
        Notebooks(refreshNotebook: refreshNotebook),
        SearchScreen(onExit: onExit, refreshNotebook: refreshNotebook),
        ExercisesScreen(onExit: onExit),
        settings,
      ],
    );

    return Scaffold(
      bottomNavigationBar: NavigationBar(
        selectedIndex: pageIndex.value,
        onDestinationSelected: pageIndex.write,
        destinations: const [
          NavigationDestination(icon: Icon(Icons.book), label: 'Notebook'),
          NavigationDestination(icon: Icon(Icons.search), label: 'Search'),
          NavigationDestination(
            icon: Icon(Icons.assignment),
            label: 'Exercises',
          ),
          NavigationDestination(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
      body: SafeArea(
        child: child ?? children.value[pageIndex.value],
      ),
    );
  }
}
