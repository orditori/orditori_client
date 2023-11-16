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

class Root extends CTWidget<()> {
  const Root({super.key, super.context = ()});

  @override
  Widget build(CTNode n, () context) {
    final brightnessContext = withBrightness(n);
    final (:tokenContext, :token, :isAuthenticated) = withAuth(n);

    final loginBuilder = n.memo(
      (_, __) => LoginScreen(
        context: (setToken: tokenContext.setToken),
      ),
    );

    if (!isAuthenticated) {
      return App(
        context: (brightness: brightnessContext.brightness,),
        builder: loginBuilder,
      );
    }

    final authenticatedBuilder = n.memo((
      CTNode n,
      Token<Ref<EdgeInsets>> padding,
    ) {
      return withNotebooks(
        n: n,
        token: token,
        padding: padding,
        builder: (child, [context]) {
          return AppPages(
            context: (
              padding: padding,
              brightnessContext: brightnessContext,
              tokenContext: tokenContext,
              notebooksContext: context,
            ),
            child: child,
          );
        },
      );
    });

    return App(
      context: (brightness: brightnessContext.brightness,),
      builder: authenticatedBuilder,
    );
  }
}

const borderRadius = BorderRadius.all(Radius.circular(10.0));
const shape = RoundedRectangleBorder(borderRadius: borderRadius);
const padding = EdgeInsets.all(20.0);

typedef AppTokens = ({
  Token<Ref<Brightness>> brightness,
});

class App extends CTWidget<AppTokens> {
  final Widget Function(CTNode n, Token<Ref<EdgeInsets>> padding) builder;

  const App({
    super.key,
    required super.context,
    required this.builder,
  });
  @override
  Widget build(CTNode n, AppTokens context) {
    final brightness = n.consume(context.brightness).subscribe();

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
        child: CTBuilder(
          (n, context) {
            final w = MediaQuery.of(n.context).size.width;
            final padding = ((w - 700) / 2).clamp(0.0, 600.0);

            final paddingRef = n.ref(
              () => EdgeInsets.symmetric(horizontal: padding),
              (padding,),
            );

            return builder(n, paddingRef.provide());
          },
          context: (),
          when: (_, __) => true,
        ),
      ),
    );
  }
}

typedef AppPagesTokens = ({
  Token<Ref<EdgeInsets>> padding,
  BrightnessContext brightnessContext,
  TokenContext tokenContext,
  NotebooksContext? notebooksContext,
});

class AppPages extends CTWidget<AppPagesTokens> {
  final Widget? child;

  const AppPages({
    super.key,
    required super.context,
    this.child,
  });

  @override
  bool shouldUpdate(CTNode node, AppPages oldWidget, AppPages newWidget) {
    return oldWidget.context != newWidget.context;
  }

  @override
  Widget build(CTNode n, AppPagesTokens context) {
    final pageIndex = n.ref(() => 0);
    final setPage = pageIndex.action.setValue();
    final onExit = n.memo(() => setPage(0));

    List<Widget> children = [];

    if (child == null) {
      final notebooksContext = context.notebooksContext!;

      children = [
        Notebooks(
          context: (
            notebook: notebooksContext.notebook,
            padding: context.padding,
            refreshNotebook: notebooksContext.refreshNotebook,
            savedDefinitions: notebooksContext.savedDefinitions,
          ),
        ),
        SearchScreen(
          onExit: onExit,
          context: (
            padding: context.padding,
            notebook: notebooksContext.notebook,
            refreshNotebook: notebooksContext.refreshNotebook,
            savedDefinitions: notebooksContext.savedDefinitions,
          ),
        ),
        ExercisesScreen(
          onExit: onExit,
          context: (padding: context.padding,),
        ),
        SettingsScreen(
          context: (
            padding: context.padding,
            brightnessContext: context.brightnessContext,
            tokenContext: context.tokenContext,
          ),
        ),
      ];
    }

    return Navigator(
      key: ValueKey(pageIndex.value),
      onGenerateRoute: (settings) {
        return MaterialPageRoute(
          builder: (context) {
            final mq = MediaQuery.of(n.context);
            const navTypeBreakpoint = 600;

            final scaffold = Scaffold(
              bottomNavigationBar: mq.size.width < navTypeBreakpoint
                  ? NavigationBar(
                      selectedIndex: pageIndex.value,
                      onDestinationSelected: setPage.call,
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
                            onDestinationSelected: setPage.call,
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
                    Expanded(child: child ?? children[pageIndex.value]),
                  ],
                ),
              ),
            );

            return scaffold;
          },
          settings: settings,
        );
      },
    );
  }
}
