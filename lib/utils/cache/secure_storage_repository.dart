import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:sample/utils/cache/storage_repository.dart';

class SecureStorageRepository implements StorageRepository {
  SecureStorageRepository();
  final storage = const FlutterSecureStorage();

  @override
  Future<void> write(String key, String value) async {
    return await storage.write(key: key, value: value);
  }

  @override
  Future<String?> read(String key) async {
    return await storage.read(key: key);
  }

  @override
  Future<void> delete(String key) async {
    return await storage.delete(key: key);
  }

  @override
  Future<void> deleteAll() async {
    return await storage.deleteAll();
  }

  @override
  Future<Map<String, String>> readAll() async {
    return await storage.readAll();
  }
}
