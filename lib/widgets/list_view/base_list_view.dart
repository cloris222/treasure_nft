import 'package:flutter/material.dart';

class BaseListView extends StatefulWidget {
  const BaseListView({
    Key? key,
    this.maxLoad = 10,
    required this.init,
    required this.getItemCount,
    required this.createItemBuilder,
    this.createSeparatorBuilder,
    this.buildTopView,
    this.isAutoReloadMore = true,
    this.physics,
    this.shrinkWrap = false,
    this.padding,
  }) : super(key: key);
  final int maxLoad;
  final ScrollPhysics? physics;
  final bool shrinkWrap;
  final EdgeInsetsGeometry? padding;

  ///MARK: 初始化
  final void Function(BuildContext context) init;

  ///MARK: 讀取資料
  final Widget Function(BuildContext context, int index) createItemBuilder;
  ///MARK: 建立間隔view
  final Widget Function(BuildContext context, int index)?
      createSeparatorBuilder;

  final int Function() getItemCount;

  ///MARK: 是否有上方view
  final Widget Function(BuildContext context)? buildTopView;

  ///MARK: 是否自動讀取(僅支援listview)
  final bool isAutoReloadMore;

  @override
  State<BaseListView> createState() => _BaseListViewState();
}

class _BaseListViewState extends State<BaseListView> {
  ///MARK:判斷初始化是否讀取完畢
  bool _isInitFinish = false;

  ///MARK:目前頁數
  int currentPage = 1;
  @protected
  List<dynamic> currentItems = <dynamic>[];
  @protected
  List<dynamic> nextItems = <dynamic>[];

  ///MARK:判斷是否要顯示讀取
  bool _showWaitLoad = false;

  ///MARK:移除項目清單
  List<int> removeItems = <int>[];

  ///MARK:可以放暫存的資料
  List<dynamic> reloadItems = [];

  @override
  void initState() {
    widget.init(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        shrinkWrap: widget.shrinkWrap,
        physics: widget.shrinkWrap
            ? const NeverScrollableScrollPhysics()
            : widget.physics,
        padding: widget.padding,
        itemBuilder: (context, index) {
          return widget.createItemBuilder(context, index);
        },
        itemCount: widget.getItemCount(),
        separatorBuilder: (BuildContext context, int index) {
          if (widget.createSeparatorBuilder == null) {
            return const SizedBox();
          }
          return widget.createSeparatorBuilder!(context, index);
        });
  }

  void onListChange() {
    if (mounted) {
      setState(() {});
    }
  }

  Future<void> _uploadList() async {
    _showWaitLoad = true;
    onListChange();

    if (currentPage == 1) {
      currentItems = await loadData(currentPage, maxLoad);
    } else {
      currentItems.addAll(nextItems);
    }
    nextItems = await loadData(currentPage + 1, maxLoad);
  }
}
