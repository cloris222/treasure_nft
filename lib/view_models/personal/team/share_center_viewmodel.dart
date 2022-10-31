import 'package:treasure_nft_project/constant/global_data.dart';
import 'package:treasure_nft_project/models/http/api/user_info_api.dart';
import 'package:treasure_nft_project/models/http/parameter/user_info_data.dart';
import 'package:treasure_nft_project/view_models/base_view_model.dart';

import '../../../constant/call_back_function.dart';

class ShareCenterViewModel extends BaseViewModel{
ShareCenterViewModel({required this.setState,});

  final onClickFunction setState;

  void initState() async {
    GlobalData.userInfo = await UserInfoAPI().getPersonInfo();
    setState();
  }
}