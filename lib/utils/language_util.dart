// ignore_for_file: use_build_context_synchronously

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../models/http/api/setting_enum.dart';
import 'app_shared_Preferences.dart';

class LanguageUtil {
  LanguageUtil._();

  static LanguageType _appLang = LanguageType.English;
  static String _strLanguage = '';

  /// 初始化語言
  static Future<void> init() async {
    _strLanguage = await AppSharedPreferences.getLanguage();
    debugPrint('_strLanguage:$_strLanguage!!');
  }

  static void update(BuildContext context) {
    if (_strLanguage.isEmpty) {
      /// 判斷手機語系
      _appLang = getLanguageTypeFromLocale(context.locale);
    } else {
      _appLang = getTypeLanguage(_strLanguage);
    }
  }

  static LanguageType getSettingLanguageType() {
    debugPrint('_appLang: ${_appLang.name}');
    return _appLang;
  }

  static List<Locale> getSupportLanguage() {
    return const [
      // Locale('en'),
      // Locale('zh'),
      Locale('es'),
      Locale('de'),
      Locale('fr'),
      Locale('en', 'US'),
      Locale('zh', 'TW'),
      Locale('zh', 'CN'),
      // Locale.fromSubtags(languageCode: 'zh', scriptCode: 'Hant'),
      Locale.fromSubtags(
          languageCode: 'zh', scriptCode: 'Hant', countryCode: 'TW')
    ];
  }

  static Future<void> setLanguageUtil(
      BuildContext context, LanguageType currentLanguage) async {
    // debugPrint('currentLanguage: ${currentLanguage.name}');
    _appLang = currentLanguage;
    _strLanguage = getStrLanguage();
    await AppSharedPreferences.setLanguage(_strLanguage);
    context.setLocale(getLocale());
  }

  /// 用於HttpManager 上，參考API文件的語系設定
  static String getStrLanguageForHttp() {
    switch (_appLang) {
      case LanguageType.Mandarin:
        return 'zh-TW';
      // case LanguageType.Chinese:
      //   return 'zh-CN';
      case LanguageType.English:
        return 'en-US';
      case LanguageType.Spanish:
        return 'es-ES';
      // case LanguageType.German:
      //   return 'de';
      // case LanguageType.French:
      //   return 'fr';
    }
  }

  ///MARK: 自動翻譯 & setLanguage用
  static String getStrLanguage() {
    switch (_appLang) {
      case LanguageType.Mandarin:
        return 'zh-TW';
      // case LanguageType.Chinese:
      //   return 'zh-CN';
      case LanguageType.English:
        return 'en-US';
      case LanguageType.Spanish:
        return 'es';
      // case LanguageType.German:
      //   return 'de';
      // case LanguageType.French:
      //   return 'fr';
    }
  }

  ///用於自動翻譯文字上
  static String getTranslationType() {
    if(getStrLanguage().toLowerCase() == 'en-us') {
      return 'en';
    } else {
      return getStrLanguage().toLowerCase();
    }
  }

  ///用於時間格式
  static String getTimeLocale() {
    Locale locale = LanguageUtil.getLocale();
    String strLocale = locale.languageCode;
    if (locale.countryCode != null) {
      if (locale.countryCode!.isNotEmpty) {
        strLocale = '${locale.languageCode}_${locale.countryCode}';
      }
    }
    return strLocale;
  }

  static LanguageType getTypeLanguage(String strLanguage) {
    switch (strLanguage) {
      case 'zh-TW':
        return LanguageType.Mandarin;
      // case 'zh-CN':
      //   return LanguageType.Chinese;
      case 'es':
        return LanguageType.Spanish;
      // case 'de':
      //   return LanguageType.German;
      // case 'fr':
      //   return LanguageType.French;
      case 'en-US':
      default:
        return LanguageType.English;
    }
  }

  static Locale getLocale() {
    switch (_appLang) {
      case LanguageType.Mandarin:
        return const Locale('zh', 'TW');
      // case LanguageType.Chinese:
      //   return const Locale('zh', 'CN');
      case LanguageType.English:
        return const Locale('en', 'US');
      case LanguageType.Spanish:
        return const Locale('es');
      // case LanguageType.German:
      //   return const Locale('de');
      // case LanguageType.French:
      //    return const Locale('fr');
    }
  }

  static LanguageType getLanguageTypeFromLocale(Locale locale) {
    /// 不支援的語言 會自動變成英文!!
    debugPrint(
        'getLanguageTypeFromLocale :${locale.languageCode}-${locale.countryCode}');

    if (locale.languageCode == 'zh' && locale.countryCode == 'TW') {
      return LanguageType.Mandarin;
    }
    // else if (locale.languageCode == 'zh' && locale.countryCode == 'CN') {
    //   return LanguageType.Chinese;
    // }
    else if (locale.languageCode == 'en' && locale.countryCode == 'US') {
      return LanguageType.English;
    } else if (locale.languageCode == 'es') {
      return LanguageType.Spanish;
    }
    // else if (locale.languageCode == 'de') {
    //   return LanguageType.German;
    // }
    // else if (locale.languageCode == 'fr') {
    //   return LanguageType.French;
    // }
    return LanguageType.English;
  }

  static String getLanguageName(LanguageType type) {
    switch (type) {
      case LanguageType.English:
        return 'English';
      // case LanguageType.Chinese:
      //   return '简体中文';
      case LanguageType.Mandarin:
        return '繁體中文';
      case LanguageType.Spanish:
        return 'Español';
      //   case LanguageType.German:
      //     return 'Deutsch';
      //   case LanguageType.French:
      //     return 'Français';
      // }
    }
  }
}
