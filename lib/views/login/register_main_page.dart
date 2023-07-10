import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';
import 'package:treasure_nft_project/models/http/api/user_info_api.dart';
import 'package:treasure_nft_project/view_models/login/register_country_provider.dart';
import 'package:treasure_nft_project/views/login/login_common_view.dart';
import 'package:treasure_nft_project/widgets/app_bottom_navigation_bar.dart';
import 'package:treasure_nft_project/widgets/button/wallet_connect_button_widget.dart';
import 'package:treasure_nft_project/widgets/drop_buttom/custom_drop_button.dart';
import 'package:wallet_connect_plugin/provider/begin_provider.dart';

import '../../models/http/parameter/country_phone_data.dart';
import '../../utils/app_text_style.dart';
import '../../view_models/login/register_main_viewmodel.dart';
import '../../view_models/login/wallet_bind_view_model.dart';
import '../../widgets/button/login_button_widget.dart';
import '../../widgets/label/common_text_widget.dart';
import '../../widgets/label/error_text_widget.dart';
import '../custom_appbar_view.dart';
import 'login_email_code_view.dart';
import 'login_param_view.dart';

class RegisterMainPage extends ConsumerStatefulWidget {
  const RegisterMainPage({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _RegisterMainPageState();
}

class _RegisterMainPageState extends ConsumerState<RegisterMainPage> {
  late RegisterMainViewModel viewModel;

  List<CountryPhoneData> get countryList => ref.read(registerCountryProvider) ;

  int? get currentCountryIndex => ref.read(registerCurrentIndexProvider);
  String ipCountry = "";

  bool clearButton = true;

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(milliseconds: 300)).then((value) =>
        ref.read(connectWalletProvider.notifier).initConnectWallet());
    ref
        .read(registerCountryProvider.notifier)
        .init(onFinish: () => _updateCountryIndex());
    UserInfoAPI().getIpCountry().then((value) {
      ipCountry = value;
      _updateCountryIndex();
    });
    viewModel = RegisterMainViewModel(setState: setState);
  }

  @override
  void dispose() {
    super.dispose();
    viewModel.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(registerCountryProvider);
    ref.watch(registerCurrentIndexProvider);
    return CustomAppbarView(
      needScrollView: false,
      onLanguageChange: () {
        if (mounted) {
          setState(() {});
        }
      },
      type: AppNavigationBarType.typeLogin,
      body: SingleChildScrollView(
          child: LoginCommonView(
        pageHeight: UIDefine.getPixelWidth(1050),
        title: tr('register'),
        body: Container(
            margin: EdgeInsets.symmetric(
                vertical: UIDefine.getPixelHeight(10),
                horizontal: UIDefine.getPixelWidth(20)),
            padding: EdgeInsets.only(bottom: UIDefine.navigationBarPadding),
            child: _buildBody()),
      )),
    );
  }

