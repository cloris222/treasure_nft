import 'dart:io';
import 'dart:typed_data';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:share_plus/share_plus.dart';

import '../../constant/global_data.dart';
import '../../constant/theme/app_colors.dart';
import '../../constant/theme/app_image_path.dart';
import '../../constant/theme/app_style.dart';
import '../../constant/ui_define.dart';
import '../../models/http/parameter/user_info_data.dart';
import '../../utils/app_text_style.dart';
import '../../view_models/base_view_model.dart';
import '../../view_models/gobal_provider/user_info_provider.dart';
import '../../widgets/button/gradient_button_widget.dart';
import '../../widgets/button/login_button_widget.dart';
import '../../widgets/label/gradually_network_image.dart';
import '../../widgets/label/icon/level_icon_widget.dart';
import '../../widgets/label/icon/medal_icon_widget.dart';
import '../login/circle_network_icon.dart';
import 'dart:ui' as ui;

class CollectionMedalSharePage extends ConsumerStatefulWidget {
  const CollectionMedalSharePage({
    Key? key,
    required this.medal,
    required this.medalName,
  }) : super(key: key);
  final String medal;
  final String medalName;

  @override
  ConsumerState createState() => _CollectionMedalSharePageState();
}

class _CollectionMedalSharePageState
    extends ConsumerState<CollectionMedalSharePage> {
  GlobalKey repaintKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    UserInfoData userInfo = ref.watch(userInfoProvider);
    return Scaffold(
        backgroundColor: AppColors.opacityBackground,
        body: Container(
            alignment: Alignment.center,
            margin: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).padding.top, vertical: 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RepaintBoundary(
                    key: repaintKey,
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                        fit: BoxFit.fill,
                        alignment: Alignment.center,
                        matchTextDirection: true,
                        repeat: ImageRepeat.noRepeat,
                        image: AssetImage(AppImagePath.shareBackground),
                      )),
                      child: _buildShareImg(userInfo),
                    )),
                SizedBox(height: UIDefine.getPixelWidth(10)),
                Row(
                  children: [
                    Expanded(
                        child: LoginButtonWidget(
                            height: UIDefine.getPixelWidth(45),
                            margin: EdgeInsets.zero,
                            radius: 22,
                            btnText: tr("share"),
                            onPressed: _onShare)),
                    SizedBox(width: UIDefine.getPixelWidth(5)),
                    Expanded(
                        child: GradientButtonWidget(
                            height: UIDefine.getPixelWidth(45),
                            margin: EdgeInsets.zero,
                            radius: 22,
                            btnText: tr("cancel"),
                            onPressed: () => BaseViewModel().popPage(context))),
                  ],
                )
              ],
            )));
  }

  Widget _buildSpace() {
    return SizedBox(height: UIDefine.getScreenHeight(1.5));
  }

  Widget _buildShareImg(UserInfoData userInfo) {
    return Column(mainAxisSize: MainAxisSize.min, children: [
      Row(children: [
        Image.asset(AppImagePath.mainAppBarLogo,
            height: UIDefine.getScreenHeight(5), fit: BoxFit.fitHeight),
      ]),
      _buildSpace(),
      Stack(
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: UIDefine.getPixelWidth(30)),
              Container(
                decoration: AppStyle().styleColorsRadiusBackground(),
                padding: EdgeInsets.symmetric(
                    vertical: UIDefine.getPixelWidth(5),
                    horizontal: UIDefine.getPixelWidth(10)),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildUserInfo(userInfo),
                    _buildMedalView(),
                    SizedBox(height: UIDefine.getPixelWidth(10))
                  ],
                ),
              ),
            ],
          ),
          Positioned(
              top: UIDefine.getPixelWidth(5),
              left: UIDefine.getPixelWidth(10),
              child: _buildUserIcon(userInfo)),
        ],
      ),
      _buildShareCode(userInfo),
    ]);
  }

  Widget _buildUserIcon(UserInfoData userInfo) {
    double iconHeight = UIDefine.getPixelWidth(60);
    return Container(
      decoration: AppStyle().styleColorsRadiusBackground(radius: 60),
      padding: EdgeInsets.all(UIDefine.getPixelWidth(5)),
      child: userInfo.photoUrl.isNotEmpty
          ? CircleNetworkIcon(
              showNormal: true,
              networkUrl: userInfo.photoUrl,
              radius: iconHeight / 2)
          : Image.asset(AppImagePath.avatarImg,
              width: iconHeight, height: iconHeight),
    );
  }

  Widget _buildUserInfo(UserInfoData userInfo) {
    return Padding(
      padding: EdgeInsets.only(
          top: UIDefine.getPixelWidth(10),
          bottom: UIDefine.getPixelWidth(30),
          left: UIDefine.getPixelWidth(80)),
      child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
        Text(
          userInfo.name,
          style: AppTextStyle.getBaseStyle(
              fontSize: UIDefine.fontSize14, fontWeight: FontWeight.w600),
        ),
        SizedBox(width: UIDefine.getPixelWidth(5)),
        LevelIconWidget(
            level: userInfo.level, size: UIDefine.getPixelWidth(20)),
        SizedBox(width: UIDefine.getPixelWidth(5)),
        userInfo.medal.isNotEmpty
            ? MedalIconWidget(
                medal: userInfo.medal,
                size: UIDefine.getPixelWidth(20),
              )
            : const SizedBox()
      ]),
    );
  }

  Widget _buildShareCode(UserInfoData userInfo) {
    double itemSize = UIDefine.getWidth() * 0.25;
    String link =
        '${GlobalData.urlPrefix}#/uc/register/?inviteCode=${userInfo.inviteCode}';
    return Column(mainAxisSize: MainAxisSize.min, children: [
      _buildSpace(),
      SizedBox(
          width: UIDefine.getWidth(),
          height: itemSize,
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Container(
              decoration: AppStyle().styleColorBorderBackground(
                  color: Colors.white,
                  backgroundColor: Colors.transparent,
                  radius: 3),
              child: QrImage(
                  errorStateBuilder: (context, error) => Text(error.toString()),
                  data: link,
                  version: QrVersions.auto,
                  size: itemSize,
                  foregroundColor: AppColors.mainThemeButton),
            ),
            SizedBox(width: UIDefine.getScreenWidth(3)),
            Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(tr('inviteCode'),
                      style: AppTextStyle.getBaseStyle(
                          color: AppColors.textSixBlack,
                          fontWeight: FontWeight.w400,
                          fontSize: UIDefine.fontSize10)),
                  Text(userInfo.inviteCode,
                      style: AppTextStyle.getBaseStyle(
                          color: AppColors.textBlack,
                          fontWeight: FontWeight.w600,
                          fontSize: UIDefine.fontSize18))
                ])
          ])),
      _buildSpace()
    ]);
  }

  Widget _buildMedalView() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Padding(
              padding: EdgeInsets.only(left: UIDefine.getPixelWidth(5)),
              child: Text(
                tr("appMyMedal"),
                style: AppTextStyle.getBaseStyle(
                    fontSize: UIDefine.fontSize12, fontWeight: FontWeight.w700),
              ),
            ),
            ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: GraduallyNetworkImage(
                  imageUrl: widget.medal,
                  width: UIDefine.getPixelWidth(130),
                  height: UIDefine.getPixelWidth(130),
                  fit: BoxFit.cover,
                )),
          ],
        ),
        SizedBox(width: UIDefine.getPixelWidth(5)),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(
                    left: UIDefine.getPixelWidth(5),
                    top: UIDefine.getPixelWidth(20)),
                child: Text(
                  tr("commemorativeBadge"),
                  style: AppTextStyle.getBaseStyle(
                      fontSize: UIDefine.fontSize12,
                      fontWeight: FontWeight.w700),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: UIDefine.getPixelWidth(5)),
                child: Text(
                  "#${widget.medalName}",
                  style: AppTextStyle.getBaseStyle(
                      fontSize: UIDefine.fontSize12,
                      fontWeight: FontWeight.w700),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  void _onShare() {
    _shareUiImage(repaintKey).then((value) => BaseViewModel().popPage(context));
  }

  /// 把图片ByteData写入File，并触发分享
  Future<void> _shareUiImage(GlobalKey key) async {
    ByteData? sourceByteData = await _capturePngToByteData(key);
    Uint8List sourceBytes = sourceByteData!.buffer.asUint8List();
    Directory tempDir = await getTemporaryDirectory();

    String storagePath = tempDir.path;
    File file = File('$storagePath/TreasureNFT.png');

    if (!file.existsSync()) {
      file.createSync();
    }
    file.writeAsBytesSync(sourceBytes);
    var shareFile = XFile((file.path));
    Share.shareXFiles([shareFile]);
  }

  /// 截屏图片生成图片流ByteData
  Future<ByteData?> _capturePngToByteData(GlobalKey key) async {
    try {
      RenderRepaintBoundary boundary =
      key.currentContext!.findRenderObject() as RenderRepaintBoundary;
      double dpr = ui.window.devicePixelRatio; // 获取当前设备的像素比
      ui.Image image = await boundary.toImage(pixelRatio: dpr);
      return await image.toByteData(format: ui.ImageByteFormat.png);
    } catch (e) {
      GlobalData.printLog(e.toString());
    }
    return null;
  }

}
