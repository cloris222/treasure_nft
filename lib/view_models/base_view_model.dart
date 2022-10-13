// ignore_for_file: use_build_context_synchronously

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../constant/global_data.dart';

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
      BuildContext context, String userId) async { // test
    // await pushPage(context, OtherPersonInfoPage(userId: userId));
  }

}
