import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@module
abstract class RegisterModule {
  @lazySingleton
  Dio get dio => Dio();

  @lazySingleton
  SharedPreferencesAsync get prefs => SharedPreferencesAsync();

  @lazySingleton
  FlutterSecureStorage get secureStorage => const FlutterSecureStorage();
}