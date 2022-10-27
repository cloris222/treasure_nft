import 'package:flutter/src/widgets/framework.dart';
import 'package:treasure_nft_project/models/http/api/user_info_api.dart';
import 'package:treasure_nft_project/view_models/base_list_view_model.dart';

import '../../../models/http/parameter/user_property.dart';

class OrderDetailViewModel extends BaseListViewModel {
  OrderDetailViewModel(
      {required super.onListChange,});

  UserProperty? userProperty;

  Future<void> initState() async {
    userProperty = await UserInfoAPI().getUserPropertyInfo();
    onListChange();
  }

  @override
  Widget itemView(int index, data) {
    // TODO: implement itemView
    throw UnimplementedError();
  }

  @override
  Future<List> loadData(int page, int size) {
    // TODO: implement loadData
    throw UnimplementedError();
  }
}
