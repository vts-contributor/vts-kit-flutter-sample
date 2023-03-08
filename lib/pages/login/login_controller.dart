import 'package:flutter/material.dart';
import 'package:flutter_core/extensions/extensions.dart';
import 'package:get/get.dart';
import 'package:sample/pages/settings/setting_getx_controller.dart';
import 'package:sample/theme/theme.dart';
import 'package:sample/theme/theme_getx_controller.dart';
import 'package:sample/utils/cache/cache_getx_controller.dart';
import 'package:sample/utils/cache/secure_storage_repository.dart';
import 'package:sample/utils/cache/storage_repository.dart';

class LoginController extends GetxController {
  LoginController({required this.viewKey});

  final StorageRepository storageRepository = SecureStorageRepository();
  Rx<String> selectTheme = Rx<String>("");

  initState() async {
    loadCacheFromDisk();
  }

  toggleSelectTheme(String value) {
    selectTheme.value = value;
    storageRepository.write("theme", value.toString());
  }

  loadCacheFromDisk() async {
    await cacheGetX.loadFromDisk();
    if (cacheGetX.locale.isNotEmpty) {
      languageGetX.localeGetx.value = Locale(cacheGetX.locale);
    }
    if (cacheGetX.theme.isNotNull) {
      if (cacheGetX.theme == "primary_theme") {
        selectTheme.value = cacheGetX.theme;
        themeGetX.themeGetx.value = primaryTheme;
      } else if (cacheGetX.theme == "secondary_theme") {
        selectTheme.value = cacheGetX.theme;
        themeGetX.themeGetx.value = secondaryTheme;
      }
    } else {
      selectTheme.value = cacheGetX.theme;
      themeGetX.themeGetx.value = primaryTheme;
    }
  }

  saveCacheToDisk() async {
    cacheGetX.setLocale(languageGetX.localeGetx.value?.languageCode ?? '');
    await cacheGetX.saveToDisk();
  }

  final GlobalKey viewKey;
  final SettingGetX languageGetX = Get.find(tag: SettingGetX.tag);
  final CacheGetx cacheGetX = Get.find(tag: CacheGetx.tag);
  final ThemeGetX themeGetX = Get.find(tag: ThemeGetX.tag);
}
