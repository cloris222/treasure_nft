import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:treasure_nft_project/constant/call_back_function.dart';
import 'package:treasure_nft_project/utils/app_shared_Preferences.dart';
import 'package:treasure_nft_project/view_models/base_view_model.dart';

import '../../../constant/enum/route_setting_enum.dart';
import '../../../constant/global_data.dart';
import '../../../models/http/api/test_route_api.dart';

class UserLineSettingViewModel extends BaseViewModel {
  UserLineSettingViewModel({required this.onViewChange});

  final onClickFunction onViewChange;

  Future<void> onChangeRoute(BuildContext context, RouteSetting type) async {
    TestRouteAPI().setChangeRoute(type).then((value) {
      showToast(context, tr("success"));
      GlobalData.appLineSetting = type;
      AppSharedPreferences.setRouteSetting(type);
      onViewChange();
    });
  }
}
