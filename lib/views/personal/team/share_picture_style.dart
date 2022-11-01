import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:treasure_nft_project/constant/global_data.dart';
import 'package:treasure_nft_project/constant/theme/app_image_path.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';

import '../../../constant/theme/app_colors.dart';
import '../../../widgets/button/action_button_widget.dart';
import '../../../widgets/label/icon/level_icon_widget.dart';
import '../../../widgets/label/icon/medal_icon_widget.dart';
import '../../login/circle_network_icon.dart';

class SharePicStyle extends StatefulWidget {
  const SharePicStyle({Key? key, required this.link}) : super(key: key);

  final String link;

  @override
  State<SharePicStyle> createState() => _SharePicStyleState();
}

class _SharePicStyleState extends State<SharePicStyle> {
  //pageView
  PageController pageController = PageController(initialPage: 0);
  int pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.opacityBackground,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              tr("choosestyle"),
              style:
                  TextStyle(fontSize: UIDefine.fontSize20, color: Colors.white),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              tr("style${pageIndex+1}"),
              style:
                  TextStyle(fontSize: UIDefine.fontSize16, color: Colors.white),
            ),
            SizedBox(
              height: UIDefine.getHeight() / 50,
            ),
            SizedBox(
              height: UIDefine.getHeight() / 2,
              width: UIDefine.getWidth(),
              child: PageView(
                  controller: pageController,
                  scrollDirection: Axis.horizontal,
                  children: [
                    _shareImage(context, pageIndex),
                    _shareImage(context, pageIndex),
                  ],
                  onPageChanged: (index) {
                    setState(() {
                      pageIndex = index;
                    });
                  }),
            ),
            // _shareImage(context),
            SizedBox(
              height: UIDefine.getHeight() / 30,
            ),
            ActionButtonWidget(
              btnText: tr('confirm'),
              onPressed: () {
                Navigator.pop(context);
              },
              setHeight: 50,
              margin: const EdgeInsets.symmetric(horizontal: 20),
            )
          ],
        ),
      ),
    );
  }

  Widget _shareImage(BuildContext context, int index) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Image.asset(AppImagePath.shareBackground),
        Positioned(
            left: UIDefine.getWidth() / 9,
            top: 10,
            child: Image.asset(AppImagePath.mainAppBarLogo)),
        Positioned(
            left: 0,
            right: 0,
            top: UIDefine.getHeight() / 12,
            child: _shareImgHeader(context)),
      ],
    );
  }

  Widget _shareImgHeader(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GlobalData.userInfo.photoUrl.isNotEmpty
                ? CircleNetworkIcon(
                    networkUrl: GlobalData.userInfo.photoUrl, radius: 35)
                : Image.asset(
                    AppImagePath.avatarImg,
                    width: 70,
                    height: 70,
                  ),
            SizedBox(width: UIDefine.getScreenWidth(5)),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  GlobalData.userInfo.name,
                  style: TextStyle(fontSize: UIDefine.fontSize20),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ActionButtonWidget(
                        isFillWidth: false,
                        btnText: 'Level${GlobalData.userInfo.level}',
                        onPressed: () {}),
                    const SizedBox(width: 10),
                    LevelIconWidget(
                        level: GlobalData.userInfo.level,
                        size: UIDefine.fontSize30),
                    const SizedBox(width: 10),
                    GlobalData.userInfo.medal.isNotEmpty
                        ? MedalIconWidget(
                            medal: GlobalData.userInfo.medal,
                            size: UIDefine.fontSize30,
                          )
                        : Container()
                  ],
                ),
              ],
            ),
          ],
        ),
        SizedBox(
            width: UIDefine.getWidth() * 0.75,
            child: const Divider(
              thickness: 0.5,
              color: Colors.black,
            )),
        /// 下半部
        //const SizedBox(height: 10,),
        _shareImgBottom(context,pageIndex)
      ],
    );
  }

  Widget _shareImgBottom(BuildContext context,int index) {
    TextStyle styleBlack =
        TextStyle(fontSize: UIDefine.fontSize14, fontWeight: FontWeight.w600);
    TextStyle styleGrey = TextStyle(
        fontSize: UIDefine.fontSize14,
        fontWeight: FontWeight.w500,
        color: AppColors.dialogGrey);
    return Column(
      children: [
        index==0?Image.asset(AppImagePath.shareText1):Image.asset(AppImagePath.shareText2),
        QrImage(
          errorStateBuilder: (context, error) => Text(error.toString()),
          data: widget.link,
          version: QrVersions.auto,
          size: UIDefine.getScreenWidth(40),
          foregroundColor: AppColors.textBlack,
        ),
        Text(tr("referralLink"), style: styleGrey),
        Text(
          GlobalData.userInfo.inviteCode,
          textAlign: TextAlign.start,
          style: styleBlack,
        ),
      ],
    );
  }
}
