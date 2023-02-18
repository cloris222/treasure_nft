import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:format/format.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:treasure_nft_project/constant/theme/app_colors.dart';
import 'package:treasure_nft_project/constant/theme/app_style.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';
import 'package:treasure_nft_project/models/http/api/common_api.dart';
import 'package:treasure_nft_project/models/http/api/user_info_api.dart';
import 'package:treasure_nft_project/models/http/http_setting.dart';
import 'package:treasure_nft_project/utils/image_picker_util.dart';
import 'package:treasure_nft_project/view_models/gobal_provider/user_info_provider.dart';
import 'package:treasure_nft_project/widgets/button/login_bolder_button_widget.dart';
import 'package:treasure_nft_project/widgets/button/login_button_widget.dart';
import 'package:treasure_nft_project/widgets/dialog/base_dialog.dart';
import 'package:treasure_nft_project/widgets/label/gradually_network_image.dart';
import 'package:treasure_nft_project/utils/app_text_style.dart';

import '../../constant/call_back_function.dart';
import '../../constant/theme/app_image_path.dart';
import '../../views/login/circle_network_icon.dart';

class EditAvatarDialog extends BaseDialog {
  EditAvatarDialog(super.context,
      {required this.onChange,
      super.backgroundColor = Colors.transparent,
      required this.isAvatar});

  bool showGallery = false;
  final onClickFunction onChange;
  bool isAvatar;
  int iPressIndex = -1;
  String selectedDefaultAvatar = '';

