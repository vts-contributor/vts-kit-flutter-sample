abstract class StorageRepository {
  Future<void> write(String key, String value);

  Future<String?> read(String key);

  Future<void> delete(String key);

  Future<void> deleteAll();

  Future<Map<String, String>> readAll();
}
