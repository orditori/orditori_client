import 'package:microfrontends/microfrontends.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'state.dart';

class Token extends Boxed<String> {
  Token(String payload) : super(payload);
}

class UpdateToken extends Mutation<String> {
  UpdateToken(String payload) : super(payload);
}

class AuthStateContainer extends StateContainer<AuthState> {
  AuthStateContainer() : super(Unresolved());

  Future<String?> readToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('api_key');
  }

  boot(_) async* {
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
  }

  queries(_) {
    query((ctrl, value, arg) => Token((state as Authenticated).token));
    super.queries(_);
  }

  mutations(_) {
    mutation<UpdateToken>(
      (ctrl, state, mutation) {
        ctrl.run(() async* {
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('api_key', mutation!.payload);
          yield Authenticated(mutation.payload);
        });

        return state;
      },
    );

    super.mutations(_);
  }
}
