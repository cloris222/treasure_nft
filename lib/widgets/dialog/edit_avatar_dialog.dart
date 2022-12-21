import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:treasure_nft_project/constant/global_data.dart';
import 'package:treasure_nft_project/constant/theme/app_style.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';
import 'package:treasure_nft_project/models/http/api/common_api.dart';
import 'package:treasure_nft_project/models/http/api/user_info_api.dart';
import 'package:treasure_nft_project/utils/image_picker_util.dart';
import 'package:treasure_nft_project/widgets/dialog/base_dialog.dart';
import 'package:treasure_nft_project/widgets/label/gradually_network_image.dart';

import '../../constant/call_back_function.dart';
import '../../constant/theme/app_image_path.dart';
import '../../views/login/circle_network_icon.dart';
import '../button/action_button_widget.dart';

class EditAvatarDialog extends BaseDialog {
  EditAvatarDialog(super.context,
      {this.showTopBtn = false,
      required this.onChange,
      super.backgroundColor = Colors.transparent,
      required this.isAvatar});

  bool showTopBtn;
  final onClickFunction onChange;
  bool isAvatar;

  @override
  Widget initContent(BuildContext context, StateSetter setState) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: AppStyle().styleColorBorderBackground(color: Colors.white),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                tr('edit'),
                style: TextStyle(
                    fontSize: UIDefine.fontSize20, fontWeight: FontWeight.w400),
              ),
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.close,
                  color: Colors.black,
                ),
              )
            ],
          ),
          SizedBox(height: UIDefine.getScreenHeight(1)),
          isAvatar ? _buildUserPhoto(setState) : _buildUserBanner(setState),
          SizedBox(height: UIDefine.getScreenHeight(1)),
          Visibility(
            visible: showTopBtn,
            child: ActionButtonWidget(
              btnText: tr('gallery'),
              onPressed: () => _onChooseGallery(setState),
              isBorderStyle: true,
              margin: EdgeInsets.only(
                  top: 10,
                  bottom: 5,
                  left: UIDefine.getWidth() / 10,
                  right: UIDefine.getWidth() / 10),
            ),
          ),
          ActionButtonWidget(
            btnText: tr('upload'),
            onPressed: () => _onChooseImage(setState),
            isBorderStyle: true,
            margin: EdgeInsets.only(
                top: 10,
                bottom: 5,
                left: UIDefine.getWidth() / 10,
                right: UIDefine.getWidth() / 10),
          ),
          ActionButtonWidget(
            btnText: tr('check'),
            onPressed: () => _onUploadImage(context),
            margin: EdgeInsets.symmetric(horizontal: UIDefine.getWidth() / 20),
          ),
        ],
      ),
    );
  }

  @override
  Widget initTitle() {
    return Container();
  }

  @override
  Future<void> initValue() async {}

  XFile? uploadFile;

  ///MARK: Banner
  Widget _buildUserPhoto(StateSetter setState) {
    double size = UIDefine.getWidth() / 2.5;

    ///MARK: 顯示上傳圖片
    if (uploadFile != null) {
      return CircleAvatar(
          radius: size / 2,
          backgroundImage: FileImage(File(uploadFile!.path)),
          backgroundColor: Colors.transparent);
    }

    ///MARK: 顯示預設圖片
    else if (GlobalData.userInfo.photoUrl.isEmpty) {
      return createImageWidget(
          asset: AppImagePath.avatarImg, width: size, height: size);
    }

    ///MARK: 原本圖片
    else {
      return CircleNetworkIcon(
          networkUrl: GlobalData.userInfo.photoUrl, radius: size / 2);
    }
  }

  _onChooseImage(StateSetter setState) async {
    uploadFile = await ImagePickerUtil().selectImage();
    setState(() {});
  }

  _onChooseGallery(StateSetter setState) {}

  _onUploadImage(BuildContext context) async {
    if (uploadFile != null) {
      ///MARK:上傳圖片
      var imageResponse = await CommonAPI().uploadImage(uploadFile!.path, uploadOriginalName: false);
      if (isAvatar) {
        await UserInfoAPI().setUserAvtar(imageResponse.data);
        GlobalData.userInfo.photoUrl = imageResponse.data;
      } else {
        await UserInfoAPI().setUserBanner(imageResponse.data);
        GlobalData.userInfo.bannerUrl = imageResponse.data;
      }
      // Share.shareXFiles([uploadFile!]);
      // GlobalData.printLog('!!!!!!!!!${uploadFile!.path}');
      onChange();
      closeDialog();
    } else {
      closeDialog();
    }
  }

  Widget _buildUserBanner(StateSetter setState) {
    DecorationImage? image;
    if (uploadFile != null) {
      image = DecorationImage(
          image: FileImage(File(uploadFile!.path)), fit: BoxFit.fill);
    } else if (GlobalData.userInfo.bannerUrl.isEmpty) {
      image = const DecorationImage(
          image: AssetImage(AppImagePath.defaultBanner), fit: BoxFit.fill);
    }

    return image == null
        ? GraduallyNetworkImage(
            imageUrl: GlobalData.userInfo.bannerUrl,
            height: UIDefine.getHeight() / 4,
            width: UIDefine.getWidth(),
            fit: BoxFit.fill,
          )
        : Container(
            height: UIDefine.getHeight() / 4,
            width: UIDefine.getWidth(),
            decoration: BoxDecoration(image: image));
  }
}
