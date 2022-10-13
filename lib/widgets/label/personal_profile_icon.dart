import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';

import '../../view_models/base_view_model.dart';

class PersonalProfileIcon extends StatefulWidget {
  PersonalProfileIcon(
      {Key? key,
      required this.userId,
      required this.avatar,
      this.backgroundColor = Colors.white,
      this.enable = true,
      this.isPersonalCenter = false,
      // this.modifyFile,
      this.isFromMsg = false,
      this.width = 72,
      this.height = 72,
      this.onIconPress})
      : super(key: key);
  final String userId;
  final String avatar;
  final Color backgroundColor;
  final bool enable;
  final bool isPersonalCenter;
  final bool isFromMsg;
  final AsyncCallback? onIconPress;
  final double width;
  final double height;

  // File? modifyFile;

  @override
  State<PersonalProfileIcon> createState() => _PersonalProfileIconState();
}

class _PersonalProfileIconState extends State<PersonalProfileIcon> {
  String get userId {
    return widget.userId;
  }

  String get avatar {
    return widget.avatar;
  }

  // File? get modifyFile {
  //   return widget.modifyFile;
  // }

  @override
  Widget build(BuildContext context) {
    return InkWell(onTap: () => _onPressIcon(context), child: _buildIcon());
  }

  _buildIcon() {
    ImageProvider provider;
    if (avatar.isNotEmpty) {
      provider = NetworkImage(avatar);
    } else {
      provider = const AssetImage("assets/no_image.png");
    }
    // if (isSelfIcon()) {
    //   if (modifyFile != null) {
    //     if (modifyFile!.path.isNotEmpty) {
    //       provider = FileImage(modifyFile!);
    //     }
    //   }
    // }

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
              color: Colors.grey,
              blurRadius: 4.0,
              offset: Offset(3.5, 3.5),
              spreadRadius: 2),
        ],
      ),
      child: Container(
          padding: EdgeInsets.all(UIDefine.getScreenWidth(1.38)),
          decoration: BoxDecoration(
            color: widget.backgroundColor,
            borderRadius: BorderRadius.circular(10),
          ),
          height: widget.height,
          width: widget.width,
          child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image(image: provider))),
    );
  }

  // bool isSelfIcon() {
  //   return (userInfo.memberId.compareTo(GlobalData.userInfo.memberId) == 0);
  // }

  _onPressIcon(BuildContext context) async {
    // if (!isSelfIcon() && widget.enable) {
    //   /// MARK: 代表非使用者本人
    //   if (widget.isFromMsg) {
    //     widget.onIconPress!();
    //   } else {
    //     BaseViewModel().pushOtherPersonalInfo(context, userInfo);
    //   }
    //
    //   /// 點擊頭像到personal information 編輯圖片
    // } else if (isSelfIcon() && widget.enable && widget.isPersonalCenter) {
    //   await Navigator.push(context,
    //       MaterialPageRoute(builder: (context) => const PersonalInformation()));
    //   widget.userInfo = GlobalData.userInfo;
    //   GlobalData.clearImageCache.clear();
    //   setState(() {});
    // }

    BaseViewModel().pushOtherPersonalInfo(context, userId);
  }
}
