abstract interface class StorageService {
  Future<bool> isOnboardingSeen();
  Future<void> setOnboardingSeen();

  Future<bool> isAuthorized();
  Future<void> setAuthorized(bool value);

  Future<void> clearAuth();
}