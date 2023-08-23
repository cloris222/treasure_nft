// ignore_for_file: use_build_context_synchronously

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:treasure_nft_project/constant/global_data.dart';
import '../constant/enum/setting_enum.dart';
import 'app_shared_Preferences.dart';

class LanguageUtil {
  LanguageUtil._();

  static LanguageType _appLang = LanguageType.English;
  static String _strLanguage = '';

  /// 初始化語言
  static Future<void> init() async {
    _strLanguage = await AppSharedPreferences.getLanguage();
    GlobalData.printLog('_strLanguage:$_strLanguage!!');
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
    // GlobalData.printLog('_appLang: ${_appLang.name}');
    return _appLang;
  }

  static List<Locale> getSupportLanguage() {
    List<Locale> list = [];
    for (var element in LanguageType.values) {
      list.add(getLocale(element));
    }
    list.add(const Locale.fromSubtags(
        languageCode: 'zh', scriptCode: 'Hant', countryCode: 'TW'));
    return list;
  }

  static Future<void> setLanguageUtil(
      BuildContext context, LanguageType currentLanguage) async {
    // GlobalData.printLog('currentLanguage: ${currentLanguage.name}');
    _appLang = currentLanguage;
    _strLanguage = getAppStrLanguage();
    await AppSharedPreferences.setLanguage(_strLanguage);
    await context.setLocale(getAppLocale());
  }

  static Locale getAppLocale() {
    return getLocale(_appLang);
  }

  static String getAppStrLanguage() {
    return getStrLanguage(_appLang);
  }

  static String getAppStrLanguageForHttp() {
    return getStrLanguageForHttp(_appLang);
  }

  static String getAnnouncementLanguage(){
    return getStringAnnouncement(_appLang);
  }

  /// 用於HttpManager 上，參考API文件的語系設定
  static String getStrLanguageForHttp(LanguageType type) {
    switch (type) {
      case LanguageType.Mandarin:
        return 'zh-TW';
      case LanguageType.English:
        return 'en-US';
      case LanguageType.Arabic:
        return 'ar';
      case LanguageType.Farsi:
        return 'fa';
      case LanguageType.Spanish:
        return 'es-ES';
      case LanguageType.Russian:
        return 'ru';
      case LanguageType.Portuguese:
        return 'pt';
      case LanguageType.Korean:
        return 'ko';
      case LanguageType.Vietnamese:
        return 'vi';
      case LanguageType.Thai:
        return 'th';
      case LanguageType.Turkish:
        return 'tr';
      case LanguageType.Malaysia:
        return 'ms';
      case LanguageType.Indonesia:
        return 'id';
      case LanguageType.Chinese:
        return 'zh-CN';
      case LanguageType.Japan:
        return 'ja-JP';
      case LanguageType.Francais:
        return 'fr';
      case LanguageType.Bulgaria:
        return 'bg';
    }
  }

  ///MARK: 公告欄語言
  static String getStringAnnouncement(LanguageType type){
    switch (type) {
      case LanguageType.Mandarin:
        return 'tw';
      case LanguageType.English:
        return 'en';
      case LanguageType.Arabic:
        return 'ar';
      case LanguageType.Farsi:
        return 'ir';
      case LanguageType.Spanish:
        return 'es';
      case LanguageType.Russian:
        return 'ru';
      case LanguageType.Portuguese:
        return 'pt';
      case LanguageType.Korean:
        return 'kr';
      case LanguageType.Vietnamese:
        return 'vn';
      case LanguageType.Thai:
        return 'th';
      case LanguageType.Turkish:
        return 'tr';
      case LanguageType.Malaysia:
        return 'ma';
      case LanguageType.Indonesia:
        return 'id';
      case LanguageType.Chinese:
        return 'cn';
      case LanguageType.Japan:
        return 'jp';
      case LanguageType.Francais:
        return 'fr';
      case LanguageType.Bulgaria:
        return 'bg';
    }
  }

  ///MARK: 自動翻譯 & setLanguage用
  static String getStrLanguage(LanguageType type) {
    switch (type) {
      case LanguageType.Mandarin:
        return 'zh-TW';
      case LanguageType.English:
        return 'en-US';
      case LanguageType.Arabic:
        return 'ar';
      case LanguageType.Farsi:
        return 'fa';
      case LanguageType.Spanish:
        return 'es';
      case LanguageType.Russian:
        return 'ru';
      case LanguageType.Portuguese:
        return 'pt';
      case LanguageType.Korean:
        return 'ko';
      case LanguageType.Vietnamese:
        return 'vi';
      case LanguageType.Thai:
        return 'th';
      case LanguageType.Turkish:
        return 'tr';
      case LanguageType.Malaysia:
        return 'ms';
      case LanguageType.Indonesia:
        return 'id';
      case LanguageType.Chinese:
        return 'zh-CN';
      case LanguageType.Japan:
        return 'ja-JP';
      case LanguageType.Francais:
        return 'fr';
      case LanguageType.Bulgaria:
        return 'bg';
    }
  }

