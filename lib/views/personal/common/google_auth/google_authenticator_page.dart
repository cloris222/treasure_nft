
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:treasure_nft_project/view_models/personal/common/google_auth/google_auth_view_model.dart';
import '../../../../constant/theme/app_colors.dart';
import '../../../../constant/theme/app_image_path.dart';
import '../../../../constant/theme/app_style.dart';
import '../../../../constant/ui_define.dart';
import '../../../../models/http/parameter/google_auth_data.dart';
import '../../../../view_models/base_view_model.dart';
import '../../../../view_models/gobal_provider/global_tag_controller_provider.dart';
import '../../../../view_models/personal/common/google_auth/google_auth_provider.dart';
import '../../../../widgets/app_bottom_navigation_bar.dart';
import '../../../../widgets/appbar/title_app_bar.dart';
import '../../../../widgets/button/login_button_widget.dart';
import '../../../../widgets/label/gradient_bolder_widget.dart';
import '../../../custom_appbar_view.dart';
import '../../../login/login_param_view.dart';

///MARK: google驗證
class GoogleSettingPage extends ConsumerStatefulWidget {
  const GoogleSettingPage({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _GoogleSettingPageState();
}

class _GoogleSettingPageState extends ConsumerState<GoogleSettingPage> {
  late GoogleAuthViewModel viewModel;
  GoogleAuthData get data => ref.watch(userGoogleAuthProvider);

  @override
  void initState() {
    ref.read(userGoogleAuthProvider.notifier).update();
    viewModel = GoogleAuthViewModel(ref, setState: setState);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomAppbarView(
        needCover: true,
        needScrollView: true,
        type: AppNavigationBarType.typePersonal,
        body: Column(children: [
          Container(padding:
          EdgeInsets.symmetric(horizontal: UIDefine.getPixelWidth(20)),
              child: TitleAppBar(
                  title: tr('googleAuthenticator'), needCloseIcon: false)),

          SizedBox(height: UIDefine.getPixelWidth(20)),

          _buildQRCode(),
          SizedBox(height: UIDefine.getPixelWidth(20)),
          _buildTeaching(),
          SizedBox(height: UIDefine.getPixelWidth(30)),
          _buildKey(),
          SizedBox(height: UIDefine.getPixelWidth(30)),
          _buildGoogleVerify(),
          SizedBox(height: UIDefine.getPixelWidth(40)),
          _buildButton(),
          SizedBox(height: UIDefine.getPixelWidth(100)),
        ]),
        onLanguageChange: () {
          if (mounted) {
            setState(() {});
          }});
  }

  Widget _buildQRCode() {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: UIDefine.getPixelWidth(16)),
        child:QrImage(
          errorStateBuilder: (context, error) => Text(error.toString()),
          data: data.qrCode??"",
          version: QrVersions.auto,
          size: UIDefine.getPixelHeight(220),
          foregroundColor: AppColors.reservationLevel3,
          backgroundColor: AppColors.textWhite,
        ));
  }

  Widget _buildTeaching() {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: UIDefine.getPixelWidth(16)),
        child:Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(tr("googleVerify-text1"),style: const TextStyle(color: AppColors.textGrey)),
              SizedBox(height: UIDefine.getPixelWidth(6)),
              Text(tr("googleVerify-text2"),style: const TextStyle(color: AppColors.textGrey)),
              SizedBox(height: UIDefine.getPixelWidth(6)),
              Text(tr("googleVerify-text3"),style: const TextStyle(color: AppColors.textGrey)),
            ]));
  }

  Widget _buildKey() {
    return Container(
        color: AppColors.itemBackground,
        child:Container(
            decoration: AppStyle().styleColorsRadiusBackground(radius: 12),
            margin: EdgeInsets.symmetric(
                vertical: UIDefine.getPixelWidth(12),
                horizontal: UIDefine.getPixelWidth(16)),
            padding: EdgeInsets.all(UIDefine.getPixelWidth(6)),
            child:Row(children: [
              Container(
                width: UIDefine.getWidth()/1.5,
                margin: EdgeInsets.symmetric(
                    horizontal: UIDefine.getPixelWidth(16),
                    vertical: UIDefine.getScreenWidth(2.7)),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(tr("key"),style: const TextStyle(color: AppColors.textBlack)),
                      SizedBox(height: UIDefine.getPixelWidth(16)),
                      Text(data.secretKey,style: const TextStyle(color: AppColors.textGrey)),
                    ]),
              ),

              InkWell(
                  onTap: () {
                    BaseViewModel().copyText(copyText: data.secretKey ?? "");
                    BaseViewModel().showToast(context, tr('copiedSuccess'));
                  },
                  child: Image.asset(AppImagePath.copyIcon)),
            ])
        ));
  }

  Widget _buildGoogleVerify() {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: UIDefine.getPixelWidth(16)),
        child:LoginParamView(
          titleText: tr('googleVerify'),
          hintText: tr("enterGoogleVerification"),
          controller: viewModel.verifyController,
          data: ref.watch(globalValidateDataProvider("")),
          keyboardType:TextInputType.number,
          inputFormatters: denySpace(),
        ));
  }

  Widget _buildButton() {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: UIDefine.getPixelWidth(16)),
        child:Row(children: [
          Expanded(child: Container()),

          LoginButtonWidget(
            // Save按鈕
              isShowProgress: viewModel.isProcess,
              needTimes: 2,
              isGradient: true,
              isFillWidth: false,
              radius:45,
              width:UIDefine.getPixelWidth(110),
              btnText: tr('save'),
              onPressed: () => viewModel.onPressSave(context))
        ]),
      );
  }

  List<TextInputFormatter> denySpace() {
    return [FilteringTextInputFormatter.deny(RegExp(r'\s'))];
  }

}