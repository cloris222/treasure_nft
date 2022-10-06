import 'package:flutter/material.dart';

class CustomAppBar {
  const CustomAppBar._();

  static AppBar _getCustomAppBar(
      {required List<Widget> actions,
      Color color = Colors.white,
      EdgeInsetsGeometry? margin,
      MainAxisAlignment mainAxisAlignment = MainAxisAlignment.start}) {
    return AppBar(elevation: 0, backgroundColor: color, actions: <Widget>[
      Flexible(
          child: Container(
              margin: margin,
              constraints: const BoxConstraints.expand(),
              child:
                  Row(mainAxisAlignment: mainAxisAlignment, children: actions)))
    ]);
  }
  static AppBar getCustomAppBar({required List<Widget> actions}){
    return _getCustomAppBar(actions: actions);
  }
}
