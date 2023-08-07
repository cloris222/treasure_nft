import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:treasure_nft_project/models/http/api/home_api.dart';
import 'package:treasure_nft_project/models/http/parameter/home_banner_data.dart';
import '../../../constant/ui_define.dart';
import '../../../view_models/home/provider/home_banner_provider.dart';
import '../base_list_interface.dart';
import 'banner_item.dart';


/// 首頁廣告輪播
class BannerListView extends ConsumerStatefulWidget {
  const BannerListView({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _BannerListViewState();
}

class _BannerListViewState extends ConsumerState<BannerListView> with BaseListInterface {
  @override
  void initState() {
    init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    GlobalKey<_BannerListViewState> sliderKey = GlobalKey();
    return currentItems.isNotEmpty ? buildPageCarouselView(sliderKey, slideTransition: ref.read(bannerSecondsProvider)) : const SizedBox();
  }

  @override
  Widget buildItemBuilder(int index, data) {
    return Container(
      alignment: Alignment.center,
      // padding: EdgeInsets.symmetric(horizontal: UIDefine.getPixelWidth(16)),
      child: BannerItemView(itemData: data),
    );
  }

  @override
  Widget buildSeparatorBuilder(int index) {
    return SizedBox(height: UIDefine.getPixelWidth(10));
  }

  @override
  Widget? buildTopView() {
    return null;
  }

  @override
  Future<List> loadData(int page, int size) async {
    List<BannerData> itemList = [];

    itemList.addAll(await HomeAPI().getBanner(ref));
    return itemList;
  }

  @override
  bool needSave(int page) {
    return page == 1;
  }

  @override
  void loadingFinish() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  String setKey() {
    return "homeBannerList";
  }

  @override
  bool setUserTemporaryValue() {
    return true;
  }

  @override
  changeDataFromJson(json) {
    return BannerData.fromJson(json);
  }
}

