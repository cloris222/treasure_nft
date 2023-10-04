import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';
import 'package:treasure_nft_project/view_models/base_view_model.dart';
import 'package:treasure_nft_project/widgets/button/login_button_widget.dart';
import '../../constant/theme/app_animation_path.dart';
import '../../constant/theme/app_colors.dart';
import '../../constant/theme/app_style.dart';
import '../../utils/animation_download_util.dart';
import '../../utils/app_text_style.dart';


class ReserveLoadingPage extends StatelessWidget{
  const ReserveLoadingPage({super.key,
    this.mainMargin = const EdgeInsets.all(10),
    this.buttonMargin = const EdgeInsets.only(top: 10),
  });

  final EdgeInsetsGeometry mainMargin, buttonMargin;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: AppColors.opacityBackground.withOpacity(0.1),
        body: GestureDetector(
            onTap: () => BaseViewModel().popPage(context),
            child: Center(
                child:Container(
                    margin: EdgeInsets.symmetric(horizontal: UIDefine.getPixelWidth(28)),
                    padding: EdgeInsets.symmetric(horizontal: UIDefine.getPixelWidth(16)),
                    height: UIDefine.getPixelHeight(320),
                    alignment: Alignment.center,
                    decoration: AppStyle().baseBolderGradient(radius: 15, backgroundColor: Colors.white),
                    child:Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.symmetric(vertical: UIDefine.getPixelHeight(24)),
                            height: UIDefine.getPixelHeight(50),
                            child: buildLoadingAnimation(),
                          ),
                          Container(
                            width: UIDefine.getPixelWidth(224),
                            height: UIDefine.getPixelWidth(62),
                            decoration: BoxDecoration(
                              border:Border.all(color: AppColors.textBlack.withOpacity(0.2)),
                              borderRadius: BorderRadius.circular(22),
                              color: AppColors.dialogLightGrey
                            ),
                            child: Column(
                              children: [

                              ],
                            ),
                          ),
                          Container(
                              margin: mainMargin,
                              child: Text("${tr("notification-PENDING'")}...",
                                  textAlign: TextAlign.center,
                                  style: AppTextStyle.getBaseStyle(
                                      color: Colors.black,
                                      fontSize: UIDefine.fontSize24,
                                      fontWeight: FontWeight.w700
                                  ))),
                          Container(
                              margin: buttonMargin,
                              child: LoginButtonWidget(
                                btnText: tr('confirm'),
                                onPressed: _onPress,
                                isFillWidth: false,
                              ))
                        ]))
            )
        ));
  }

  void _onPress() {
    BaseViewModel().popPage(BaseViewModel().getGlobalContext());
  }

  Widget buildLoadingAnimation() {
    // return Lottie.file(File(AppAnimationPath.buyNFTLoading)??"");
    return Lottie.asset(AppAnimationPath.buyNFTLoading??"",fit: BoxFit.contain);
  }


}

