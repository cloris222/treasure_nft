import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../../constant/theme/app_colors.dart';
import '../../../../constant/ui_define.dart';
import '../../../../models/http/parameter/withdraw_alert_info.dart';
import '../../../../utils/qrcode_scanner_util.dart';
import '../../../../view_models/personal/orders/order_internal_withdraw_view_model.dart';
import '../../../../widgets/button/login_button_widget.dart';
import '../../../../widgets/dialog/common_custom_dialog.dart';
import '../../../../widgets/label/error_text_widget.dart';
import '../../../../widgets/text_field/login_text_widget.dart';
import '../../../login/login_email_code_view.dart';
import '../../../login/login_param_view.dart';

class InternalWithdrawView extends StatefulWidget {
  const InternalWithdrawView({super.key, required this.getWalletAlert});

  final WithdrawAlertInfo Function() getWalletAlert;

  @override
  State<StatefulWidget> createState() => _InternalWithdrawView();
}

class _InternalWithdrawView extends State<InternalWithdrawView> {
  late OrderInternalWithdrawViewModel viewModel;

  @override
  initState() {
    super.initState();
    viewModel = OrderInternalWithdrawViewModel(setState: setState);
    viewModel.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          left: UIDefine.getScreenWidth(5), right: UIDefine.getScreenWidth(5)),
      child: SingleChildScrollView(
          child: Column(
        children: [
          _buildAddressInputBar(),
          SizedBox(height: UIDefine.getScreenWidth(5.5)),
          _buildAmountInputBar(),
          SizedBox(height: UIDefine.getScreenWidth(2.77)),
          _buildTextContent(tr('canWithdrawFee'), viewModel.numberFormat(viewModel.data.balance)),
          SizedBox(height: UIDefine.getScreenWidth(2.77)),
          _buildTextContent(
              tr('minAmount'), '${viewModel.numberFormat(viewModel.data.minAmount)} USDT'),
          SizedBox(height: UIDefine.getScreenWidth(8.27)),

          Container(
              width: double.infinity, height: 1.5, color: AppColors.dialogGrey),

          SizedBox(height: UIDefine.getScreenWidth(8.27)),
          // viewModel.checkExperience?  _buildPasswordInputBar() : _buildEmailVerify(), // test 體驗號功能未開
          viewModel.checkExperience ? const SizedBox() : _buildEmailVerify(),

          SizedBox(height: UIDefine.getScreenWidth(16.54)),
          LoginButtonWidget(
              // Save按鈕
              isGradient: false,
              btnText: tr('submit'),
              onPressed: () {
                if (viewModel.checkEmail) {
                  viewModel.onPressSave(context, widget.getWalletAlert());
                }
              },
              enable: viewModel.checkEnable()),
          SizedBox(height: UIDefine.getScreenWidth(11.1))
        ],
      )),
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
              style: TextStyle(
                  fontSize: UIDefine.fontSize14, fontWeight: FontWeight.w600),
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
                focusedColor: AppColors.mainThemeButton,
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
          style: TextStyle(
              fontSize: UIDefine.fontSize14, fontWeight: FontWeight.w600),
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
                focusedColor: AppColors.mainThemeButton,
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
                        style: TextStyle(
                            fontSize: UIDefine.fontSize14,
                            fontWeight: FontWeight.w500),
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
                          child: Text(
                            tr('all'),
                            style: TextStyle(
                                color: AppColors.mainThemeButton,
                                fontSize: UIDefine.fontSize12,
                                fontWeight: FontWeight.w600),
                          ))
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
          style: TextStyle(
              fontSize: UIDefine.fontSize14,
              fontWeight: FontWeight.w500,
              color: AppColors.dialogGrey),
        ),
        Text(
          content,
          style: TextStyle(
              fontSize: UIDefine.fontSize16,
              fontWeight: FontWeight.w500,
              color: AppColors.dialogBlack),
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
            style: TextStyle(
                fontSize: UIDefine.fontSize14, fontWeight: FontWeight.w500)),
        LoginEmailCodeView(
            countdownSecond: 60,
            btnGetText: tr('get'),
            hintText: tr("placeholder-emailCode'"),
            hintColor: AppColors.searchBar,
            controller: viewModel.emailCodeController,
            data: viewModel.emailCodeData,
            onPressSendCode: () => viewModel.onPressSendCode(context),
            onPressCheckVerify: () => viewModel.onPressCheckVerify(context)),
      ],
    );
  }
}
