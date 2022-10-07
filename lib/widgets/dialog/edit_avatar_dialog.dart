import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:treasure_nft_project/constant/global_data.dart';
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
        Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Edit',
              style: TextStyle(
                  fontSize: UIDefine.fontSize24, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: UIDefine.getHeight() / 20,
            ),
            createImageWidget(asset: AppImagePath.avatarImg),
            Visibility(
              visible: showTopBtn,
              child: ActionButtonWidget(
                btnText: 'Gallery',
                onPressed: topBtnAction,
                isBorderStyle: true,
                margin: EdgeInsets.only(
                    top: 10,
                    bottom: 5,
                    left: UIDefine.getWidth() / 10,
                    right: UIDefine.getWidth() / 10),
              ),
            ),
            ActionButtonWidget(
              btnText: 'Upload Files',
              onPressed: bottomBtnAction,
              isBorderStyle: true,
              margin: EdgeInsets.only(
                  top: 10,
                  bottom: 5,
                  left: UIDefine.getWidth() / 10,
                  right: UIDefine.getWidth() / 10),
            ),
            ActionButtonWidget(
              btnText: 'Confirm',
              onPressed: confirmBtnAction,
              margin:
                  EdgeInsets.symmetric(horizontal: UIDefine.getWidth() / 20),
            ),
          ],
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
