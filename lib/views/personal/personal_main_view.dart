// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';
import 'package:treasure_nft_project/views/personal/personal_new_sub_common_view.dart';
import 'package:treasure_nft_project/views/personal/personal_new_sub_level_view.dart';
import 'package:treasure_nft_project/views/personal/personal_new_sub_order_view.dart';
import 'package:treasure_nft_project/views/personal/personal_new_sub_team_view.dart';
import 'package:treasure_nft_project/views/personal/personal_new_sub_user_info_view.dart';

import '../../constant/theme/app_image_path.dart';
import '../../view_models/gobal_provider/user_experience_info_provider.dart';
import '../../view_models/gobal_provider/user_info_provider.dart';
import '../../view_models/gobal_provider/user_level_info_provider.dart';
import '../../view_models/gobal_provider/user_order_info_provider.dart';
import '../../view_models/gobal_provider/user_property_info_provider.dart';
import '../../view_models/gobal_provider/user_trade_status_provider.dart';

class PersonalMainView extends ConsumerStatefulWidget {
  const PersonalMainView({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _PersonalMainViewState();
}

class _PersonalMainViewState extends ConsumerState<PersonalMainView> {
  @override
  void initState() {
    updateData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Container(
            padding: EdgeInsets.only(bottom: UIDefine.navigationBarPadding),
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(AppImagePath.backgroundUser),
                    fit: BoxFit.fill)),
            child: Column(children: [
              Padding(
                  padding: EdgeInsets.all(UIDefine.getScreenWidth(5.5)),
                  child: PersonalNewSubUserInfoView(
                    onViewUpdate: () {},
                    showDailyTask: true,
                    enableModify: true,
                  )),
              Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: UIDefine.getScreenWidth(3.5)),
                  child: Column(children: [
                    PersonalNewSubLevelView(
                      userProperty: ref.watch(userPropertyInfoProvider),
                      levelInfo: ref.watch(userLevelInfoProvider),
                      onViewUpdate: () {},
                    ),
                    PersonalNewSubOrderView(
                        userOrderInfo: ref.watch(userOrderInfoProvider)),
                    PersonalNewSubTeamView(
                        levelInfo: ref.watch(userLevelInfoProvider)),
                    PersonalNewSubCommonView(onViewUpdate: () {}),
                    const SizedBox(height: 10)
                  ]))
            ])));
  }

  void updateData() {
    ref.read(userLevelInfoProvider.notifier).init();
    ref.read(userPropertyInfoProvider.notifier).init();
    ref.read(userOrderInfoProvider.notifier).init();
    ref.read(userInfoProvider.notifier).init();
    ref.read(userExperienceInfoProvider.notifier).init();
    ref.read(userTradeStatusProvider.notifier).init();
  }
}
