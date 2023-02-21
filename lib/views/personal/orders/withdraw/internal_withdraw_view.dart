import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:treasure_nft_project/constant/theme/app_style.dart';
import 'package:treasure_nft_project/models/http/parameter/user_info_data.dart';
import 'package:treasure_nft_project/utils/app_text_style.dart';
import 'package:treasure_nft_project/widgets/button/login_bolder_button_widget.dart';
import 'package:treasure_nft_project/widgets/gradient_third_text.dart';
import '../../../../constant/theme/app_colors.dart';
import '../../../../constant/ui_define.dart';
import '../../../../models/http/parameter/withdraw_alert_info.dart';
import '../../../../utils/qrcode_scanner_util.dart';
import '../../../../view_models/gobal_provider/user_experience_info_provider.dart';
import '../../../../view_models/gobal_provider/user_info_provider.dart';
import '../../../../view_models/personal/orders/order_internal_withdraw_view_model.dart';
import '../../../../widgets/button/login_button_widget.dart';
import '../../../../widgets/dialog/common_custom_dialog.dart';
import '../../../../widgets/label/error_text_widget.dart';
import '../../../../widgets/text_field/login_text_widget.dart';
import '../../../login/login_email_code_view.dart';
import '../../../login/login_param_view.dart';

class InternalWithdrawView extends ConsumerStatefulWidget {
  const InternalWithdrawView(
      {super.key, required this.getWalletAlert, required this.experienceMoney});

  final WithdrawAlertInfo Function() getWalletAlert;
  final num experienceMoney;

  @override
  ConsumerState createState() => _InternalWithdrawViewState();
}

class _InternalWithdrawViewState extends ConsumerState<InternalWithdrawView> {
  late OrderInternalWithdrawViewModel viewModel;

  @override
  initState() {
    super.initState();
    viewModel = OrderInternalWithdrawViewModel(setState: setState);
    viewModel.initState();
  }

  @override
  Widget build(BuildContext context) {
    viewModel.checkExperience =
        ref.watch(userExperienceInfoProvider).isExperience;
    UserInfoData userInfo = ref.watch(userInfoProvider);
    return SingleChildScrollView(
        child: Column(
      children: [
        _buildWithdrawTopView(),
        Container(
            width: double.infinity,
            height: UIDefine.getPixelWidth(15),
            color: AppColors.defaultBackgroundSpace),
        _buildWithdrawEmailView(userInfo),
        Container(
            width: double.infinity,
            height: UIDefine.getPixelWidth(2),
            color: AppColors.defaultBackgroundSpace),
        _buildWithdrawSubmit(),
        SizedBox(
          width: double.infinity,
          height: UIDefine.navigationBarPadding,
        ),
      ],
    ));
  }

