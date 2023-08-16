import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:format/format.dart';
import 'package:treasure_nft_project/constant/theme/app_image_path.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';
import 'package:treasure_nft_project/models/http/api/wallet_api.dart';
import 'package:treasure_nft_project/view_models/wallet/wallet_aisle_provider.dart';
import 'package:treasure_nft_project/view_models/wallet/wallet_fiat_currency_provider.dart';
import 'package:treasure_nft_project/view_models/wallet/wallet_pay_type_provider.dart';
import '../../constant/call_back_function.dart';
import '../../widgets/dialog/common_custom_dialog.dart';
import '../base_view_model.dart';
import 'package:intl/intl.dart';


class WalletFiatDepositViewModel extends BaseViewModel {
  WalletFiatDepositViewModel({
    required this.onViewChange,
    required this.context,
    required this.ref,
  });
  final onClickFunction onViewChange;
  final BuildContext context;
  final WidgetRef ref;

  TextEditingController amountController = TextEditingController();
  String available = '0.00';

  bool errorHint = false;

  void onTextChange() {
    available = getAvailable();
    onViewChange();
  }

  String getMinText() {
    return getThousandFormat(
        ref.read(currentPayTypeProvider.notifier).state.startPrice);
  }

  String getMaxText() {
    return getThousandFormat(
        ref.read(currentPayTypeProvider.notifier).state.endPrice);
  }

  void onMinimum() {
    amountController.text =
        ref.read(currentPayTypeProvider.notifier).state.startPrice.toString();
    onTextChange();
  }

  void onMaximum() {
    amountController.text =
        ref.read(currentPayTypeProvider.notifier).state.endPrice.toString();
    onTextChange();
  }

  String getAvailable() {
    if (amountController.text.isEmpty) {
      return '0.00';
    }
    return truncateToDecimalPlaces(
        (double.parse(amountController.text) *
            ref.read(currentPayTypeProvider.notifier).state.currentRate),
        2).toString();
  }

  void onPressConfirm() async {
    if (checkAmount()) {
      await WalletAPI().depositCurrency(
        payType: ref.read(currentPayTypeProvider.notifier).state.type,
        currency: ref.read(currentFiatProvider.notifier).state,
        amount: double.parse(amountController.text),
        route: ref.read(currentAisleProvider.notifier).state.route
      ).then((value) => {
        popPage(context),
        showSuccessDialog(value.redirectUrl),
        launchInBrowser(value.redirectUrl),
      });
    }
  }

  bool checkAmount() {
    if(double.parse(amountController.text)
        < ref.read(currentPayTypeProvider.notifier).state.startPrice
        || double.parse(amountController.text)
            > ref.read(currentPayTypeProvider.notifier).state.endPrice){
      errorHint = true;
      onViewChange();
      return false;
    }
    errorHint = false;
    onViewChange();
    return true;
  }

  Widget getFiatItemIcon(String fiatName) {
    return Image.asset(
      format(AppImagePath.walletFiatIcon, {"fiat": fiatName.toLowerCase()}),
      scale: 0.75,
    );
  }

  Widget getPayTypeItemIcon(String typeName) {
    return Image.asset(
      format(AppImagePath.walletPayTypeIcon, {"payType": typeName.toLowerCase()}),
      width: UIDefine.getPixelHeight(32),
      scale: 0.75,
      errorBuilder: (context, error, stackTrace) => Container(),
    );
  }

  Widget getAisleItem(){
    return Container();
  }

  String getThousandFormat(num number) {
    var formatter = NumberFormat('###,###,###',"en_US");
    return formatter.format(number);
  }

  void showSuccessDialog(String link) {
    CommonCustomDialog(context,
        bOneButton: false,
        title: tr("success"),
        content: "${tr('aboutJump')}\n${tr("redirectMsg")}",
        type: DialogImageType.success,
        leftBtnText: tr("redirect"),
        rightBtnText: tr('copyLink'),
        onLeftPress: () => launchInBrowser(link),
        onRightPress: () => {
          showToast(getGlobalContext(), tr("copied")),
          copyText(copyText: link)}
    ).show();
  }

}