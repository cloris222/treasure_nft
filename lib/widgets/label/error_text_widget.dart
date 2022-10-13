import 'package:flutter/material.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';
import '../../models/data/validate_result_data.dart';

class ErrorTextWidget extends StatelessWidget {
  const ErrorTextWidget(
      {Key? key,
      required this.data,
      this.alignment = Alignment.centerLeft,
      this.fontSize})
      : super(key: key);
  final ValidateResultData data;
  final AlignmentGeometry alignment;
  final double? fontSize;

  @override
  Widget build(BuildContext context) {
    return Visibility(
        visible: !data.result,
        child: Container(
            alignment: alignment,
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(data.getMessage(),
                style: TextStyle(
                    color: data.textColor,
                    fontSize: fontSize ?? UIDefine.fontSize14))));
  }
}
