import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:treasure_nft_project/constant/theme/app_theme.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';
import 'package:treasure_nft_project/views/home_page.dart';

import 'constant/global_data.dart';
import 'utils/language_util.dart';
import 'view_models/base_view_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  debugPaintSizeEnabled = true;

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
  // BaseViewModel baseViewModel = BaseViewModel();
  // await baseViewModel.getCountry();
  await LanguageUtil.init();
  runApp(localizations(const MyApp()));
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
      locale: LanguageUtil.getLocale(),
      navigatorKey: GlobalData.globalKey,
      title: 'TreasureNft',
      theme: AppTheme.define(),
      home: const HomePage(),
    );
  }
}
