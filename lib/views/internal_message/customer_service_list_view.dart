import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:treasure_nft_project/constant/theme/app_style.dart';
import 'package:treasure_nft_project/views/internal_message/station_letter_detail_page.dart';
import 'package:treasure_nft_project/views/internal_message/station_letter_item_view.dart';
import 'package:treasure_nft_project/widgets/list_view/base_list_interface.dart';

import '../../constant/theme/app_colors.dart';
import '../../constant/ui_define.dart';
import '../../models/data/station_letter_data.dart';
import '../../models/http/api/announce_api.dart';
import '../../view_models/base_view_model.dart';
import '../../view_models/internal_message/user_letter_count_provider.dart';

/// 客服通知
class CustomerServiceListView extends ConsumerStatefulWidget {
  const CustomerServiceListView({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => CustomerServiceListViewState();
}

class CustomerServiceListViewState extends ConsumerState<CustomerServiceListView> with BaseListInterface {
  @override
  void initState() {
    init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return buildListView(
      padding: EdgeInsets.only(bottom: UIDefine.getPixelWidth(200)),
    );
  }

  @override
  Widget buildItemBuilder(int index, data) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () => _onPressDetail(index, data),
      child: StationLetterItemView(data: data, isSystemType: false),
    );
  }

  @override
  Widget buildSeparatorBuilder(int index) {
    return Container(
      height: 1,
      width: UIDefine.getWidth(),
      decoration: AppStyle().styleColorsRadiusBackground(color: AppColors.lineBarGrey, radius: 0),
    );
  }

  @override
  Widget? buildTopView() {
    return null;
  }

  @override
  changeDataFromJson(json) {
    return StationLetterData.fromJson(json);
  }

  @override
  int maxLoad() {
    return 20;
  }

  @override
  Future<List> loadData(int page, int size) {
    return AnnounceAPI().getStationLetterList(page: page, size: size);
  }

  @override
  void loadingFinish() {
    if (mounted) {
      setState(() {});
    }
    for (StationLetterData data in currentItems) {
      if (data.isRead) {
        ref.read(userLetterCountProvider.notifier).removeLetterId(data.id);
      } else {
        ref.read(userLetterCountProvider.notifier).addLetterId(data.id);
      }
    }
  }

  @override
  bool needSave(int page) {
    return page == 1;
  }

  @override
  String setKey() {
    return "stationLetter";
  }

  @override
  bool setUserTemporaryValue() {
    return true;
  }

  /// 點選公告視為已讀
  void _onPressDetail(int index, StationLetterData data) {
    BaseViewModel().pushPage(context, StationLetterDetailPage(data: data));
    currentItems[index] = data.copyWith(isRead: true);
    ref.read(userLetterCountProvider.notifier).removeLetterId(data.id);
    loadingFinish();
    setSharedPreferencesValue(maxSize: maxLoad());

    /// 已讀
    AnnounceAPI().setStationLetterRead([data.id]);
  }

  /// 已讀全部
  void onPressReadAll() async {
    if (ref.read(userLetterCountProvider).isNotEmpty) {
      await AnnounceAPI().setStationLetterRead(ref.read(userLetterCountProvider));
      for (int index = 0; index < currentItems.length; index++) {
        StationLetterData data = currentItems[index];
        currentItems[index] = data.copyWith(isRead: true);
      }
      ref.read(userLetterCountProvider.notifier).clear();
    }
    loadingFinish();
    setSharedPreferencesValue(maxSize: maxLoad());
  }
}
