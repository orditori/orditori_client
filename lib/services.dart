import 'package:orditori/swagger_generated_code/orditori.swagger.dart';
import 'package:shared_preferences/shared_preferences.dart';

late final SharedPreferences prefs;
final client = Orditori.create(baseUrl: Uri.parse('http://2.205.69.119'));
