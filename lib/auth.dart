import 'package:flutter_compute_tree/flutter_compute_tree.dart';
import 'services.dart' as services;

typedef TokenContext = ({
  Token<Ref<String>> token,
  Token<Trigger<String>> setToken,
  Token<VoidTrigger> deleteToken,
});

typedef AuthContext = ({
  bool isAuthenticated,
  String token,
  TokenContext tokenContext,
});

AuthContext withAuth(CTNode n) {
  final token = n.ref(() => services.prefs.getString(services.kTokenKey) ?? '');
  final setToken = token.action.setValue();
  final deleteToken = token.action((_) => '');

  n.invoke(() {
    services.token = token.value;
    services.prefs.setString(services.kTokenKey, token.value);
  }, (token.value,));

  final tokenContext = (
    token: token.provide(),
    deleteToken: deleteToken.provide(),
    setToken: setToken.provide(),
  );

  return (
    isAuthenticated: token.value.isNotEmpty,
    token: token.value,
    tokenContext: tokenContext,
  );
}
