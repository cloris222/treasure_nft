import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class LoadingFutureBuilder {
  LoadingFutureBuilder._();

  static Widget createLoadingWidget(
      {required Future<Widget> futureFunction,
      Widget loadingWidget = const SizedBox()}) {
    return FutureBuilder<Widget>(
        future: futureFunction,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          // 请求已结束
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              // 请求失败，显示错误
              return Text("${tr('error')}: ${snapshot.error}");
            } else {
              // 请求成功，显示数据
              return snapshot.data;
            }
          } else {
            // return Center(child: const Text('Loading'));
            return loadingWidget;
          }
        });
  }
}
