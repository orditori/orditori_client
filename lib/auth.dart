import 'package:flutter_compute_tree/flutter_compute_tree.dart';
import 'services.dart' as services;

class AuthNode {
  final String token;
  bool get isAuthenticated => token.isNotEmpty;

  final Trigger<String> setToken;
  final VoidTrigger deleteToken;

  AuthNode({
    required this.token,
    required this.setToken,
    required this.deleteToken,
  });
}

AuthNode withAuth(CTNode n) {
  final token = n.ref(() => services.prefs.getString(services.kTokenKey) ?? '');
  final setToken = token.action.setValue();
  final deleteToken = token.action((_) => '');

  n.invoke(() {
    services.token = token.value;
    services.prefs.setString(services.kTokenKey, token.value);
  }, token.value);

  token.provide();
  deleteToken.provide(VoidTrigger.token<String>());

  return AuthNode(
    token: token.value,
    setToken: setToken,
    deleteToken: deleteToken,
  );
}
