import 'package:flutter/material.dart';

///MARK: 放會重複用到的Style
class AppStyle {
  Widget styleFillText(String text,
      {TextStyle style = const TextStyle(),
      double minHeight = 20,
      EdgeInsetsGeometry margin = EdgeInsets.zero,
      AlignmentGeometry alignment = Alignment.centerLeft,
      GlobalKey? key}) {
    return Container(
        key: key,
        alignment: alignment,
        margin: margin,
        constraints: BoxConstraints(minHeight: minHeight),
        child: Text(text, style: style,));
  }
}
