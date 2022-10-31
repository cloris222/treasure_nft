import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:treasure_nft_project/constant/global_data.dart';
import 'package:treasure_nft_project/constant/theme/app_style.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';
import 'package:treasure_nft_project/view_models/base_view_model.dart';
import 'package:treasure_nft_project/views/personal/orders/order_detail_page.dart';
import 'package:treasure_nft_project/views/personal/personal_sub_user_info_view.dart';
import 'package:treasure_nft_project/widgets/button/action_button_widget.dart';
import '../../../constant/theme/app_colors.dart';
import '../../../constant/theme/app_image_path.dart';
import '../../../view_models/personal/team/share_center_viewmodel.dart';
import '../../../widgets/app_bottom_navigation_bar.dart';
import '../../custom_appbar_view.dart';

///MARK: 分享
class TeamReferralCodePage extends StatefulWidget {
  const TeamReferralCodePage({Key? key}) : super(key: key);

  @override
  State<TeamReferralCodePage> createState() => _TeamReferralCodePageState();
}

class _TeamReferralCodePageState extends State<TeamReferralCodePage> {
  String data = '';
  late ShareCenterViewModel viewModel;

  String link =
      '${GlobalData.urlPrefix}#/uc/register/?inviteCode=${GlobalData.userInfo.inviteCode}';

  @override
  void initState() {
    viewModel = ShareCenterViewModel(setState: () {
      setState(() {});
    });
    viewModel.initState();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomAppbarView(
      title: tr('shareCenter'),
      body: Column(
        children: [
          const PersonalSubUserInfoView(),
          Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  _buildInviteView(context),
                  _buildQRcodeView(context),
                ],
              ))
        ],
      ),
      type: AppNavigationBarType.typePersonal,
    );
  }

  Widget _buildInviteView(BuildContext context) {
    TextStyle styleBlack =
        TextStyle(fontSize: UIDefine.fontSize14, fontWeight: FontWeight.w600);
    TextStyle styleGrey = TextStyle(
        fontSize: UIDefine.fontSize14,
        fontWeight: FontWeight.w500,
        color: AppColors.dialogGrey);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 20,
        ),
        Text(
          tr("shareCenterTitle"),
          style: TextStyle(
              fontSize: UIDefine.fontSize20, fontWeight: FontWeight.bold),
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 20),
          child: Text(
            tr("shareCenterSubTitle"),
            style: TextStyle(
                fontSize: UIDefine.fontSize12, fontWeight: FontWeight.normal),
          ),
        ),
        Container(
          height: UIDefine.getHeight() / 8,
          decoration: AppStyle().styleColorBorderBackground(
            radius: 15,
            color: AppColors.bolderGrey,
            backgroundColor: Colors.transparent,
            borderLine: 2,
          ),
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => OrderDetailPage()));
                      },
                      child: Row(
                        children: [
                          Image.asset(AppImagePath.rewardGradient),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            tr("teamIncome"),
                            style: TextStyle(
                                fontSize: UIDefine.fontSize14,
                                color: AppColors.textBlack),
                          )
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                            '${viewModel.shareCenterInfo?.teamIncome.toString()}'),
                        Image.asset(AppImagePath.rightArrow),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Image.asset(AppImagePath.clockGradient),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          tr("24HourNo1'"),
                          style: TextStyle(
                              fontSize: UIDefine.fontSize14,
                              color: AppColors.textBlack),
                        )
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            '${viewModel.shareCenterInfo?.no1DirectIncome.toString()}USDT'),
                        Row(
                          children: [
                            Text(
                              'ID',
                              style: styleGrey,
                            ),
                            Text(
                              viewModel.shareCenterInfo?.no1DirectId ?? "",
                              style: styleGrey,
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget _buildQRcodeView(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(
          height: 20,
        ),
        Text(
            tr(
              "referralQRcode",
            ),
            style: TextStyle(
                fontSize: UIDefine.fontSize20, fontWeight: FontWeight.w600)),
        const SizedBox(
          height: 10,
        ),

        /// QRCode
        QrImage(
          errorStateBuilder: (context, error) => Text(error.toString()),
          data: link,
          version: QrVersions.auto,
          size: UIDefine.getScreenWidth(41.6),
          foregroundColor: AppColors.mainThemeButton,
        ),
        const SizedBox(
          height: 20,
        ),
        _copyArea(context)
      ],
    );
  }

  Widget _copyArea(BuildContext context) {
    TextStyle styleBlack =
        TextStyle(fontSize: UIDefine.fontSize14, fontWeight: FontWeight.w600);
    TextStyle styleGrey = TextStyle(
        fontSize: UIDefine.fontSize14,
        fontWeight: FontWeight.w500,
        color: AppColors.dialogGrey);
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                tr("inviteCode"),
                style: styleBlack,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    GlobalData.userInfo.inviteCode,
                    textAlign: TextAlign.start,
                    style: styleGrey,
                  ),
                  IconButton(
                      onPressed: () {
                        viewModel.copyText(copyText: GlobalData.userInfo.inviteCode);
                      },
                      icon: Image.asset(AppImagePath.copyIcon))
                ],
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                tr("referralLink"),
                style: styleBlack,
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                height: UIDefine.getHeight() / 15,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text(
                        link,
                        textAlign: TextAlign.start,
                        style: styleGrey,
                      ),
                    ),
                    IconButton(
                        onPressed: () {
                          viewModel.copyText(copyText: link);
                        },
                        icon: Image.asset(AppImagePath.copyIcon))
                  ],
                ),
              ),
              SizedBox(
                height: UIDefine.getHeight()/20,
              ),
              ActionButtonWidget(btnText: tr("share"), onPressed: (){})
            ],
          ),
        )
      ],
    );
  }
}
