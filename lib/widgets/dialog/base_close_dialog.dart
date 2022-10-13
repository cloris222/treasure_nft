import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:treasure_nft_project/constant/theme/app_style.dart';
import 'package:treasure_nft_project/widgets/dialog/base_dialog.dart';

abstract class BaseCloseDialog extends BaseDialog {
  BaseCloseDialog(super.context, {super.backgroundColor = Colors.transparent});

  @override
  Widget initContent(BuildContext context, StateSetter setState) {
     return Container(
      padding: const EdgeInsets.all(15),
      decoration: AppStyle().styleColorBorderBackground(color: Colors.white,radius: 10),
      child: buildBody(),
    );
  }

  @override
  Widget initTitle() {
    return Container();
  }

  @override
  void initValue() {
    // TODO: implement initValue
  }
  Widget buildBody();
}