  Widget _buildBody() {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          WalletConnectButtonWidget(
              needChangeText: false,
              btnText: tr('register-via-wallet'),
              bindWalletTitle: tr('register-via-wallet'),
              getWalletInfo: (walletInfo) {
                WalletBindViewModel().registerWithWallet(context, ref,
                    walletInfo: walletInfo,
                    inviteCode: viewModel.referralController.text);
              }),

          // ///MARK:暱稱
          // LoginParamView(
          //     titleText: tr('nickname'),
          //     hintText: tr("placeholder-nickname'"),
          //     controller: viewModel.nicknameController,
          //     data: viewModel.nicknameData,
          //     onChanged: viewModel.onNicknameChange),

          ///MARK: 帳號
          LoginParamView(
            bShowRed:true,
            titleText: tr('account'),
            hintText: tr("placeholder-account'"),
            controller: viewModel.accountController,
            data: viewModel.accountData,
            onChanged: viewModel.onAccountChanged,
            inputFormatters: denySpace(),
          ),

          ///MARK:密碼
          LoginParamView(
              bShowRed:true,
            // bPasswordFormatter: true,
              titleText: tr('password'),
              hintText: tr("placeholder-password"),
              controller: viewModel.passwordController,
              isSecure: true,
              data: viewModel.passwordData,
              onChanged: viewModel.onPasswordChanged,
              inputFormatters: denySpace(),
          ),

          ///MARK:再次確認密碼
          LoginParamView(
              // bPasswordFormatter: true,
              titleText: tr("placeholder-password-again'"),
              hintText: tr("placeholder-password-again'"),
              controller: viewModel.rePasswordController,
              isSecure: true,
              data: viewModel.rePasswordData,
              onChanged: viewModel.onPasswordChanged,
              inputFormatters: denySpace(),
          ),

          ///MARK: 選擇國籍
          ..._buildRegisterCountry(),

          ///MARK:Email
          LoginParamView(
            bShowRed:true,
            titleText: tr('email'),
            hintText: tr("placeholder-email'"),
            controller: viewModel.emailController,
            data: viewModel.emailData,
            onChanged: viewModel.onEmailChange,
            inputFormatters: denySpace(),
          ),

          ///MARK:驗證碼
          LoginEmailCodeView(
            needVerifyButton: false,
            hintText: tr("placeholder-emailCode'"),
            btnVerifyText: tr('verify'),
            btnGetText: tr('get'),
            controller: viewModel.emailCodeController,
            onPressSendCode: () => viewModel.onPressSendCode(context),
            onPressCheckVerify: () => viewModel.onPressCheckVerify(context),
            data: viewModel.emailCodeData,
            // onPressVerification: viewModel.checkEmailFormat,
          ),

          ///MARK:邀請瑪
          LoginParamView(
              titleText: '${tr('referralCode')} (${tr('optional')})',
              hintText: tr("placeholder-referralCode'"),
              controller: viewModel.referralController,
              data: viewModel.referralData,
              inputFormatters: denySpace(),
          ),

          ///MARK: 註冊按鈕
          LoginButtonWidget(
            btnText: tr('register'),
            // enable: viewModel.checkPress(),
            onPressed: () => viewModel.onPressRegister(context, ref, currentCountryIndex),
          ),
          Row(children: [
            Flexible(
                flex: 3,
                child: CommonTextWidget(
                  text: tr('withoutAccount'),
                  alignment: Alignment.centerRight,
                )),
            const SizedBox(width: 20),
            Flexible(
                flex: 2,
                child: CommonTextWidget(
                    text: tr('Login'),
                    fillWidth: false,
                    onPress: () => viewModel.onPressLogin(context)))
          ])
        ]);
  }

  List<Widget> _buildRegisterCountry() {
    return [
      Container(
          margin: const EdgeInsets.symmetric(vertical: 5),
          child: Text(tr("phone"),
              style: AppTextStyle.getBaseStyle(
                  fontWeight: FontWeight.w500, fontSize: UIDefine.fontSize14))),

      SizedBox(
      height: UIDefine.getPixelHeight(100),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

    Container(
      height: UIDefine.getPixelHeight(80),
      width: UIDefine.getWidth()/2.6,
          padding: EdgeInsets.symmetric(vertical: UIDefine.getPixelWidth(12)),
          child: CustomDropButton(
              needArrow: !clearButton,
              showClearButton: clearButton,
              onPressClear: (){
                clearButton = false;
                ref.read(registerCurrentIndexProvider.notifier).update((state) => 0);
                debugPrint("onPressClear");
                setState(() {});
              },
              height: UIDefine.getPixelHeight(42),
              initIndex: currentCountryIndex,
              needShowEmpty: false,
              hintSelect: tr("placeholder-register-country"),
              listLength: countryList.length,
              itemString: (int index, bool needArrow)=>
                      "${tr(countryList[index].country)} (+${countryList[index]
                        .areaCode})",
              onChanged: (index) {
                if (index > 1) {
                  clearButton = true;
                }else {
                  clearButton = false;
                }

                viewModel.currentCountry = countryList[index].country;
                ref
                    .read(registerCurrentIndexProvider.notifier)
                    .update((state) => index);

                  viewModel.onPhoneCheck(index);
              }),
        ),

        SizedBox(
          width: UIDefine.getWidth()/2,
        ///MARK:Phone
        child:LoginParamView(
          showTitleText: false,
          titleText: "",
          hintText: tr("placeholder-phone'"),
          controller: viewModel.phoneController,
          data: viewModel.phoneData,
          onChanged: viewModel.onPhoneChange,
          inputFormatters: denySpace(),
        )),

      ])),

      ErrorTextWidget(
          data: viewModel.countryData, alignment: Alignment.centerRight),
    ];
  }

  void _updateCountryIndex() {
    if (ipCountry.isNotEmpty) {
      for (int index = 0; index < countryList.length; index++) {
        if (ipCountry.compareTo(countryList[index].country) == 0) {
          ref
              .read(registerCurrentIndexProvider.notifier)
              .update((state) => index);
          viewModel.currentCountry = countryList[index].country;
          break;
        }
      }
    }
  }

  ///MARK: 限制空格輸入
  List<TextInputFormatter> denySpace() {
    return [FilteringTextInputFormatter.deny(RegExp(r'\s'))];
  }
}
