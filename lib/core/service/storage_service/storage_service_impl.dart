import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:home1/core/service/storage_service/storage_service.dart';

abstract final class _Keys {
  static const onboardingSeen = 'onboarding_seen';
  static const authorized = 'is_authorized';
}

@LazySingleton(as: StorageService)
class StorageServiceImpl implements StorageService {
  const StorageServiceImpl(this._prefs, this._secure);

  final SharedPreferencesAsync _prefs;
  final FlutterSecureStorage _secure;

  @override
  Future<bool> isOnboardingSeen() async =>
      await _prefs.getBool(_Keys.onboardingSeen) ?? false;

  @override
  Future<void> setOnboardingSeen() =>
      _prefs.setBool(_Keys.onboardingSeen, true);

  @override
  Future<bool> isAuthorized() async =>
      await _secure.read(key: _Keys.authorized) == 'true';

  @override
  Future<void> setAuthorized(bool value) => value
      ? _secure.write(key: _Keys.authorized, value: 'true')
      : _secure.delete(key: _Keys.authorized);

  @override
  Future<void> clearAuth() => _secure.deleteAll();
}