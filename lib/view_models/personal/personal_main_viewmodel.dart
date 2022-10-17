import 'package:treasure_nft_project/view_models/base_view_model.dart';

import '../../constant/call_back_function.dart';
import '../../models/http/api/user_info_api.dart';
import '../../models/http/parameter/check_level_info.dart';
import '../../models/http/parameter/user_property.dart';

class PersonalMainViewModel extends BaseViewModel {
  PersonalMainViewModel({required this.setState});

  final ViewChange setState;
  CheckLevelInfo? levelInfo;
  UserProperty? userProperty;

  void initState() async {
    levelInfo = await UserInfoAPI().getCheckLevelInfoAPI();
    userProperty = await UserInfoAPI().getUserPropertyInfo();
    await uploadPersonalInfo();
    setState(() {});
  }
}
