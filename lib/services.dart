import 'package:chopper/chopper.dart';
import 'package:orditori/swagger_generated_code/orditori.swagger.dart';
import 'package:shared_preferences/shared_preferences.dart';

late final SharedPreferences prefs;
const kTokenKey = 'token-production';

late String token;

final client = Orditori.create(
  baseUrl: Uri.parse('http://2.205.69.119'),
  interceptors: [
    (Request request) {
      return request.copyWith(
        uri: request.uri.replace(
          queryParameters: {
            ...request.uri.queryParameters,
            'apiKey': token,
          },
        ),
      );
    }
  ],
);
