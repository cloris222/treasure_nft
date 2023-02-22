import 'package:flutter_riverpod/src/consumer.dart';
import 'package:treasure_nft_project/view_models/base_view_model.dart';
import 'package:treasure_nft_project/view_models/gobal_provider/user_level_info_provider.dart';
import 'package:treasure_nft_project/view_models/gobal_provider/user_order_info_provider.dart';

import '../../constant/call_back_function.dart';
import '../gobal_provider/user_experience_info_provider.dart';
import '../gobal_provider/user_info_provider.dart';
import '../gobal_provider/user_property_info_provider.dart';
import '../gobal_provider/user_trade_status_provider.dart';

class PersonalMainViewModel extends BaseViewModel {
  PersonalMainViewModel({required this.onViewChange});

  final onClickFunction onViewChange;

  void initState(WidgetRef ref) {
    updateData(ref);
  }

  void updateData(WidgetRef ref) {
    ref.read(userLevelInfoProvider.notifier).update();
    ref.read(userPropertyInfoProvider.notifier).update();
    ref.read(userOrderInfoProvider.notifier).update();
    ref.read(userInfoProvider.notifier).update();
    ref.read(userExperienceInfoProvider.notifier).update();
    ref.read(userTradeStatusProvider.notifier).update();
  }
}
