import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:treasure_nft_project/constant/theme/app_theme.dart';
import 'package:treasure_nft_project/utils/app_shared_Preferences.dart';
import 'package:treasure_nft_project/utils/stomp_socket_util.dart';
import 'package:treasure_nft_project/views/main_page.dart';
import 'package:treasure_nft_project/widgets/app_bottom_navigation_bar.dart';

import 'constant/global_data.dart';
import 'utils/language_util.dart';
import 'view_models/base_view_model.dart';

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
  BaseViewModel viewModel = BaseViewModel();
  await viewModel.getCountry();
  await LanguageUtil.init();

  ///MARK: 自動登入
  try {
    if (await AppSharedPreferences.getLogIn()) {
      GlobalData.userToken = await AppSharedPreferences.getToken();
      GlobalData.userMemberId = await AppSharedPreferences.getMemberID();
      if (GlobalData.userToken.isNotEmpty &&
          GlobalData.userMemberId.isNotEmpty) {
        bool connectFail = false;

        List<bool> checkList = List<bool>.generate(3, (index) => false);
        viewModel.uploadPersonalInfo().then((value) {
          checkList[0] = true;
          if (value == false) {
            connectFail = true;
          }
        });
        viewModel.uploadSignInInfo().then((value) {
          checkList[1] = true;
          if (value == false) {
            connectFail = true;
          }
        });
        viewModel.uploadTemporaryData().then((value) {
          checkList[2] = true;
          if (value == false) {
            connectFail = true;
          }
        });

        await viewModel.checkFutureTime(
            logKey: 'autoLogin',
            onCheckFinish: () {
              return !checkList.contains(false) || connectFail;
            });
        if (!connectFail) {
          viewModel.startUserListener();
          GlobalData.showLoginAnimate = true;
        }
      }
    }
  } catch (e) {}
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
      locale: LanguageUtil.getAppLocale(),
      navigatorKey: GlobalData.globalKey,
      title: 'TreasureNft',
      theme: AppTheme.define(),
      home: const MainPage(),
    );
  }
}
