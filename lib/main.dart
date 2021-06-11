import 'package:fetch/fetch.dart';
import 'package:flutter/material.dart';
import 'package:microfrontends/microfrontends.dart';
import 'package:orditori/domains/notebooks/state.dart';

import 'domains/auth/state.dart';
import 'domains/auth/binding.dart';
import 'pages/home.dart';
import 'pages/settings.dart';

void main() {
  FetchConfig.setBaseUrl('http://3.127.125.21/');

  runApp(Orditori());
}

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AuthBinding(
      child: context.subscribe<AuthState>(
        builder: (context, state, child) {
          if (state is Unresolved) return Container();
          if (state is Failed) return Text(state.errorMessage);
          if (state is Authenticated) {
            return context.subscribe<Token>(builder: (context, v, _) {
              return NotebooksStateBinding(
                key: GlobalKey(),
                child: child!,
              );
            });
          }

          return child!;
        },
        child: context.subscribe<AuthState>(
          builder: (context, authState, child) {
            if (authState is Unauthenticated) return Settings();
            if (authState is Authenticated) return Home();
            throw new Exception('Unknown auth state ${authState.runtimeType}');
          },
        ),
      ),
    );
  }
}

class Orditori extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        accentColor: Colors.pink,
        brightness: Brightness.dark,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(32),
              ),
            ),
          ),
        ),
        bottomSheetTheme: BottomSheetThemeData(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
          ),
        ),
      ),
      home: MainScreen(),
    );
  }
}
