import 'package:flutter/material.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';
import 'package:treasure_nft_project/models/http/api/group_api.dart';
import '../../../models/http/parameter/other_collect_data.dart';
import '../../../models/http/parameter/other_user_info.dart';
import '../../../models/http/parameter/user_info_data.dart';
import '../../../widgets/list_view/team/other_collect_item.dart';
import '../../base_list_view_model.dart';

class OtherCollectViewModel extends BaseListViewModel {
  OtherCollectViewModel(
      {required super.onListChange,
      super.hasTopView = true,
      required this.topView});

  OtherUserInfo? userInfo;
  List<OtherCollectData> list = [];
  bool isDesc = true;
  String nftName = '';
  final Widget Function(UserInfoData) topView;

  void initState(String orderNo, bool isSeller) async {
    userInfo =
        await GroupAPI().getOtherUserInfo(orderNo: orderNo, isSeller: isSeller);
    onListChange();
    initListView();
  }

  @override
  Widget itemView(int index, data) {
    return Padding(
      padding: index % 2 == 0 ?
      EdgeInsets.only(left: UIDefine.getScreenWidth(4))
        :
      EdgeInsets.only(right: UIDefine.getScreenWidth(4)),
      child: OtherCollectItem(data: data)
    );
  }

  @override
  Future<List> loadData(int page, int size) async {
    return GroupAPI().getOtherCollectData(
        page: page,
        size: size,
        userId: userInfo?.id ?? '',
        isDesc: isDesc,
        nftName: nftName);
  }

  @override
  Widget buildTopView() {
    return topView(getUserInfo());
  }

  UserInfoData getUserInfo() {
    return UserInfoData(
      bannerUrl: userInfo?.bannerUrl ?? '',
      photoUrl: userInfo?.photoUrl ?? '',
      name: userInfo?.name ?? '',
      medal: userInfo?.medalCode ?? '',
      level: userInfo?.userLevel ?? 0,
    );
  }
}
