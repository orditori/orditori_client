import 'package:chopper/chopper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:orditori/exercises/exercises_screen.dart';
import 'package:orditori/login/login_screen.dart';
import 'package:orditori/notebooks/notebooks_screen.dart';
import 'package:orditori/settings/settings_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'search/search_screen.dart';
import 'services.dart' as services;

import 'swagger_generated_code/orditori.swagger.dart' hide SolutionCheckResult;

import 'widgets/async_widget.dart';
import 'widgets/loading_indicator.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  services.prefs = await SharedPreferences.getInstance();

  runApp(const App());
}

const borderRadius = BorderRadius.all(Radius.circular(10.0));
const shape = RoundedRectangleBorder(borderRadius: borderRadius);
const padding = EdgeInsets.all(20.0);

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AsyncWidget<Brightness>(
      load: () async =>
          (services.prefs.getString('brightness') ?? 'light') == 'light'
              ? Brightness.light
              : Brightness.dark,
      error: const SizedBox(),
      loading: const SizedBox(),
      builder: (context, value) {
        return MaterialApp(
          title: 'Orditori',
          theme: ThemeData(
            brightness: value,
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
              statusBarBrightness:
                  value == Brightness.dark ? Brightness.dark : Brightness.light,
              statusBarIconBrightness:
                  value == Brightness.dark ? Brightness.light : Brightness.dark,
            ),
            child: const Home(),
          ),
        );
      },
    );
  }
}

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AsyncWidget<void>(
      load: () async => Future.microtask(() {
        services.Auth.init(context);
      }),
      loading: const SizedBox.shrink(),
      error: const Center(
        child: Material(child: Text('Failed to get token')),
      ),
      builder: (context, _) {
        if (!services.Auth.isAuthenticated(context)) {
          return const LoginScreen();
        }

        return Builder(
          builder: (context) {
            final token = services.Auth.getToken(context);

            return AsyncWidget<Response<NotebookR>>(
              load: () => services.client.notebooksGet(apiKey: token),
              loading: const LoadingIndicator(),
              error: const Material(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Center(
                    child: Text("Something went wrong"),
                  ),
                ),
              ),
              child: const AppPages(),
            );
          },
        );
      },
    );
  }
}

class AppPages extends StatefulWidget {
  const AppPages({Key? key}) : super(key: key);

  @override
  State<AppPages> createState() => _AppPagesState();
}

class _AppPagesState extends State<AppPages>
    with SingleTickerProviderStateMixin {
  late int pageIndex = 0;

  late final children = [
    const Notebooks(),
    SearchScreen(onExit: onExit),
    ExercisesScreen(onExit: onExit),
    const SettingsScreen(),
  ];

  void onExit() {
    setState(() {
      pageIndex = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        selectedIndex: pageIndex,
        onDestinationSelected: (index) {
          setState(() {
            pageIndex = index;
          });
        },
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
        child: children[pageIndex],
      ),
    );
  }
}
