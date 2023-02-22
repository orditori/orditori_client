import 'package:flutter/widgets.dart';
import 'package:orditori/swagger_generated_code/orditori.swagger.dart';
import 'package:shared_preferences/shared_preferences.dart';

final client = Orditori.create(baseUrl: 'http://3.127.125.21');
late SharedPreferences prefs;
const baseUrl = 'http://3.127.125.21';

final _tokenKey = Object();

class Auth {
  static late String _token;
  static bool isAuthenticated(context) => getToken(context).isNotEmpty;

  static void init(BuildContext context) {
    _token = prefs.getString('token') ?? '';
    SharedAppData.setValue(context, _tokenKey, _token);
  }

  static setToken(BuildContext context, String value) {
    SharedAppData.setValue(
      context,
      _tokenKey,
      value,
    );

    prefs.setString('token', value);

    _token = value;
  }

  static String getToken(BuildContext context) {
    return SharedAppData.getValue<Object, String>(
      context,
      _tokenKey,
      () => '',
    );
  }

  static void deleteToken(BuildContext context) {
    _token = '';

    SharedAppData.setValue(
      context,
      _tokenKey,
      '',
    );

    prefs.remove('token');
  }
}
