import 'package:treasure_nft_project/models/http/parameter/check_share_center.dart';
import 'package:treasure_nft_project/view_models/base_view_model.dart';

import '../../../constant/call_back_function.dart';
import '../../../models/http/api/group_api.dart';

class ShareCenterViewModel extends BaseViewModel {
  ShareCenterViewModel({
    required this.setState,
  });

  final onClickFunction setState;
  CheckShareCenter? shareCenterInfo;

  void initState() async {
    shareCenterInfo = await GroupAPI().getShareCenter();
    setState();
  }
}
