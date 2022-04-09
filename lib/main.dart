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
        SystemChrome.setSystemUIOverlayStyle(
          SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness:
                value == Brightness.dark ? Brightness.light : Brightness.dark,
          ),
        );

        return MaterialApp(
          title: 'Orditori',
          theme: ThemeData(
            brightness: value,
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ButtonStyle(
                padding: MaterialStateProperty.all(padding),
                shape: MaterialStateProperty.all(shape),
              ),
            ),
            inputDecorationTheme: InputDecorationTheme(
              border: InputBorder.none,
            ),
            cardTheme: const CardTheme(shape: shape),
          ),
          home: const Home(),
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
  late int pageIndex = services.Auth.getToken(context).isEmpty ? 1 : 0;

  late final ctrl = TabController(
    initialIndex: pageIndex,
    length: 3,
    vsync: this,
  )..addListener(onChange);

  onChange() {
    setState(() {
      pageIndex = ctrl.index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: TabBar(
        controller: ctrl,
        labelColor: Theme.of(context).colorScheme.secondary,
        unselectedLabelColor: Theme.of(context).colorScheme.onSurface,
        indicatorSize: TabBarIndicatorSize.label,
        indicatorWeight: 1,
        tabs: [
          Tab(icon: Icon(Icons.book)),
          Tab(icon: Icon(Icons.play_arrow_rounded)),
          Tab(icon: Icon(Icons.settings)),
        ],
      ),
      body: SafeArea(
        child: TabBarView(
          controller: ctrl,
          children: [
            const Notebooks(),
            const ExercisesScreen(),
            const SettingsScreen(),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndDocked,
      floatingActionButton: pageIndex == 0
          ? FloatingActionButton(
              child: const Icon(Icons.search),
              onPressed: () {
                final r = MaterialPageRoute(
                  builder: (context) => SearchScreen(
                    notebookId: Notebooks.widgetKey.currentState!.notebookId,
                    entries: Notebooks.widgetKey.currentState!.entries,
                  ),
                );

                Navigator.of(context).push(r);
              },
            )
          : null,
    );
  }
}
