import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../widgets/app_bottom_navigation_bar.dart';
import '../../custom_appbar_view.dart';

///MARK: 訂單信息
class OrderInfoPage extends StatelessWidget {
  const OrderInfoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomAppbarView(
      needScrollView: false,
      title: tr('Notification_nav'),
      type: AppNavigationBarType.typePersonal,
      body: Container(),
    );
  }
}
