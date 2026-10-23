import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:home1/core/service/storage_service/storage_service.dart';

abstract final class _Keys {
  static const onboardingSeen = 'onboarding_seen';
  static const authorized = 'is_authorized';
}

@LazySingleton(as: StorageService)
class StorageServiceImpl implements StorageService {
  const StorageServiceImpl(this._prefs);

  final SharedPreferencesAsync _prefs;

  @override
  Future<bool> isOnboardingSeen() async =>
      await _prefs.getBool(_Keys.onboardingSeen) ?? false;

  @override
  Future<bool> isAuthorized() async =>
      await _prefs.getBool(_Keys.authorized) ?? false;

  @override
  Future<void> setOnboardingSeen() =>
      _prefs.setBool(_Keys.onboardingSeen, true);

  @override
  Future<void> setAuthorized(bool value) =>
      _prefs.setBool(_Keys.authorized, value);
}