  @override
  Widget initContent(BuildContext context, StateSetter setState,WidgetRef ref) {
    return Stack(
      children: [
        ///MARK: 選擇從圖庫or上傳的視窗
        Visibility(
            visible: !showGallery,
            child: Container(
              padding: const EdgeInsets.all(15),
              decoration:
                  AppStyle().styleColorBorderBackground(color: Colors.white),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        tr('edit'),
                        style: AppTextStyle.getBaseStyle(
                            fontSize: UIDefine.fontSize20,
                            fontWeight: FontWeight.w400),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Image.asset(AppImagePath.dialogCloseBtn),
                      ),
                    ],
                  ),
                  SizedBox(height: UIDefine.getScreenHeight(2)),
                  Flexible(
                      child: Container(
                    height: 1,
                    color: AppColors.bolderGrey,
                  )),
                  SizedBox(height: UIDefine.getScreenHeight(2)),
                  isAvatar
                      ? _buildUserPhoto(setState,ref)
                      : _buildUserBanner(setState,ref),
                  SizedBox(height: UIDefine.getScreenHeight(1)),
                  LoginBolderButtonWidget(
                    btnText: tr('gallery'),
                    onPressed: () {
                      setState(() {
                        showGallery = true;
                      });
                    },
                    height: UIDefine.getScreenWidth(11),
                    margin: EdgeInsets.only(
                        top: UIDefine.getScreenWidth(2.77),
                        bottom: 5,
                        left: UIDefine.getScreenWidth(5.5),
                        right: UIDefine.getScreenWidth(5.5)),
                  ),
                  LoginBolderButtonWidget(
                    btnText: tr('upload'),
                    onPressed: () => _onChooseImage(setState),
                    height: UIDefine.getScreenWidth(11),
                    margin: EdgeInsets.only(
                        top: 5,
                        bottom: 5,
                        left: UIDefine.getScreenWidth(5.5),
                        right: UIDefine.getScreenWidth(5.5)),
                  ),
                  SizedBox(height: UIDefine.getScreenHeight(4)),
                  LoginButtonWidget(
                    isFillWidth: true,
                    btnText: tr('check'),
                    onPressed: () => _onUploadImage(context,ref),
                    // margin: EdgeInsets.symmetric(horizontal: UIDefine.getWidth() / 20),
                  ),
                ],
              ),
            )),

        ///MARK: 選擇預設圖的視窗
        Visibility(visible: showGallery, child: _onChooseGallery(setState))
      ],
    );
  }

  Widget _onChooseGallery(StateSetter setState) {
    return Container(
      width: UIDefine.getWidth(),
      height: UIDefine.getScreenHeight(64),
      padding: const EdgeInsets.all(15),
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
                style: AppTextStyle.getBaseStyle(
                    fontSize: UIDefine.fontSize20, fontWeight: FontWeight.w400),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Image.asset(AppImagePath.dialogCloseBtn),
              ),
            ],
          ),
          SizedBox(height: UIDefine.getScreenHeight(2)),
          Flexible(
              child: Container(
            height: 1,
            color: AppColors.bolderGrey,
          )),
          SizedBox(height: UIDefine.getScreenHeight(4)),
          GridView(
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 1.0,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10),
            children: _getDefaultAvatar(setState),
          ),
          SizedBox(height: UIDefine.getScreenHeight(4)),
          Flexible(
              child: Container(
            height: 1,
            color: AppColors.bolderGrey,
          )),
          SizedBox(height: UIDefine.getScreenHeight(4)),
          LoginButtonWidget(
            isFillWidth: true,
            btnText: tr('check'),
            // onPressed: () => _onUploadImage(context),
            onPressed: () {
              setState(() {
                showGallery = false;
              });
            },
          ),
        ],
      ),
    );
  }

  List<Widget> _getDefaultAvatar(StateSetter setState) {
    List<Widget> defaultAvatar = [];
    for (int i = 0; i < 9; i++) {
      defaultAvatar.add(GestureDetector(
          onTap: () {
            setState(() {
              iPressIndex = i;
              selectedDefaultAvatar =
                  format(AppImagePath.avatarImgs, ({'index': i.toString()}));
            });
          },
          child: Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                  color: iPressIndex == i
                      ? AppColors.dialogGrey.withOpacity(0.5)
                      : AppColors.transParent,
                  borderRadius: const BorderRadius.all(Radius.circular(20))),
              child: Image.asset(format(
                  AppImagePath.avatarImgs, ({'index': i.toString()}))))));
    }
    return defaultAvatar;
  }

  @override
  Widget initTitle() {
    return Container();
  }

  @override
  Future<void> initValue() async {}

  XFile? uploadFile;

  ///MARK: Banner
  Widget _buildUserPhoto(StateSetter setState, WidgetRef ref) {
    double size = UIDefine.getWidth() / 4;

    ///MARK: 顯示上傳圖片
    if (uploadFile != null) {
      return CircleAvatar(
          radius: size / 2,
          backgroundImage: FileImage(File(uploadFile!.path)),
          backgroundColor: Colors.transparent);
    }

    ///MARK: 顯示新選擇的預設圖片
    else if (selectedDefaultAvatar.isNotEmpty) {
      return createImageWidget(
          asset: selectedDefaultAvatar, width: size, height: size);
    }

    ///MARK: 顯示預設圖片
    else if (ref.watch(userInfoProvider).photoUrl.isEmpty) {
      return createImageWidget(
          asset: AppImagePath.avatarImg, width: size, height: size);
    }

    ///MARK: 原本圖片
    else {
      return CircleNetworkIcon(
          networkUrl:ref.watch(userInfoProvider).photoUrl, radius: size / 2);
    }
  }

  _onChooseImage(StateSetter setState) async {
    uploadFile = await ImagePickerUtil().selectImage();
    setState(() {});
  }

  _onUploadImage(BuildContext context, WidgetRef ref) async {
    if (uploadFile != null) {
      ///MARK:上傳圖片
      var imageResponse = await CommonAPI()
          .uploadImage(uploadFile!.path, uploadOriginalName: false);
      if (isAvatar) {
        await UserInfoAPI().setUserAvtar(imageResponse.data);
        ref.watch(userInfoProvider).photoUrl = imageResponse.data;
      } else {
        await UserInfoAPI().setUserBanner(imageResponse.data);
        ref.watch(userInfoProvider).bannerUrl = imageResponse.data;
      }
      // Share.shareXFiles([uploadFile!]);
      // GlobalData.printLog('!!!!!!!!!${uploadFile!.path}');
      onChange();
    } else if (selectedDefaultAvatar.isNotEmpty) {
      ///release
      ///https://image.treasurenft.xyz/Treasure2.5/img/img_avatar_01_defult.png
      ///https://image.treasurenft.xyz/img/img_Default%20_01.png
      ///debug
      ///https://devimage.treasurenft.xyz/Treasure2.5/img/img_avatar_01_defult.png
      ///https://devimage.treasurenft.xyz/img/img_Default%20_07.png

      String imageUrl;
      if (iPressIndex == 0) {
        imageUrl = format('{domain}/Treasure2.5/img/img_avatar_01_defult.png',
            {"domain": HttpSetting.imgUrl});
      } else {
        imageUrl = format('{domain}/img/img_Default _0{index}.png',
            {"domain": HttpSetting.imgUrl, "index": iPressIndex});
      }
      await UserInfoAPI().setUserAvtar(imageUrl);
      ref.watch(userInfoProvider).photoUrl = imageUrl;
      onChange();
    }
    closeDialog();
  }

  Future<File> getImageFileFromAssets(String path) async {
    path = path.replaceAll('assets/', '');
    final byteData = await rootBundle.load('assets/$path');
    final file = File('${(await getTemporaryDirectory()).path}/$path');
    await file.writeAsBytes(byteData.buffer
        .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));

    return file;
  }

  Widget _buildUserBanner(StateSetter setState, WidgetRef ref) {
    DecorationImage? image;
    if (uploadFile != null) {
      image = DecorationImage(
          image: FileImage(File(uploadFile!.path)), fit: BoxFit.fill);
    } else if (ref.watch(userInfoProvider).bannerUrl.isEmpty) {
      image = const DecorationImage(
          image: AssetImage(AppImagePath.defaultBanner), fit: BoxFit.fill);
    }

    return image == null
        ? GraduallyNetworkImage(
            imageUrl: ref.watch(userInfoProvider).bannerUrl,
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
