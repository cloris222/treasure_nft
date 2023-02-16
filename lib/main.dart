import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:treasure_nft_project/constant/theme/app_theme.dart';
import 'package:treasure_nft_project/views/splash_screen_page.dart';

import 'constant/global_data.dart';
import 'utils/language_util.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  debugPaintSizeEnabled = false;

  if (Platform.isAndroid) {
    ///MARK:
    /// 以下兩行 設定android狀態列為透明的沉浸。寫在元件渲染之後，是為了在渲染後進行set賦值，覆蓋狀態列，寫在渲染之前MaterialApp元件會覆蓋掉這個值。
    SystemUiOverlayStyle systemUiOverlayStyle =
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
  initApp();
}

Future<void> initApp() async {
  await LanguageUtil.init();
  runApp(ProviderScope(child: localizations(const MyApp())));
}

Widget localizations(Widget app) {
  // FmSharedPreferences.getLanguage().then((value) => {locale = value});
  return EasyLocalization(
      supportedLocales: LanguageUtil.getSupportLanguage(),
      // startLocale: GlobalData.locale,
      path: 'assets/translations',
      // <-- change the path of the translation files
      fallbackLocale: const Locale('en', 'US'),
      child: app);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    LanguageUtil.update(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: LanguageUtil.getAppLocale(),
      navigatorKey: GlobalData.globalKey,
      title: 'TreasureNft',
      theme: AppTheme.define(),
      builder: (context, widget) {
        ///MARK:textScaleFactor 控制文字比例大小
        ///MARK:boldText 控制文字粗體(測試無效果，可能要看看IOS)
        return MediaQuery(
            data: MediaQuery.of(context).copyWith(
              textScaleFactor: 1,
              // boldText: false,
            ),
            child: widget ?? const SizedBox());
      },
      home: const SplashScreenPage(),
    );
  }
}
