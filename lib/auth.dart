import 'package:flutter_compute_tree/flutter_compute_tree.dart';
import 'services.dart' as services;

class AuthNode {
  final String token;
  bool get isAuthenticated => token.isNotEmpty;

  final void Function(String token) setToken;
  final Trigger<void> deleteToken;

  AuthNode({
    required this.token,
    required this.setToken,
    required this.deleteToken,
  });
}

AuthNode withAuth(CTNode n) {
  final token = n.ref(() => services.prefs.getString(services.kTokenKey) ?? '');
  final setToken = token.action((value, String arg) => arg);
  final deleteToken = token.action((value, _) => '');

  n.invoke(() {
    services.token = token.value;
    services.prefs.setString(services.kTokenKey, token.value);
  }, token.value);

  return AuthNode(
    token: token.value,
    setToken: setToken,
    deleteToken: deleteToken,
  );
}
