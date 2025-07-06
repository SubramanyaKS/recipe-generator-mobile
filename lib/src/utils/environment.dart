import 'package:flutter_dotenv/flutter_dotenv.dart';

final class Environment {
  static String get backendUrl =>dotenv.env['SERVER_URI']??"";
  static String get firebaseAndroidApi => dotenv.env['FIREBASE_ANDROIDAPI']??"";
  static String get firebaseAndroidAppId =>dotenv.env["FIREBASE_ANDROIDAPPID"]??"";
  static String get firebaseIosApi => dotenv.env['FIREBASE_IOSAPI']??"";
  static String get firebaseIosAppId =>dotenv.env["FIREBASE_IOSAPPID"]??"";
  static String get firebaseMessageId => dotenv.env['FIREBASE_MESSAGINGID']??"";
  static String get firebaseProjectId =>dotenv.env["FIREBASE_PROJECTID"]??"";
  static String get firebaseStorageBucket => dotenv.env['FIREBASE_STORAGEBUCKET']??"";
  static String get firebaseIosBundleId =>dotenv.env["FIREBASE_IOSBUNDLEID"]??"";
  static String get firebaseWebApi => dotenv.env["FIREBASE_WEBAPI"]??"";
  static String get firebaseWebAppId => dotenv.env["FIREBASE_WEBAPPID"]??"";
  static String get firebaseAuthDomain => dotenv.env["FIREBASE_AUTHDOMAIN"]??"";

  static Future<void> load() async {
    await dotenv.load();
  }
}