import 'package:get/get.dart';
import 'package:sample/utils/cache/secure_storage_repository.dart';
import 'package:sample/utils/cache/storage_repository.dart';

class CacheGetx extends GetxController {
  static const tag = "Cachegetx";
  final StorageRepository storageRepository = SecureStorageRepository();

  String _locale = '';
  String _theme = '';

  void setLocale(String locale) => _locale = locale;
  void setTheme(String theme) => _theme = theme;

  String get locale => _locale;
  String get theme => _theme;
  Future<void> saveToDisk() async {
    await storageRepository.write('locale', _locale);
    //await storageRepository.write('theme', _theme);
  }

  Future<void> loadFromDisk() async {
    _locale = await storageRepository.read('locale') ?? '';
    _theme = await storageRepository.read('theme') ?? '';
  }
}
