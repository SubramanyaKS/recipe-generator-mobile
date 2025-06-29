import 'package:flutter_dotenv/flutter_dotenv.dart';

final class Environment {
  static String get backendUrl =>dotenv.env['SERVER_URI']??"";

  static Future<void> load() async {
    await dotenv.load();
  }
}