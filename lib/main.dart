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

import 'services.dart' as services;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  services.prefs = await SharedPreferences.getInstance();

  runApp(const Root());
}

class Root extends CTWidget {
  const Root({super.key});

  @override
  Widget build(CTNode n) {
    final brightness = withBrightness(n);
    final auth = withAuth(n);

    final settingsScreen = SettingsScreen(
      brightnessTile: BrightnessSettingTile(
        ref: brightness.ref,
        setBrightness: brightness.setBrightness,
      ),
      setBrightness: brightness.setBrightness,
      token: auth.token,
      deleteToken: auth.deleteToken,
    );

    final firstScreen = auth.isAuthenticated
        ? withNotebooks(
            n: n,
            token: auth.token,
            setToken: auth.setToken,
            builder: (refreshNotebook, child) {
              return AppPages(
                settings: settingsScreen,
                refreshNotebook: refreshNotebook,
                child: child,
              );
            },
          )
        : LoginScreen(setToken: auth.setToken);

    return App(
      brightnessRef: brightness.ref,
      child: firstScreen,
    );
  }
}

const borderRadius = BorderRadius.all(Radius.circular(10.0));
const shape = RoundedRectangleBorder(borderRadius: borderRadius);
const padding = EdgeInsets.all(20.0);

class App extends CTWidget {
  final Ref<Brightness> brightnessRef;
  final Widget child;

  const App({
    super.key,
    required this.brightnessRef,
    required this.child,
  });

  @override
  Widget build(CTNode n) {
    final brightness = n.subscribeToRef(brightnessRef);

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
  Widget build(CTNode n) {
    final pageIndex = n.ref(() => 0);
    final onExit = n.memo(() => pageIndex.write(0));

    final children = [
      Notebooks(refreshNotebook: refreshNotebook),
      SearchScreen(onExit: onExit, refreshNotebook: refreshNotebook),
      ExercisesScreen(onExit: onExit),
      settings,
    ];

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
        child: child ?? children[pageIndex.value],
      ),
    );
  }
}
