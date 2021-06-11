import 'package:flutter/widgets.dart';
import 'package:microfrontends/microfrontends.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'state.dart';

class Token extends Boxed<String> {
  Token(String payload) : super(payload);
}

class UpdateToken extends Mutation<String> {
  UpdateToken(String payload) : super(payload);
}

class AuthBinding extends Binding<AuthState> {
  AuthBinding({required Widget child}) : super(child: child);

  Future<String?> readToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('api_key');
  }

  @override
  StateContainer<AuthState> create(BuildContext context) {
    return container<AuthState>(Unresolved())
      ..boot((context) async* {
        try {
          final token = await readToken();

          if (token == null) {
            yield Unauthenticated();
          } else {
            yield Authenticated(token);
          }
        } catch (err) {
          yield Failed(err.toString());
        }
      })
      ..query<Token>(
        (ctrl, state, params) => Token((state as Authenticated).token),
      )
      ..mutation<UpdateToken>(
        (ctrl, state, mutation) {
          ctrl.run(() async* {
            final prefs = await SharedPreferences.getInstance();
            await prefs.setString('api_key', mutation!.payload);
            yield Authenticated(mutation.payload);
          });

          return state;
        },
      );
  }
}
