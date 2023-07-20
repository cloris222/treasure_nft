import 'dart:core';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:treasure_nft_project/models/http/api/announce_api.dart';
import 'package:treasure_nft_project/utils/app_shared_Preferences.dart';
import 'package:treasure_nft_project/widgets/list_view/base_list_interface.dart';
import '../../constant/ui_define.dart';
import '../../models/http/parameter/announce_data.dart';
import '../../utils/language_util.dart';
import '../../view_models/announcement/announce_tag_provider.dart';
import '../../view_models/announcement/announcement_view_model.dart';
import 'announcement_item_view.dart';


class AnnouncementListView extends ConsumerStatefulWidget {
  const AnnouncementListView(
      this.viewModel,
      {Key? key,
  }) : super(key: key);

  final AnnouncementViewModel viewModel;

  @override
  ConsumerState createState() => _AnnouncementListViewState();
}

class _AnnouncementListViewState
    extends ConsumerState<AnnouncementListView>
    with BaseListInterface {
  AnnouncementViewModel get viewModel{
    return widget.viewModel;
  }

  @override
  void initState() {
    init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return buildListView(
        padding: EdgeInsets.only(bottom: UIDefine.navigationBarPadding));
  }

  @override
  Widget buildItemBuilder(int index, data) {
    return AnnouncementItemView(viewModel: viewModel, data: data);
  }

  @override
  Widget? buildTopView() {
    return SizedBox(height: UIDefine.getPixelHeight(16));
  }

  @override
  Future<List> loadData(int page, int size) async {
    // String getLang = await AppSharedPreferences.getLanguage();
    String lang = LanguageUtil.getAppStrLanguageForHttp();
    print("the lange is :${lang}");
    List<AnnounceData> itemList = [];
    itemList.addAll(await AnnounceAPI().getAnnounceAll(lang: lang));
    return itemList;
  }

  @override
  bool needSave(int page) {
    return page == 0;
  }

  @override
  void loadingFinish() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  String setKey() {
    return "announceList";
  }

  @override
  bool setUserTemporaryValue() {
    return true;
  }

  @override
  changeDataFromJson(json) {
    return AnnounceData.fromJson(json);
  }
}
