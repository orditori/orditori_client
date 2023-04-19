import 'package:flutter/widgets.dart';
import 'package:flutter_compute_tree/flutter_compute_tree.dart';
import 'package:flutter_context/flutter_context.dart';
import 'package:orditori/context_node.dart';
import 'package:shared_preferences/shared_preferences.dart';

final tokenContext = createContext<String>();

class AuthNode extends ContextNode<String> {
  final String token;
  bool get isAuthenticated => token.isNotEmpty;

  final void Function(String token) setToken;
  final void Function() deleteToken;

  AuthNode({
    required this.token,
    required this.setToken,
    required this.deleteToken,
  });

  @override
  Context<String> get context => tokenContext;

  @override
  String get value => token;
}

AuthNode withAuth(CTNode n, SharedPreferences prefs) {
  final token = n.ref(() => prefs.getString('token') ?? '');
  final setToken = token.write;
  final deleteToken = token.action((value) => '');

  n.invoke.immediate(() {
    prefs.setString('token', token.value);
  }, token.value);

  return AuthNode(
    token: token.value,
    setToken: setToken,
    deleteToken: deleteToken,
  );
}

T withToken<T>(BuildContext context, T Function(String token) callback) {
  final token = context.read(tokenContext);
  return callback(token);
}
