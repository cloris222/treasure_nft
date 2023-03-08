import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:treasure_nft_project/widgets/list_view/base_list_interface.dart';
import '../../../constant/ui_define.dart';
import '../../../views/explore/api/explore_api.dart';
import '../../../views/explore/data/explore_category_response_data.dart';
import '../../../views/explore/data/explore_main_response_data.dart';
import 'explore_main_item_view.dart';

class GetExploreMainListView extends ConsumerStatefulWidget {
  const GetExploreMainListView({super.key, required this.type});

  final ExploreCategoryResponseData type;

  @override
  ConsumerState createState() => _GetExploreMainListViewState();
}

class _GetExploreMainListViewState extends ConsumerState<GetExploreMainListView>
    with BaseListInterface {
  @override
  void initState() {
    init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return buildGridView(crossAxisCount: 2);
  }

  @override
  Widget buildItemBuilder(int index, data) {
    return ExploreMainItemView(exploreMainResponseData: data);
  }

  @override
  Widget buildSeparatorBuilder(int index) {
    return SizedBox(height: UIDefine.getScreenWidth(1));
  }

  @override
  Widget? buildTopView() {
    return null;
  }

  @override
  Future<List> loadData(int page, int size) async {
    return await ExploreApi()
        .getExploreArtists(page: page, size: size, category: widget.type.name);
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
    return "exploreList_${widget.type.name}";
  }

  @override
  bool setUserTemporaryValue() {
    return false;
  }

  @override
  changeDataFromJson(json) {
    return ExploreMainResponseData.fromJson(json);
  }
}
