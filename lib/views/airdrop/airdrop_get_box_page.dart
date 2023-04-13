import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:treasure_nft_project/constant/global_data.dart';
import 'package:treasure_nft_project/constant/theme/app_colors.dart';
import 'package:treasure_nft_project/constant/theme/app_style.dart';
import 'package:treasure_nft_project/utils/app_text_style.dart';
import 'package:treasure_nft_project/widgets/button/login_button_widget.dart';

import '../../constant/app_routes.dart';
import '../../constant/theme/app_image_path.dart';
import '../../constant/ui_define.dart';
import '../../view_models/base_view_model.dart';

/// 取得寶箱的通知
class AirdropGetBoxPage extends StatelessWidget {
  const AirdropGetBoxPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.opacityBackground,
        body: GestureDetector(
            onTap: () => BaseViewModel().popPage(context),
            child: Container(
                constraints: const BoxConstraints.expand(),
                color: Colors.transparent,
                child: GestureDetector(
                  onTap: () {},
                  child: Center(
                    child: Stack(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: UIDefine.getPixelWidth(20)),
                          child: _buildBackground(child: _buildBody(context)),
                        ),
                        Positioned(
                            top: 0,
                            right: 0,
                            child: Image.asset(AppImagePath.airdropBoxIcon)),
                      ],
                    ),
                  ),
                ))));
  }

  Widget _buildBackground({required Widget child}) {
    return Container(
      width: UIDefine.getWidth(),
      margin: EdgeInsets.symmetric(horizontal: UIDefine.getPixelWidth(20)),
      padding: EdgeInsets.all(UIDefine.getPixelWidth(10)),
      decoration: AppStyle().styleColorsRadiusBackground(
          color: Colors.white.withOpacity(0.3), radius: 15),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Container(
          decoration: const BoxDecoration(
              color: Colors.white,
              image: DecorationImage(
                  image: AssetImage(AppImagePath.shareBackground),
                  fit: BoxFit.cover)),
          padding: EdgeInsets.all(UIDefine.getPixelWidth(20)),
          child: child,
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset(AppImagePath.mainAppBarLogo),
        Container(
          margin: EdgeInsets.symmetric(vertical: UIDefine.getPixelWidth(10)),
            padding: EdgeInsets.only(right: UIDefine.getPixelWidth(100)),
            child: Text(
              tr("airdropInProgress"),
              style: AppTextStyle.getBaseStyle(
                  fontWeight: FontWeight.w800, fontSize: UIDefine.fontSize28),
            )),
        _buildContext(),
        LoginButtonWidget(
            btnText: tr("go"), onPressed: () => onPressGo(context))
      ],
    );
  }

  Widget _buildContext() {
    return Container(
        margin: EdgeInsets.symmetric(vertical: UIDefine.getPixelWidth(10)),
        padding: EdgeInsets.symmetric(
            vertical: UIDefine.getPixelWidth(15),
            horizontal: UIDefine.getPixelWidth(20)),
        constraints: BoxConstraints(maxHeight: UIDefine.getPixelWidth(120)),
        decoration: AppStyle().baseBolderGradient(
            radius: 15, backgroundColor: const Color(0xFFF4F4F4)),
        width: UIDefine.getWidth(),
        child: Text(
          tr("airdropModalText"),
          style: AppTextStyle.getBaseStyle(
              fontWeight: FontWeight.w400, fontSize: UIDefine.fontSize14),
        ));
  }

  void onPressGo(BuildContext context) {
    BaseViewModel().popPage(context);
    if (!GlobalData.isAirDrop) {
      AppRoutes.pushAirdrop(context);
    }
  }
}
