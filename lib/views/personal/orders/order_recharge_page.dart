import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:treasure_nft_project/constant/theme/app_image_path.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';
import 'package:treasure_nft_project/view_models/base_view_model.dart';
import 'package:treasure_nft_project/widgets/appbar/custom_app_bar.dart';

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
    return Column(
      children: [
        _buildChoseAddress(),
        Wrap(
          runSpacing: 25,
          children: [
            _buildAddressInfo(),
            _buildAddressPath(),
            _buildAddressChain(),
            _buildAddressHint(),
          ],
        )
      ],
    );
  }

  Widget _buildChoseAddress() {
    return Row(
      children: [TetherCoinWidget(size: UIDefine.fontSize24)],
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
