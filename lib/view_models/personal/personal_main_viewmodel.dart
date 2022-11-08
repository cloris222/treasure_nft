import 'package:treasure_nft_project/view_models/base_view_model.dart';

import '../../constant/call_back_function.dart';
import '../../models/http/api/user_info_api.dart';
import '../../models/http/parameter/check_level_info.dart';
import '../../models/http/parameter/user_order_info.dart';
import '../../models/http/parameter/user_property.dart';

class PersonalMainViewModel extends BaseViewModel {
  PersonalMainViewModel({required this.setState});

  final ViewChange setState;
  CheckLevelInfo? levelInfo;
  UserProperty? userProperty;
  UserOrderInfo? userOrderInfo;

  void initState() {
    updateData();
  }

  void updateData() {
    UserInfoAPI().getCheckLevelInfoAPI().then((value) {
      setState(() {
        levelInfo = value;
      });
    });
    UserInfoAPI().getUserPropertyInfo().then((value) {
      setState(() {
        userProperty = value;
      });
    });
    UserInfoAPI().getUserOrderInfo().then((value) {
      setState(() {
        userOrderInfo = value;
      });
    });
    uploadPersonalInfo().then((value) {
      setState(() {});
    });
  }
}
