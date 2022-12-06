import 'package:treasure_nft_project/view_models/base_view_model.dart';

import '../../constant/call_back_function.dart';
import '../../models/http/api/user_info_api.dart';
import '../../models/http/parameter/check_level_info.dart';
import '../../models/http/parameter/user_order_info.dart';
import '../../models/http/parameter/user_property.dart';

class PersonalMainViewModel extends BaseViewModel {
  PersonalMainViewModel({required this.setState});

  final ViewChange setState;

  void initState() {
    updateData();
  }

  void updateData() {
    List<bool> checkList = List<bool>.generate(4, (index) => false);

    UserInfoAPI().getCheckLevelInfoAPI().then((value) => checkList[0] = true);
    UserInfoAPI().getUserPropertyInfo().then((value) => checkList[1] = true);
    UserInfoAPI().getUserOrderInfo().then((value) => checkList[2] = true);
    uploadPersonalInfo().then((value) => checkList[3] = true);

    checkFutureTime(
            logKey: 'PersonalMain_updateData',
            onCheckFinish: () => !checkList.contains(false))
        .then((value) => setState(() {}));
  }
}
