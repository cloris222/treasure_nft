import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:treasure_nft_project/constant/global_data.dart';
import 'package:treasure_nft_project/constant/theme/app_style.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';
import 'package:treasure_nft_project/widgets/dialog/base_dialog.dart';

import '../../constant/theme/app_image_path.dart';
import '../button/action_button_widget.dart';

class EditAvatarDialog extends BaseDialog {
  EditAvatarDialog(super.context,
      {this.showTopBtn = false,
      required this.topBtnAction,
      required this.bottomBtnAction,
      required this.confirmBtnAction});

  bool showTopBtn;
  VoidCallback topBtnAction;
  VoidCallback bottomBtnAction;
  VoidCallback confirmBtnAction;

  @override
  Widget initContent(BuildContext context, StateSetter setState) {
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.all(15),
          // decoration: AppStyle().,
        ),
        Positioned(
          right: 0,
            top: 0,
            child: IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.dangerous_outlined,
            color: Colors.black,
          ),
        ))
      ],
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
}
