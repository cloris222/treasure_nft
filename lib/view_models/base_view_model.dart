// ignore_for_file: use_build_context_synchronously

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:treasure_nft_project/models/http/api/user_info_api.dart';

import '../constant/global_data.dart';
import '../models/http/parameter/api_response.dart';
import '../utils/app_shared_Preferences.dart';
import '../widgets/dialog/simple_custom_dialog.dart';

class BaseViewModel {
  BuildContext getGlobalContext() {
    return GlobalData.globalKey.currentContext!;
  }

  void showToast(BuildContext context, String text) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: Text(text),
      ),
    );
  }

  void buildHttpOnFail(BuildContext context, String errorMessage) {
    showToast(context, tr(errorMessage));
  }

  void copyText({required String copyText}) {
    Clipboard.setData(ClipboardData(text: copyText));
  }

  void clearAllFocus() {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  ///MARK: 推頁面 偷懶用
  void popPage(BuildContext context) {
    Navigator.pop(context);
  }

  ///MARK: 推新的一頁
  Future<void> pushPage(BuildContext context, Widget page) async {
    await Navigator.push(
        context, MaterialPageRoute(builder: (context) => page));
  }

  ///MARK: 取代當前頁面
  Future<void> pushReplacement(BuildContext context, Widget page) async {
    await Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => page));
  }

  ///MARK: 將前面的頁面全部清除只剩此頁面
  Future<void> pushAndRemoveUntil(BuildContext context, Widget page) async {
    await Navigator.pushAndRemoveUntil<void>(
      context,
      MaterialPageRoute<void>(builder: (BuildContext context) => page),
      (route) => false,
    );
  }

  ///MARK: 全域切頁面
  Future<void> globalPushAndRemoveUntil(Widget page) async {
    GlobalData.globalKey.currentState?.pushAndRemoveUntil<void>(
      MaterialPageRoute<void>(builder: (BuildContext context) => page),
      (route) => false,
    );
  }

  Future<void> pushOtherPersonalInfo(
      BuildContext context, String userId) async {
    // test
    // await pushPage(context, OtherPersonInfoPage(userId: userId));
  }

  ///MARK: 推透明的頁面
  Future<void> pushOpacityPage(BuildContext context, Widget page) async{
    Navigator.of(context).push(PageRouteBuilder(
        pageBuilder: (BuildContext buildContext, Animation<double> animation,
            Animation<double> secondaryAnimation) {
          return page;
        },
        opaque: false));
  }

  ///MARK: 更新使用者資料
  Future<void> saveUserLoginInfo({required ApiResponse response}) async {
    await AppSharedPreferences.setMemberID(response.data['id']);
    await AppSharedPreferences.setToken(response.data['token']);
    GlobalData.userToken = response.data['token'];
    GlobalData.userMemberId = response.data['id'];

    await uploadPersonalInfo();
    GlobalData.login = true;

    AppSharedPreferences.printAll();
  }

  Future<void> uploadPersonalInfo() async {
    GlobalData.userInfo = await UserInfoAPI().getPersonInfo();
  }

  ///MARK: 通用的 單一彈錯視窗
  onBaseConnectFail(BuildContext context, String message) {
    SimpleCustomDialog(context, mainText: message, isSuccess: false).show();
  }

  /// 自動轉換數字為 K & M
  String numberCompatFormat (String value) {
    if (value == '') {
      return '';
    }
    var formattedNumber = NumberFormat.compactCurrency(
      decimalDigits: 2,
      locale: 'en_US',
      symbol: '',
    ).format(double.parse(value));

    return formattedNumber;
  }

}
