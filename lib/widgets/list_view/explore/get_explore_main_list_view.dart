import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:treasure_nft_project/view_models/explore/explore_list_provider.dart';
import 'package:treasure_nft_project/widgets/list_view/base_list_interface.dart';
import '../../../constant/ui_define.dart';
import '../../../views/explore/data/explore_category_response_data.dart';
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
    ref.read(exploreListProvider(widget.type).notifier).init(onFinish: () {
      initListView();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return buildGridView(crossAxisCount: 2);
  }

  @override
  void addCurrentList(List data) {
    ref.read(exploreListProvider(widget.type).notifier).addList(data);
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
  void clearCurrentList() {
    ref.read(exploreListProvider(widget.type).notifier).clearList();
  }

  @override
  List getCurrentList() {
    return ref.read(exploreListProvider(widget.type));
  }

  @override
  Future<List> loadData(int page, int size) {
    return ref
        .read(exploreListProvider(widget.type).notifier)
        .loadData(page: page, size: size, needSave: needSave(page, size));
  }

  bool needSave(int page, int size) {
    return page == 1;
  }

  @override
  void loadingFinish() {
    if (mounted) {
      setState(() {});
    }
  }
}
