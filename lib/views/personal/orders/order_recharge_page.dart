import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:treasure_nft_project/constant/theme/app_image_path.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';
import 'package:treasure_nft_project/view_models/base_view_model.dart';
import 'package:treasure_nft_project/widgets/appbar/custom_app_bar.dart';

import '../../../constant/theme/app_colors.dart';
import '../../../constant/theme/app_style.dart';
import '../../../view_models/personal/orders/order_recharge_viewmodel.dart';
import '../../../widgets/app_bottom_navigation_bar.dart';
import '../../../widgets/label/tether_coin_widget.dart';

///MARK: 充值
class OrderRechargePage extends StatefulWidget {
  const OrderRechargePage(
      {Key? key, this.type = AppNavigationBarType.typePersonal})
      : super(key: key);
  final AppNavigationBarType type;

  @override
  State<OrderRechargePage> createState() => _OrderRechargePageState();
}

class _OrderRechargePageState extends State<OrderRechargePage> {
  late OrderRechargeViewModel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = OrderRechargeViewModel(setState: setState);
    viewModel.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.getCommonAppBar(() {
        BaseViewModel().popPage(context);
      }, tr('walletRecharge')),
      body: _buildBody(),
      bottomNavigationBar: AppBottomNavigationBar(initType: widget.type),
    );
  }

  Widget _buildBody() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        children: [
          _buildChoseAddress(),
          Wrap(
            runSpacing: 20,
            children: [
              _buildAddressInfo(),
              _buildAddressPath(),
              _buildAddressChain(),
              _buildAddressHint(),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildChoseAddress() {
    return Container(
      width: UIDefine.getWidth(),
      decoration: AppStyle().styleUserSetting(),
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
      child: Row(
        children: [
          TetherCoinWidget(size: UIDefine.fontSize24),
          const SizedBox(width: 10),
          Text(viewModel.getCurrentChainText(),
              style: TextStyle(
                  color: AppColors.dialogBlack,
                  fontSize: UIDefine.fontSize16,
                  fontWeight: FontWeight.w500)),
          Flexible(child: Container()),

        ],
      ),
    );
  }

  Widget _buildAddressInfo() {
    return Container();
  }

  Widget _buildAddressPath() {
    return Container();
  }

  Widget _buildAddressChain() {
    return Container();
  }

  Widget _buildAddressHint() {
    return Container();
  }
}
