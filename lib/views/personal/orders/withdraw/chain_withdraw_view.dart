import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:treasure_nft_project/constant/theme/app_colors.dart';
import 'package:treasure_nft_project/constant/theme/app_style.dart';
import 'package:treasure_nft_project/utils/app_text_style.dart';
import 'package:treasure_nft_project/utils/number_format_util.dart';
import 'package:treasure_nft_project/widgets/dropdownButton/chain_dropdown_button.dart';
import 'package:treasure_nft_project/widgets/button/login_bolder_button_widget.dart';
import 'package:treasure_nft_project/widgets/dialog/common_custom_dialog.dart';
import 'package:treasure_nft_project/widgets/dialog/simple_custom_dialog.dart';
import 'package:treasure_nft_project/widgets/gradient_third_text.dart';

import '../../../../constant/ui_define.dart';
import '../../../../models/http/parameter/withdraw_alert_info.dart';
import '../../../../utils/qrcode_scanner_util.dart';
import '../../../../view_models/personal/orders/order_chain_withdraw_view_model.dart';
import '../../../../widgets/button/login_button_widget.dart';
import '../../../../widgets/label/error_text_widget.dart';
import '../../../../widgets/text_field/login_text_widget.dart';
import '../../../login/login_email_code_view.dart';
import '../../../login/login_param_view.dart';

class ChainWithdrawView extends StatefulWidget {
  const ChainWithdrawView({super.key, required this.getWalletAlert});

  final WithdrawAlertInfo Function() getWalletAlert;

  @override
  State<StatefulWidget> createState() => _ChainWithdrawView();
}

class _ChainWithdrawView extends State<ChainWithdrawView> {
  late OrderChainWithdrawViewModel viewModel;

  @override
  initState() {
    super.initState();
    viewModel = OrderChainWithdrawViewModel(setState: setState);
    viewModel.requestAPI();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
      children: [
        _buildWithdrawTopView(),
        Container(
            width: double.infinity,
            height: UIDefine.getPixelWidth(15),
            color: AppColors.defaultBackgroundSpace),
        _buildWithdrawEmailView(),
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
          _buildChainDropDownBar(),
          SizedBox(height: UIDefine.getScreenWidth(5.5)),
          _buildAddressInputBar(),
          SizedBox(height: UIDefine.getScreenWidth(5.5)),
          _buildAmountInputBar(),
          SizedBox(height: UIDefine.getScreenWidth(2.77)),
          _buildWithdrawInfo(),
          SizedBox(height: UIDefine.getScreenWidth(2.77)),
        ],
      ),
    );
  }

  _buildWithdrawEmailView() {
    return Visibility(
      visible: !viewModel.checkExperience,
      child: Padding(
        padding: EdgeInsets.all(UIDefine.getScreenWidth(5)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // viewModel.checkExperience?  _buildPasswordInputBar() : _buildEmailVerify(), // test 體驗號功能未開
            viewModel.checkExperience ? const SizedBox() : _buildEmailVerify(),
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
              enable: viewModel.checkEnable()),
        ],
      ),
    );
  }

  Widget _buildChainDropDownBar() {
    return ChainDropDownButton(
        onChainChange: (chain) {
          setState(() {
            viewModel.currentChain = chain;
            viewModel.requestAPI();
          });
        },
        currentChain: viewModel.currentChain);
  }

  Widget _buildAddressInputBar() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              tr('getAddress'),
              style: AppTextStyle.getBaseStyle(fontSize: UIDefine.fontSize14),
            ),
            GestureDetector(
              onTap: _onQuickFill,
              child:
                  GradientThirdText(tr('quickFill'), size: UIDefine.fontSize12),
            )
          ],
        ),
        SizedBox(
          width: UIDefine.getScreenWidth(90),
          child: Stack(
            children: [
              LoginTextWidget(
                hintText: tr("placeholder-address'"),
                controller: viewModel.addressController,
                contentPaddingRight: UIDefine.getScreenWidth(20),
                initColor: viewModel.addressData.result
                    ? AppColors.bolderGrey
                    : AppColors.textRed,
                enabledColor: viewModel.addressData.result
                    ? AppColors.bolderGrey
                    : AppColors.textRed,
                bFocusedGradientBolder: true,
                onTap: viewModel.onTap,
              ),
              Positioned(
                  right: UIDefine.getScreenWidth(5.5),
                  top: UIDefine.getScreenWidth(6.38),
                  child: GestureDetector(
                      onTap: () => _onScanQRCode(),
                      child:
                          Image.asset('assets/icon/icon/icon_scanning_01.png')))
            ],
          ),
        ),
        ErrorTextWidget(
            data: viewModel.addressData, alignment: Alignment.centerRight)
      ],
    );
  }

  Future<PermissionStatus> _getCameraPermission() async {
    PermissionStatus status = await Permission.camera.status;
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
          viewModel.addressController.text = value;
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

  void _onQuickFill() {
    String address = viewModel.data.address;
    if (address.isNotEmpty) {
      viewModel.addressController.text = viewModel.data.address;
    } else {
      SimpleCustomDialog(context, isSuccess: false, mainText: '尚未設定帳號').show();
    }
  }

  Widget _buildAmountInputBar() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          tr('quantity'),
          style: AppTextStyle.getBaseStyle(fontSize: UIDefine.fontSize14),
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
                onChanged: viewModel.onAmountChange,
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

  Widget _buildEmailVerify() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(tr('emailValid'),
            style: AppTextStyle.getBaseStyle(fontSize: UIDefine.fontSize14)),
        LoginEmailCodeView(
            countdownSecond: 60,
            btnGetText: tr('get'),
            btnVerifyText: tr('verify'),
            hintText: tr("placeholder-emailCode'"),
            controller: viewModel.emailCodeController,
            data: viewModel.emailCodeData,
            onPressSendCode: () => viewModel.onPressSendCode(context),
            onPressCheckVerify: () => viewModel.onPressCheckVerify(context)),
      ],
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
          _buildTextContent(tr('canWithdrawFee'),
              viewModel.numberFormat(viewModel.data.balance)),
          SizedBox(height: UIDefine.getScreenWidth(2.77)),
          _buildTextContent(tr('minAmount'),
              '${viewModel.numberFormat(viewModel.data.minAmount)} USDT'),
          SizedBox(height: UIDefine.getScreenWidth(2.77)),
          _buildTextContent(tr('withdrawFee'),
              '${NumberFormatUtil().removeTwoPointFormat(viewModel.currentAmount)} USDT'),
        ],
      ),
    );
  }
}
