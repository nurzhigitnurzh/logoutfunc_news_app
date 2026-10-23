abstract interface class StorageService {
  Future<bool> isOnboardingSeen();
  Future<bool> isAuthorized();

  Future<void> setOnboardingSeen();
  Future<void> setAuthorized(bool value);
}