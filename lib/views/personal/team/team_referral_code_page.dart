import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:treasure_nft_project/constant/global_data.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';
import 'package:treasure_nft_project/view_models/base_view_model.dart';
import 'package:treasure_nft_project/views/personal/team/share_picture_style.dart';
import 'package:treasure_nft_project/utils/app_text_style.dart';
import '../../../constant/theme/app_colors.dart';
import '../../../constant/theme/app_image_path.dart';
import '../../../constant/theme/app_theme.dart';
import '../../../models/http/parameter/check_share_center.dart';
import '../../../view_models/gobal_provider/user_info_provider.dart';
import '../../../view_models/personal/team/share_center_provider.dart';
import '../../../widgets/app_bottom_navigation_bar.dart';
import '../../../widgets/label/common_text_widget.dart';
import '../../custom_appbar_view.dart';
import '../../login/circle_network_icon.dart';

///MARK: 分享
class TeamReferralCodePage extends ConsumerStatefulWidget {
  const TeamReferralCodePage({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _TeamReferralCodePageState();
}

class _TeamReferralCodePageState extends ConsumerState<TeamReferralCodePage> {
  BaseViewModel viewModel = BaseViewModel();

  String get link {
    return '${GlobalData.urlPrefix}#/uc/register/?inviteCode=${ref.read(userInfoProvider).inviteCode}';
  }

  CheckShareCenter? get shareCenterInfo {
    return ref.read(shareCenterProvider);
  }

  @override
  void initState() {
    ref.read(shareCenterProvider.notifier).init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(userInfoProvider);
    ref.watch(shareCenterProvider);

    return CustomAppbarView(
        needCover: true,
        needScrollView: true,
        onLanguageChange: () {
          if (mounted) {
            setState(() {});
          }
        },
        body: Column(children: [
          _buildPersonalCardView(),
          _buildInviteView(context),
          _buildQRcodeView(context),
        ]),
        type: AppNavigationBarType.typePersonal);
  }

  Widget _backArrow() {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: Image.asset('assets/icon/btn/btn_arrowleft_01.png'),
    );
  }

  Widget _buildPersonalCardView() {
    return Container(
        color: AppColors.bolderGrey.withOpacity(0.4),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(
                  UIDefine.getScreenWidth(5),
                  UIDefine.getScreenWidth(16),
                  UIDefine.getScreenWidth(5),
                  UIDefine.getScreenWidth(5)),
              padding: EdgeInsets.fromLTRB(
                  UIDefine.getScreenWidth(4),
                  UIDefine.getScreenWidth(13),
                  UIDefine.getScreenWidth(4),
                  UIDefine.getScreenWidth(3)),
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  image: DecorationImage(
                      image:
                          AssetImage('assets/icon/img/img_background_01.png'),
                      fit: BoxFit.cover)),
              child: Column(
                children: [
                  // Flexible(
                  //   child:
                  CommonTextWidget(
                    text: ref.watch(userInfoProvider).name,
                    alignment: Alignment.center,
                    fontSize: UIDefine.fontSize14,
                    fontWeight: FontWeight.w600,
                  ),
                  // ),

                  const SizedBox(height: 10),

                  Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      border: Border.all(color: AppColors.textBlack, width: 1),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CommonTextWidget(
                          text: tr('teamIncome'),
                          alignment: Alignment.center,
                          fontSize: UIDefine.fontSize14,
                          fontWeight: FontWeight.w500,
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '${shareCenterInfo?.teamIncome.toString()} ${tr("usdt")}',
                                style: TextStyle(
                                  fontSize: UIDefine.fontSize18,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ]),
                        SizedBox(height: UIDefine.getScreenWidth(3)),
                      ],
                    ),
                  ),

                  SizedBox(height: UIDefine.getScreenWidth(5)),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(tr("24HourNo1'"),
                              style: AppTextStyle.getBaseStyle(
                                  fontSize: UIDefine.fontSize14,
                                  color: AppColors.textGrey)),
                          Text(
                              '${shareCenterInfo?.no1DirectIncome.toString()} ${tr('usdt')}',
                              style: AppTextStyle.getBaseStyle(
                                  fontSize: UIDefine.fontSize16,
                                  color: AppColors.textBlack))
                        ],
                      ),
                      Text('ID ${shareCenterInfo?.no1DirectId ?? ""}',
                          style: AppTextStyle.getBaseStyle(
                              fontSize: UIDefine.fontSize14,
                              color: AppColors.textGrey)),
                    ],
                  ),
                ],
              ),
            ),
            Positioned(
                top: UIDefine.getScreenWidth(5),
                child: Container(
                    decoration: AppTheme.style.baseGradient(radius: 35),
                    padding: const EdgeInsets.all(1.5),
                    child: ref.watch(userInfoProvider).photoUrl.isNotEmpty
                        ? CircleNetworkIcon(
                            showNormal: true,
                            networkUrl: ref.watch(userInfoProvider).photoUrl,
                            radius: 35)
                        : Image.asset(
                            AppImagePath.avatarImg,
                            width: UIDefine.getScreenWidth(18.66),
                            height: UIDefine.getScreenWidth(18.66),
                          ))),
            Positioned(
                left: UIDefine.getScreenWidth(2.77),
                top: UIDefine.getScreenWidth(4),
                child: _backArrow())
          ],
        ));
  }

  Widget _buildInviteView(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(UIDefine.getScreenWidth(5.5)),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SizedBox(height: UIDefine.getPixelHeight(10)),
          Row(
            children: [
              Expanded(
                child: Text(tr("shareCenterTitle"),
                    style: AppTextStyle.getBaseStyle(
                        fontSize: UIDefine.fontSize20,
                        fontWeight: FontWeight.w600)),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(PageRouteBuilder(
                      opaque: false,
                      pageBuilder: (context, animation, secondaryAnimation) {
                        return SharePicStyle(
                          link: link,
                        );
                      }));
                },
                child: Image.asset('assets/icon/btn/btn_share_02.png'),
              )
            ],
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: UIDefine.getPixelHeight(5)),
            child: Text(tr("shareCenterSubTitle"),
                style: AppTextStyle.getBaseStyle(
                    color: AppColors.dialogGrey,
                    fontSize: UIDefine.fontSize12,
                    fontWeight: FontWeight.normal)),
          ),
        ]));
  }

  Widget _buildQRcodeView(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
      SizedBox(height: UIDefine.getPixelHeight(5)),

      /// QRCode
      QrImage(
          errorStateBuilder: (context, error) => Text(error.toString()),
          data: link,
          version: QrVersions.auto,
          size: UIDefine.getScreenWidth(60),
          foregroundColor: AppColors.mainThemeButton),
      SizedBox(height: UIDefine.getPixelHeight(20)),

      _copyArea(context)
    ]);
  }

  Widget _copyArea(BuildContext context) {
    TextStyle styleBlack = AppTextStyle.getBaseStyle(
        fontSize: UIDefine.fontSize18, fontWeight: FontWeight.w600);
    TextStyle styleGrey = AppTextStyle.getBaseStyle(
        fontSize: UIDefine.fontSize14,
        fontWeight: FontWeight.w500,
        color: AppColors.dialogGrey);
    return IntrinsicWidth(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(ref.watch(userInfoProvider).inviteCode,
                textAlign: TextAlign.center, style: styleBlack),
            InkWell(
                onTap: () {
                  viewModel.copyText(
                      copyText: ref.watch(userInfoProvider).inviteCode);
                  viewModel.showToast(context, tr('copiedSuccess'));
                },
                child: Image.asset(AppImagePath.copyIcon))
          ]),
          SizedBox(height: UIDefine.getPixelHeight(12.5)),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            SizedBox(
                width: UIDefine.getScreenWidth(70),
                child:
                    Text(link, textAlign: TextAlign.center, style: styleGrey)),
            InkWell(
                onTap: () {
                  viewModel.copyText(copyText: link);
                  viewModel.showToast(context, tr('copiedSuccess'));
                },
                child: Image.asset(AppImagePath.copyIcon))
          ]),
          SizedBox(height: UIDefine.getScreenWidth(30)),
        ]));
  }
}
