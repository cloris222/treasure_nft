import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:treasure_nft_project/models/http/api/wallet_api.dart';
import 'package:treasure_nft_project/view_models/wallet/wallet_fiat_currency_provider.dart';
import 'package:treasure_nft_project/view_models/wallet/wallet_pay_type_provider.dart';
import '../../constant/call_back_function.dart';
import '../base_view_model.dart';


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

  void onTextChange() {
    available = getAvailable();
    onViewChange();
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

  void onPressConfirm() async{
    await WalletAPI().depositCurrency(
      payType: ref.read(currentPayTypeProvider.notifier).state.type,
      currency: ref.read(currentFiatProvider.notifier).state,
      amount: double.parse(amountController.text),
    ).then((value) => {
      popPage(context),
      launchInBrowser(value.redirectUrl),
    });
  }

}