  Widget _buildWithdrawTopView() {
    return Padding(
      padding: EdgeInsets.all(UIDefine.getScreenWidth(5)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildAddressInputBar(),
          SizedBox(height: UIDefine.getScreenWidth(5.5)),
          _buildAmountInputBar(),
          SizedBox(height: UIDefine.getScreenWidth(2.77)),
          _buildWithdrawInfo()
        ],
      ),
    );
  }

  _buildWithdrawEmailView(UserInfoData userInfo) {
    return Visibility(
      visible: !viewModel.checkExperience,
      child: Padding(
        padding: EdgeInsets.all(UIDefine.getScreenWidth(5)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // viewModel.checkExperience?  _buildPasswordInputBar() : _buildEmailVerify(), // test 體驗號功能未開
            viewModel.checkExperience
                ? const SizedBox()
                : _buildEmailVerify(userInfo),
          ],
        ),
      ),
    );
  }

  _buildWithdrawSubmit() {
    return Padding(
      padding: EdgeInsets.all(UIDefine.getPixelWidth(15)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          LoginBolderButtonWidget(
              fontSize: UIDefine.fontSize16,
              isFillWidth: false,
              radius: 17,
              padding:
                  EdgeInsets.symmetric(horizontal: UIDefine.getPixelWidth(20)),
              btnText: tr('cancel'),
              onPressed: () {
                viewModel.popPage(context);
              }),
          LoginButtonWidget(
            fontSize: UIDefine.fontSize16,
            isFillWidth: false,
            radius: 17,
            padding:
                EdgeInsets.symmetric(horizontal: UIDefine.getPixelWidth(20)),
            isGradient: true,
            btnText: tr('submit'),
            onPressed: () {
              viewModel.onPressSave(context, widget.getWalletAlert());
            },
            // enable: viewModel.checkEnable(),
          ),
        ],
      ),
    );
  }

  Widget _buildWithdrawInfo() {
    return Container(
      decoration: AppStyle().styleColorsRadiusBackground(
          color: AppColors.itemBackground, radius: 4),
      padding: EdgeInsets.all(UIDefine.getPixelWidth(10)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildTextContent(
              tr('canWithdrawFee'),
              viewModel.numberFormat(viewModel.data.balance)),
              // viewModel.numberFormat(viewModel.data.balance.isNotEmpty
              //     ? (num.parse(viewModel.data.balance) - widget.experienceMoney)
              //         .toString()
              //     : '')),
          SizedBox(height: UIDefine.getScreenWidth(2.77)),
          _buildTextContent(tr('minAmount'),
              '${viewModel.numberFormat(viewModel.data.minAmount)} USDT'),
          SizedBox(height: UIDefine.getScreenWidth(2.27)),
        ],
      ),
    );
  }

  Widget _buildAddressInputBar() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              tr('getAccount'),
              style: AppTextStyle.getBaseStyle(fontSize: UIDefine.fontSize14),
            ),
          ],
        ),
        SizedBox(
          width: UIDefine.getScreenWidth(90),
          child: Stack(
            children: [
              LoginTextWidget(
                hintText: tr("placeholder-account'"),
                controller: viewModel.accountController,
                contentPaddingRight: UIDefine.getScreenWidth(20),
                initColor: viewModel.accountData.result
                    ? AppColors.bolderGrey
                    : AppColors.textRed,
                enabledColor: viewModel.accountData.result
                    ? AppColors.bolderGrey
                    : AppColors.textRed,
                bFocusedGradientBolder: true,
                onTap: viewModel.onTap,
              ),
              // 內部轉帳不用掃碼
              // Positioned(
              //     right: UIDefine.getScreenWidth(5.5),
              //     top: UIDefine.getScreenWidth(6.38),
              //     child: GestureDetector(
              //         onTap: () => _onScanQRCode(),
              //         child:
              //             Image.asset('assets/icon/icon/icon_scanning_01.png'))
              // )
            ],
          ),
        ),
        ErrorTextWidget(
            data: viewModel.accountData, alignment: Alignment.centerRight)
      ],
    );
  }

  Widget _buildAmountInputBar() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          tr('quantity'),
          style: AppTextStyle.getBaseStyle(
              fontSize: UIDefine.fontSize14, fontWeight: FontWeight.w500),
        ),
        SizedBox(
          width: UIDefine.getScreenWidth(90),
          child: Stack(
            children: [
              LoginTextWidget(
                keyboardType: TextInputType.number,
                hintText: '0.00',
                controller: viewModel.amountController,
                contentPaddingRight: UIDefine.getScreenWidth(60),
                initColor: viewModel.amountData.result
                    ? AppColors.bolderGrey
                    : AppColors.textRed,
                enabledColor: viewModel.amountData.result
                    ? AppColors.bolderGrey
                    : AppColors.textRed,
                bFocusedGradientBolder: true,
                bLimitDecimalLength: true,
                onTap: viewModel.onTap,
              ),
              Positioned(
                  right: UIDefine.getScreenWidth(5.5),
                  top: UIDefine.getScreenWidth(6.38),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'USDT',
                        style: AppTextStyle.getBaseStyle(
                            fontSize: UIDefine.fontSize14,
                            fontWeight: FontWeight.w400),
                      ),
                      SizedBox(width: UIDefine.getScreenWidth(2.77)),
                      Container(
                          width: 1,
                          height: UIDefine.getScreenWidth(6.66),
                          color: AppColors.dialogGrey),
                      SizedBox(width: UIDefine.getScreenWidth(2.77)),
                      GestureDetector(
                        onTap: () => viewModel.amountController.text =
                            viewModel.numberFormat(viewModel.data.balance),
                        child: GradientThirdText(
                            '${tr('all')} ${tr('walletWithdraw')}',
                            size: UIDefine.fontSize14),
                      )
                    ],
                  ))
            ],
          ),
        ),
        ErrorTextWidget(
            data: viewModel.amountData, alignment: Alignment.centerRight)
      ],
    );
  }

  Future<PermissionStatus> _getCameraPermission() async {
    var status = await Permission.camera.status;
    if (!status.isGranted) {
      final result = await Permission.camera.request();
      return result;
    } else {
      return status;
    }
  }

  void _onScanQRCode() async {
    PermissionStatus status = await _getCameraPermission();
    if (status == PermissionStatus.permanentlyDenied) {
      _showDialog();
    }

    if (status.isGranted) {
      // 檢查權限
      if (mounted) {
        viewModel.pushPage(context, QRCodeScannerUtil(callBack: (String value) {
          viewModel.accountController.text = value;
        }));
      }
    }
  }

  void _showDialog() {
    CommonCustomDialog(context,
        bOneButton: false,
        type: DialogImageType.warning,
        title: tr("G_0403"),
        content: tr('goPermissionSetting'),
        leftBtnText: tr('cancel'),
        rightBtnText: tr('confirm'), onLeftPress: () {
      Navigator.pop(context);
    }, onRightPress: () {
      openAppSettings();
      Navigator.pop(context);
    }).show();
  }

  Widget _buildTextContent(String title, String content) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: AppTextStyle.getBaseStyle(
              fontSize: UIDefine.fontSize12, color: AppColors.textSixBlack),
        ),
        Text(
          content,
          style: AppTextStyle.getBaseStyle(
              fontSize: UIDefine.fontSize12,
              fontWeight: FontWeight.w400,
              color: AppColors.textThreeBlack),
        ),
      ],
    );
  }

  Widget _buildPasswordInputBar() {
    // test 體驗號功能未開
    return LoginParamView(
        titleText: tr('password'),
        hintText: tr("placeholder-password"),
        controller: viewModel.passwordController,
        data: viewModel.passwordData,
        onTap: viewModel.onTap);
  }

  Widget _buildEmailVerify(UserInfoData userInfo) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(tr('emailValid'),
            style: AppTextStyle.getBaseStyle(fontSize: UIDefine.fontSize14)),
        LoginEmailCodeView(
            needVerifyButton: false,
            countdownSecond: 60,
            btnGetText: tr('get'),
            btnVerifyText: tr('verify'),
            hintText: tr("placeholder-emailCode'"),
            controller: viewModel.emailCodeController,
            data: viewModel.emailCodeData,
            onPressSendCode: () => viewModel.onPressSendCode(context, userInfo),
            onPressCheckVerify: () =>
                viewModel.onPressCheckVerify(context, userInfo)),
      ],
    );
  }
}
