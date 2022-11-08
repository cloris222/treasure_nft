import 'package:treasure_nft_project/models/http/api/group_api.dart';
import 'package:treasure_nft_project/view_models/base_view_model.dart';

import '../../../constant/call_back_function.dart';
import '../../../models/http/parameter/other_collect_data.dart';
import '../../../models/http/parameter/other_user_info.dart';

class OtherCollectViewModel extends BaseViewModel {
  OtherCollectViewModel({required this.onViewUpdate});

  final onClickFunction onViewUpdate;
  OtherUserInfo? userInfo;
  List<OtherCollectData> list = [];

  void initState(String orderNo, bool isSeller) async {
    userInfo =
        await GroupAPI().getOtherUserInfo(orderNo: orderNo, isSeller: isSeller);
    onViewUpdate();

    ///MARK: 做~~~~~~~listview
  }
}