  ///用於自動翻譯文字上
  static String getTranslationType() {
    if (getAppStrLanguage().toLowerCase() == 'en-us') {
      return 'en';
    } else {
      return getAppStrLanguage().toLowerCase();
    }
  }

  ///用於時間格式
  static String getTimeLocale() {
    Locale locale = LanguageUtil.getAppLocale();
    String strLocale = locale.languageCode;
    if (locale.countryCode != null) {
      if (locale.countryCode!.isNotEmpty) {
        strLocale = '${locale.languageCode}_${locale.countryCode}';
      }
    }
    return strLocale;
  }

  static LanguageType getTypeLanguage(String strLanguage) {
    for (var element in LanguageType.values) {
      if (getStrLanguage(element) == strLanguage) {
        return element;
      }
    }
    return LanguageType.English;
  }

  static Locale getLocale(LanguageType type) {
    switch (type) {
      case LanguageType.Mandarin:
        return const Locale('zh', 'TW');
      case LanguageType.English:
        return const Locale('en', 'US');
      case LanguageType.Arabic:
        return const Locale('ar');
      case LanguageType.Farsi:
        return const Locale('fa');
      case LanguageType.Spanish:
        return const Locale('es');
      case LanguageType.Russian:
        return const Locale('ru');
      case LanguageType.Portuguese:
        return const Locale('pt');
      case LanguageType.Korean:
        return const Locale('ko');
      case LanguageType.Vietnamese:
        return const Locale('vi');
      case LanguageType.Thai:
        return const Locale('th');
      case LanguageType.Turkish:
        return const Locale('tr');
      case LanguageType.Malaysia:
        return const Locale('ms');
      case LanguageType.Indonesia:
        return const Locale('id');
      case LanguageType.Chinese:
        return const Locale('zh', 'CN');
      case LanguageType.Japan:
        return const Locale('ja', 'JP');
      case LanguageType.Francais:
        return const Locale('fr');
      case LanguageType.Bulgaria:
        return const Locale('bg');
    }
  }

  static LanguageType getLanguageTypeFromLocale(Locale locale) {
    /// 不支援的語言 會自動變成英文!!
    GlobalData.printLog(
        'getLanguageTypeFromLocale :${locale.languageCode}-${locale.countryCode}');

    if (locale.languageCode == 'zh' && locale.countryCode == 'TW') {
      return LanguageType.Mandarin;
    } else if (locale.languageCode == 'en' && locale.countryCode == 'US') {
      return LanguageType.English;
    } else if (locale.languageCode == 'ar') {
      return LanguageType.Arabic;
    } else if (locale.languageCode == 'fa') {
      return LanguageType.Farsi;
    } else if (locale.languageCode == 'es') {
      return LanguageType.Spanish;
    } else if (locale.languageCode == 'ru') {
      return LanguageType.Russian;
    } else if (locale.languageCode == 'pt') {
      return LanguageType.Portuguese;
    } else if (locale.languageCode == 'ko') {
      return LanguageType.Korean;
    } else if (locale.languageCode == 'vi') {
      return LanguageType.Vietnamese;
    } else if (locale.languageCode == 'th') {
      return LanguageType.Thai;
    } else if (locale.languageCode == 'tr') {
      return LanguageType.Turkish;
    } else if (locale.languageCode == 'ms') {
      return LanguageType.Malaysia;
    } else if (locale.languageCode == 'id') {
      return LanguageType.Indonesia;
    } else if (locale.languageCode == 'ja' && locale.countryCode == 'JP') {
      return LanguageType.Japan;
    } else if (locale.languageCode == 'zh' && locale.countryCode == 'CN') {
      return LanguageType.Chinese;
    }else if(locale.languageCode == 'fr' && locale.countryCode == "FR"){
      return LanguageType.Francais;
    }

    return LanguageType.English;
  }

  static String getLanguageName(LanguageType type) {
    switch (type) {
      case LanguageType.English:
        return tr('lang_en');
      case LanguageType.Mandarin:
        return tr('lang_tw');
      case LanguageType.Arabic:
        return tr('lang_ar');
      case LanguageType.Farsi:
        return tr('lang_ir');
      case LanguageType.Spanish:
        return tr('lang_es');
      case LanguageType.Russian:
        return tr('lang_ru');
      case LanguageType.Portuguese:
        return tr('lang_pt');
      case LanguageType.Korean:
        return tr('lang_kr');
      case LanguageType.Vietnamese:
        return tr('lang_vi');
      case LanguageType.Thai:
        return tr('lang_th');
      case LanguageType.Turkish:
        return tr('lang_tr');
      case LanguageType.Malaysia:
        return tr('lang_ma');
      case LanguageType.Indonesia:
        return tr('lang_id');
      case LanguageType.Chinese:
        return tr('lang_cn');
      case LanguageType.Japan:
        return tr('lang_jp');
      case LanguageType.Francais:
        return tr('lang_fr');
      case LanguageType.Bulgaria:
        return tr('bg');
    }
  }
}
