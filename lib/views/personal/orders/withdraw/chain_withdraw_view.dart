
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:treasure_nft_project/constant/theme/app_colors.dart';
import 'package:treasure_nft_project/widgets/dialog/simple_custom_dialog.dart';

import '../../../../constant/enum/coin_enum.dart';
import '../../../../constant/theme/app_theme.dart';
import '../../../../constant/ui_define.dart';
import '../../../../utils/qrcode_scanner_util.dart';
import '../../../../view_models/personal/orders/order_chain_withdraw_view_model.dart';
import '../../../../widgets/button/login_button_widget.dart';
import '../../../../widgets/label/coin/tether_coin_widget.dart';
import '../../../../widgets/label/error_text_widget.dart';
import '../../../../widgets/text_field/login_text_widget.dart';
import '../../../login/login_email_code_view.dart';
import '../../../login/login_param_view.dart';

class ChainWithdrawView extends StatefulWidget {
  const ChainWithdrawView({super.key});

  @override
  State<StatefulWidget> createState() => _ChainWithdrawView();
}

class _ChainWithdrawView extends State<ChainWithdrawView> {

  late OrderChainWithdrawViewModel viewModel;

  @override
  initState() {
    super.initState();
    viewModel = OrderChainWithdrawViewModel(setState: setState);
    viewModel.initState();
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

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: UIDefine.getScreenWidth(5), right: UIDefine.getScreenWidth(5)),
      child: SingleChildScrollView(
        child: Column(
          children: [
            _buildChainDropDownBar(),
            SizedBox(height: UIDefine.getScreenWidth(5.5)),
            _buildAddressInputBar(),
            SizedBox(height: UIDefine.getScreenWidth(5.5)),
            _buildAmountInputBar(),
            SizedBox(height: UIDefine.getScreenWidth(2.77)),
            _buildTextContent(tr('canWithdrawFee'), viewModel.data.balance),
            SizedBox(height: UIDefine.getScreenWidth(2.77)),
            _buildTextContent(tr('minAmount'), viewModel.data.minAmount + ' USDT'),
            SizedBox(height: UIDefine.getScreenWidth(2.77)),
            _buildTextContent(tr('withdrawFee'), viewModel.data.fee + ' USDT'),
            SizedBox(height: UIDefine.getScreenWidth(8.27)),

            Container(width: double.infinity, height: 1.5, color: AppColors.dialogGrey),

            SizedBox(height: UIDefine.getScreenWidth(8.27)),
            // viewModel.checkExperience?  _buildPasswordInputBar() : _buildEmailVerify(), // test 體驗號功能未開
            viewModel.checkExperience?  const SizedBox() : _buildEmailVerify(),

            SizedBox(height: UIDefine.getScreenWidth(16.54)),
            LoginButtonWidget( // Save按鈕
                isGradient: false,
                btnText: tr('submit'),
                onPressed: () => viewModel.onPressSave(context),
                enable: viewModel.checkEnable()),
            SizedBox(height: UIDefine.getScreenWidth(11.1))
          ],
        )
      ),
    );
  }

  Widget _buildChainDropDownBar() {
    return DropdownButtonFormField(
        icon: Image.asset('assets/icon/btn/btn_arrow_02_down.png'),
        onChanged: (newValue) {
          setState(() {
            viewModel.currentChain = newValue!;
          });
        },
        value: viewModel.currentChain,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(UIDefine.getScreenWidth(4.16),
              UIDefine.getScreenWidth(4.16), UIDefine.getScreenWidth(4.16), 0),
          hintStyle: const TextStyle(height: 1.6, color: AppColors.textBlack),
          border: AppTheme.style.styleTextEditBorderBackground(
              color: AppColors.bolderGrey, radius: 10),
          focusedBorder: AppTheme.style.styleTextEditBorderBackground(
              color: AppColors.bolderGrey, radius: 10),
          enabledBorder: AppTheme.style.styleTextEditBorderBackground(
              color: AppColors.bolderGrey, radius: 10),
        ),
        items: [
          DropdownMenuItem(
              value: CoinEnum.TRON,
              child: Row(children: [
                TetherCoinWidget(size: UIDefine.fontSize24),
                Text('  USDT-TRC20',
                    style: TextStyle(
                        color: viewModel.currentChain == CoinEnum.TRON
                            ? AppColors.deepBlue
                            : AppColors.searchBar))
              ])),
          DropdownMenuItem(
              value: CoinEnum.BSC,
              child: Row(children: [
                TetherCoinWidget(size: UIDefine.fontSize24),
                Text('  USDT-BSC',
                    style: TextStyle(
                        color: viewModel.currentChain == CoinEnum.BSC
                            ? AppColors.deepBlue
                            : AppColors.searchBar))
              ]))
        ]);
  }

  Widget _buildAddressInputBar() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              tr('getAddress'),
              style: TextStyle(fontSize: UIDefine.fontSize14, fontWeight: FontWeight.w600),
            ),
            GestureDetector(
              onTap: _onQuickFill,
              child: Text(
                tr('quickFill'),
                style: TextStyle(color: AppColors.mainThemeButton, fontSize: UIDefine.fontSize12, fontWeight: FontWeight.w600),
              )
            )
          ],
        ),

        SizedBox(
          width: UIDefine.getScreenWidth(90),
          child: Stack(
            children: [
              LoginTextWidget(
                hintText: '',
                controller: viewModel.addressController,
                contentPaddingRight: UIDefine.getScreenWidth(20),
                initColor: viewModel.addressData.result ? AppColors.bolderGrey : AppColors.textRed,
                enabledColor: viewModel.addressData.result ? AppColors.bolderGrey : AppColors.textRed,
                focusedColor: AppColors.mainThemeButton,
                onTap: viewModel.onTap,
              ),
              
              Positioned(
                right: UIDefine.getScreenWidth(5.5), top: UIDefine.getScreenWidth(6.38),
                  child: GestureDetector(
                    onTap: () => _onScanQRCode(),
                    child: Image.asset('assets/icon/icon/icon_scanning_01.png')
                  )
              )
            ],
          ),
        ),

        ErrorTextWidget(data: viewModel.addressData, alignment: Alignment.centerRight)
      ],
    );
  }

  void _onScanQRCode() async {
    PermissionStatus status = await _getCameraPermission();
    if (status.isGranted) { // 檢查權限
      if (mounted) {
        viewModel.pushPage(context, QRCodeScannerUtil(
            callBack: (String value) {
              viewModel.addressController.text = value;
            }));
      }
    }
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
          style: TextStyle(fontSize: UIDefine.fontSize14, fontWeight: FontWeight.w600),
        ),

        SizedBox(
          width: UIDefine.getScreenWidth(90),
          child: Stack(
            children: [
              LoginTextWidget(
                keyboardType: TextInputType.number,
                hintText: '0.0000',
                controller: viewModel.amountController,
                contentPaddingRight: UIDefine.getScreenWidth(60),
                initColor: viewModel.amountData.result ? AppColors.bolderGrey : AppColors.textRed,
                enabledColor: viewModel.amountData.result ? AppColors.bolderGrey : AppColors.textRed,
                focusedColor: AppColors.mainThemeButton,
                onTap: viewModel.onTap,
              ),

              Positioned(
                  right: UIDefine.getScreenWidth(5.5), top: UIDefine.getScreenWidth(6.38),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'USDT',
                        style: TextStyle(fontSize: UIDefine.fontSize14, fontWeight: FontWeight.w500),
                      ),
                      SizedBox(width: UIDefine.getScreenWidth(2.77)),
                      Container(width: 1, height: UIDefine.getScreenWidth(6.66), color: AppColors.dialogGrey),
                      SizedBox(width: UIDefine.getScreenWidth(2.77)),
                      GestureDetector(
                        onTap: () => viewModel.amountController.text = viewModel.data.balance,
                        child: Text(
                          tr('all'),
                          style: TextStyle(color: AppColors.mainThemeButton, fontSize: UIDefine.fontSize12, fontWeight: FontWeight.w600),
                        )
                      )
                    ],
                  )
              )
            ],
          ),
        ),

        ErrorTextWidget(data: viewModel.amountData, alignment: Alignment.centerRight)
      ],
    );
  }

  Widget _buildTextContent(String title, String content) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: UIDefine.fontSize14, fontWeight: FontWeight.w500,
          color: AppColors.dialogGrey),
        ),
        Text(
          content,
          style: TextStyle(fontSize: UIDefine.fontSize16, fontWeight: FontWeight.w500,
          color: AppColors.dialogBlack),
        ),
      ],
    );
  }

  Widget _buildPasswordInputBar() { // test 體驗號功能未開
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
            countdownSecond: 180,
            btnGetText: tr('send'),
            hintText: tr('mail_valid_code'),
            controller: viewModel.emailCodeController,
            data: viewModel.emailCodeData,
            onPressSendCode: () => viewModel.onPressSendCode(context),
            onPressCheckVerify: () => viewModel.onPressCheckVerify(context)),
      ],
    );
  }

}