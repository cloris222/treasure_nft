import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:treasure_nft_project/constant/theme/app_colors.dart';
import 'package:treasure_nft_project/constant/theme/app_style.dart';
import 'package:treasure_nft_project/utils/app_text_style.dart';
import 'package:treasure_nft_project/widgets/button/login_button_widget.dart';
import '../../constant/theme/app_image_path.dart';
import '../../constant/ui_define.dart';
import '../../view_models/wallet/wallet_fiat_currency_provider.dart';
import '../../view_models/wallet/wallet_fiat_deposit_viewmodel.dart';
import '../../view_models/wallet/wallet_pay_type_provider.dart';
import '../../widgets/button/login_bolder_button_widget.dart';
import '../../widgets/drop_buttom/custom_drop_button.dart';
import '../../widgets/text_field/login_text_widget.dart';
import 'data/pay_type_data.dart';


/// 法幣充值
class FiatDepositPage extends ConsumerStatefulWidget {
  const FiatDepositPage({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _FiatDepositPageState();
}

class _FiatDepositPageState extends ConsumerState<FiatDepositPage> {
  late WalletFiatDepositViewModel viewModel;
  int? get currentFiatIndex => ref.watch(fiatCurrentIndexProvider);
  int? get currentPayTypeIndex => ref.watch(payTypeCurrentIndexProvider);
  List<String> get fiatList => ref.watch(walletFiatTypeProvider) ?? [];
  List<PayTypeData> get payTypeList => ref.watch(walletPayTypeProvider) ?? [];

  @override
  void initState() {
    ref.read(walletFiatTypeProvider.notifier).init();
    viewModel = WalletFiatDepositViewModel(
        onViewChange: () {
          if (mounted) {
            setState(() {});
          }},
        context: context,
        ref: ref
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: AppColors.opacityBackground,
        body: GestureDetector(
            onTap: () => viewModel.popPage(context),
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
                          child: _buildBackground(child: _buildBody(context, false)),
                        ),

                        Positioned(
                            top: -10,
                            right: -1,
                            child: Image.asset(AppImagePath.walletDepositDollar)),

                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: UIDefine.getPixelWidth(20)),
                          child: _buildBody(context, true),
                        )
                      ],
                    ),
                  ),
                ))));
  }

  Widget _buildBackground({required Widget child}) {
    return Container(
      width: UIDefine.getWidth(),
      margin: EdgeInsets.symmetric(horizontal: UIDefine.getPixelWidth(25)),
      padding: EdgeInsets.all(UIDefine.getPixelWidth(10)),
      decoration: AppStyle().styleColorsRadiusBackground(
          color: Colors.white.withOpacity(0.3), radius: 15),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Container(
          decoration: const BoxDecoration(
              color: Colors.white,
              image: DecorationImage(
                  image: AssetImage(AppImagePath.backgroundDeposit),
                  fit: BoxFit.cover)),
          child: child,
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context, bool vis) {
    return Visibility(
        visible: vis,
        maintainState: true,
        maintainAnimation: true,
        maintainSize: true,
        child:Container(
        width: UIDefine.getWidth(),
    margin: EdgeInsets.symmetric(horizontal: UIDefine.getPixelWidth(25)),
    padding: EdgeInsets.all(UIDefine.getPixelWidth(20)),
    child:Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            margin: EdgeInsets.all(UIDefine.getPixelWidth(18)),
            padding: EdgeInsets.only(right: UIDefine.getPixelWidth(60)),
            child: Text(
              tr("fiatCurrencyRecharge"),
              style: AppTextStyle.getBaseStyle(
                  fontWeight: FontWeight.w800, fontSize: UIDefine.fontSize28),
            )),
        _buildContext(),
        _buildButton(),
      ],
    )));
  }

  Widget _buildContext() {
    return Container(
        padding: EdgeInsets.symmetric(
            horizontal: UIDefine.getPixelWidth(20)),
        constraints: BoxConstraints(maxHeight: UIDefine.getPixelWidth(365)),//內容高
        width: UIDefine.getWidth(),
        child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              _buildFirstDrop(),
              _buildSecondDrop(),
              _buildAmount(),
              _buildMinMaxButton(),
              _buildEarn(),
        ])
    );
  }

  Widget _buildFirstDrop() {
    return Container(
        padding: EdgeInsets.symmetric(vertical: UIDefine.getPixelWidth(10)),
        child:CustomDropButton(
            itemIcon: (index) => viewModel.getFiatItemIcon(fiatList[index]),
            needBackgroundOpacity: true,
            initIndex: currentFiatIndex,
            needShowEmpty: false,
            hintSelect: tr("placeholder-coin"),
            listLength: fiatList.length,
            itemString: (int index, bool needArrow) => fiatList[index],
            onChanged: (index) {
              ref.read(currentFiatProvider.notifier).state = fiatList[index];
              ref.read(fiatCurrentIndexProvider.notifier)
                  .update((state) => index);

              /// 選擇幣種後查詢支付類型
              ref.read(walletPayTypeProvider.notifier).setRef(ref);
              ref.read(walletPayTypeProvider.notifier).init();
            }));
  }

  Widget _buildSecondDrop() {
    return Container(
        padding: EdgeInsets.symmetric(vertical: UIDefine.getPixelWidth(10)),
        child:CustomDropButton(
            itemIcon: (index) => viewModel.getPayTypeItemIcon(payTypeList[index].type),
            needBackgroundOpacity: true,
            initIndex: currentPayTypeIndex,
            needShowEmpty: true,
            hintSelect: tr("chooseAPaymentMethod"),
            listLength: payTypeList.length,
            itemString: (int index, bool needArrow) => payTypeList[index].type,
            onChanged: (index) {
              ref.read(currentPayTypeProvider.notifier).state = payTypeList[index];
              ref.read(payTypeCurrentIndexProvider.notifier)
                  .update((state) => index);
              viewModel.onViewChange();
            }));
  }

  Widget _buildAmount() {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              padding: EdgeInsets.only(top: UIDefine.getPixelWidth(10)),
              child:Text(tr("purchasingPrice"),
                  maxLines: 1,
                  style: AppTextStyle.getBaseStyle(
                      fontSize: UIDefine.fontSize14,
                      fontWeight: FontWeight.w400,
                      color: AppColors.textBlack))),

          LoginTextWidget(
              bLimitDecimalLength:true,
              initColor:Colors.white.withOpacity(0.5),
              hintText: tr("mintAmount-placeholder'"),
              controller: viewModel.amountController,
              contentPaddingRight: UIDefine.getScreenWidth(20),
              bFocusedGradientBolder: true,
              onChanged:(v)=>viewModel.onTextChange()
          ),

          Container(
              padding: EdgeInsets.only(bottom: UIDefine.getPixelWidth(5)),
              child:Visibility(
                  visible: viewModel.errorHint,
                  child: Text(tr("amountRangeError"),
                      maxLines: 1,
                      style: AppTextStyle.getBaseStyle(
                          fontSize: UIDefine.fontSize14,
                          fontWeight: FontWeight.w400,
                          color: AppColors.rateRed))
              ))
    ]);
  }

  Widget _buildMinMaxButton(){
    return Container(
      margin: EdgeInsets.only(bottom: UIDefine.getPixelHeight(5)),
      child:Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(child:
          LoginBolderButtonWidget(
            radius: 10,
            needWhiteBackground: true,
            height: UIDefine.getPixelWidth(45),
            margin:EdgeInsets.only(right: UIDefine.getPixelHeight(5)),
            btnText: '${tr("minimum")} ${ref.read(currentPayTypeProvider.notifier).state.startPrice}',
            onPressed: () => viewModel.onMinimum(),
            isFillWidth: false,
            fontWeight: FontWeight.w600,
            fontSize: UIDefine.fontSize12,
          )),

          Expanded(child:
          LoginBolderButtonWidget(
            radius: 10,
            needWhiteBackground: true,
            height: UIDefine.getPixelWidth(45),
            margin:EdgeInsets.only(left: UIDefine.getPixelHeight(5)),
            btnText: '${tr("maximum")} ${ref.read(currentPayTypeProvider.notifier).state.endPrice}',
            onPressed: () => viewModel.onMaximum(),
            isFillWidth: false,
            fontWeight: FontWeight.w600,
            fontSize: UIDefine.fontSize12,
          ))

        ]));
  }

  Widget _buildEarn() {
    return Align(
        alignment: Alignment.centerLeft,
        child:Text(
            '${tr("available")}:≈${viewModel.available} USDT',
            maxLines: 1,
            style: AppTextStyle.getBaseStyle(
                fontSize: UIDefine.fontSize14,
                fontWeight: FontWeight.w400,
                color: AppColors.textBlack)
        ));
  }

  Widget _buildButton() {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: UIDefine.getPixelHeight(5)),
        child:Row(
            children: [
              Expanded(child:
              LoginBolderButtonWidget(
                btnText: tr("cancel"),
                onPressed: () => viewModel.popPage(context),
                isFillWidth: false,
                fontWeight: FontWeight.w600,
                fontSize: UIDefine.fontSize14,
              )),

              Expanded(child:
              LoginButtonWidget(
                btnText: tr("confirm"),
                onPressed: () => viewModel.onPressConfirm(),
                isFillWidth: false,
                fontWeight: FontWeight.w600,
                fontSize: UIDefine.fontSize14,
              ))

            ])
    );
  }


}
