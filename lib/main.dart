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
  Widget build(CTNode n, CTContext context) {
    withBrightness(n);
    final auth = withAuth(n);

    final firstScreen = auth.isAuthenticated
        ? withNotebooks(
            n: n,
            token: auth.token,
            setToken: auth.setToken,
            builder: (refreshNotebook, child) {
              return AppPages(
                refreshNotebook: refreshNotebook,
                child: child,
              );
            },
          )
        : LoginScreen(setToken: auth.setToken);

    return App(child: firstScreen);
  }
}

const borderRadius = BorderRadius.all(Radius.circular(10.0));
const shape = RoundedRectangleBorder(borderRadius: borderRadius);
const padding = EdgeInsets.all(20.0);

class App extends CTWidget {
  final Widget child;

  const App({
    super.key,
    required this.child,
  });

  @override
  Widget build(CTNode n, CTContext context) {
    final brightness = context.ref<Brightness>().subscribe();

    return MaterialApp(
      title: 'Orditori',
      theme: ThemeData(
        brightness: brightness,
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: brightness,
        ),
        chipTheme: const ChipThemeData(
          padding: EdgeInsets.all(4.0),
        ),
        inputDecorationTheme: const InputDecorationTheme(
          border: InputBorder.none,
        ),
        cardTheme: const CardTheme(
          shape: shape,
        ),
      ),
      home: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          statusBarBrightness: brightness == Brightness.dark
              ? Brightness.dark
              : Brightness.light,
          statusBarIconBrightness: brightness == Brightness.dark
              ? Brightness.light
              : Brightness.dark,
          statusBarColor: Colors.transparent,
        ),
        child: child,
      ),
    );
  }
}

class AppPages extends CTWidget {
  final VoidTrigger refreshNotebook;

  final Widget? child;

  const AppPages({
    super.key,
    required this.refreshNotebook,
    this.child,
  });

  @override
  Widget build(CTNode n, CTContext context) {
    final pageIndex = n.ref(() => 0);
    final setPage = pageIndex.action.setValue();
    final onExit = n.memo(() => setPage(0));

    final children = [
      Notebooks(refreshNotebook: refreshNotebook),
      SearchScreen(onExit: onExit, refreshNotebook: refreshNotebook),
      ExercisesScreen(onExit: onExit),
      const SettingsScreen(),
    ];

    final mq = MediaQuery.of(n.context);
    const navTypeBreakpoint = 600;

    return Scaffold(
      bottomNavigationBar: mq.size.width < navTypeBreakpoint
          ? NavigationBar(
              selectedIndex: pageIndex.value,
              onDestinationSelected: setPage,
              destinations: const [
                NavigationDestination(
                    icon: Icon(Icons.book), label: 'Notebook'),
                NavigationDestination(
                    icon: Icon(Icons.search), label: 'Search'),
                NavigationDestination(
                  icon: Icon(Icons.assignment),
                  label: 'Exercises',
                ),
                NavigationDestination(
                  icon: Icon(Icons.settings),
                  label: 'Settings',
                ),
              ],
            )
          : null,
      body: SafeArea(
        child: Row(
          children: [
            if (mq.size.width >= navTypeBreakpoint)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  child: NavigationRail(
                    backgroundColor: Colors.transparent,
                    onDestinationSelected: setPage,
                    extended: mq.size.width >= 800,
                    labelType: mq.size.width < 800
                        ? NavigationRailLabelType.all
                        : null,
                    destinations: const [
                      NavigationRailDestination(
                        icon: Icon(Icons.book),
                        label: Text('Notebook'),
                      ),
                      NavigationRailDestination(
                        icon: Icon(Icons.search),
                        label: Text('Search'),
                      ),
                      NavigationRailDestination(
                        icon: Icon(Icons.assignment),
                        label: Text('Exercises'),
                      ),
                      NavigationRailDestination(
                        icon: Icon(Icons.settings),
                        label: Text('Settings'),
                      ),
                    ],
                    selectedIndex: pageIndex.value,
                  ),
                ),
              ),
            Expanded(
              child: LayoutBuilder(builder: (context, constraints) {
                final w = constraints.biggest.width;
                final padding = ((w - 700) / 2).clamp(0.0, 600.0);

                return CTBuilder(
                  (n, context) {
                    final paddingRef = n.ref(
                      () => EdgeInsets.symmetric(horizontal: padding),
                      padding,
                    );

                    paddingRef.provide();

                    return child ?? children[pageIndex.value];
                  },
                  dep: Object.hash(padding, pageIndex.value),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
