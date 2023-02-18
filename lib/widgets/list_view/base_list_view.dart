import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:treasure_nft_project/constant/global_data.dart';
import 'package:treasure_nft_project/constant/theme/app_colors.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';
import 'package:treasure_nft_project/utils/app_text_style.dart';

class BaseListView extends StatefulWidget {
  const BaseListView({
    Key? key,
    this.maxLoad = 10,
    this.readAll = false,
    required this.init,
    required this.loadData,
    required this.getItemCount,
    required this.buildItemBuilder,
    this.buildSeparatorBuilder,
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
  final bool readAll;

  ///MARK: 初始化
  final Future<void> Function(BuildContext context) init;

  ///MARK: 讀取資料
  final Future<List<dynamic>> Function(int page, int size) loadData;

  ///MARK: 建立子項目
  final Widget Function(BuildContext context, dynamic data) buildItemBuilder;

  ///MARK: 建立間隔view
  final Widget Function(BuildContext context, int index)? buildSeparatorBuilder;

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

  bool get hasTopView {
    return widget.buildTopView != null;
  }

  @override
  void initState() {
    widget.init(context).then((value) {
      if (widget.readAll) {
        allListView();
      } else {
        initListView();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<dynamic> list = getShowList();
    int length = list.length;

    if (_showWaitLoad || (!widget.isAutoReloadMore && nextItems.isNotEmpty)) {
      length += 1;
    }
    return _buildListListener(
        listBody: ListView.separated(
            padding: widget.padding,
            itemCount: length,
            shrinkWrap: hasTopView ? true : widget.shrinkWrap,
            physics: hasTopView
                ? const NeverScrollableScrollPhysics()
                : widget.physics,
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              int itemIndex = index;
              if (itemIndex != list.length) {
                return Visibility(
                    visible: !removeItems.contains(itemIndex),
                    child: widget.buildItemBuilder(context, list[itemIndex]));
              } else {
                if (!_showWaitLoad &&
                    (!widget.isAutoReloadMore && nextItems.isNotEmpty)) {
                  return _buildReadMore();
                }
                return _buildLoading();
              }
            },
            separatorBuilder: (BuildContext context, int index) {
              if (widget.buildSeparatorBuilder == null) {
                return const SizedBox();
              }
              return widget.buildSeparatorBuilder!(context, index);
            }));
  }

  _buildLoading() {
    return Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.symmetric(vertical: 10),
        child: LoadingAnimationWidget.hexagonDots(
            color: AppColors.textBlack, size: 30));
  }

  _buildReadMore() {
    return Visibility(
        visible: !_showWaitLoad,
        child: TextButton(
            onPressed: _onMorePress,
            child: Text(
              tr('more'),
              style: AppTextStyle.getBaseStyle(
                  color: AppColors.textBlack, fontSize: UIDefine.fontSize12),
            )));
  }

  _buildListListener({required Widget listBody}) {
    return NotificationListener<ScrollEndNotification>(
        onNotification: (scrollEnd) {
          final metrics = scrollEnd.metrics;
          if (metrics.atEdge) {
            bool isTop = metrics.pixels == 0;
            if (isTop) {
              GlobalData.printLog('At the top');
            } else {
              GlobalData.printLog('At the bottom');
              if (nextItems.isNotEmpty && widget.isAutoReloadMore) {
                _onMorePress();
              }
            }
          }
          return true;
        },
        child: hasTopView
            ? SingleChildScrollView(
                child: Column(
                children: [widget.buildTopView!(context), listBody],
              ))
            : listBody);
  }

  void onListChange() {
    if (mounted) {
      setState(() {});
    }
  }

  void _onMorePress() {
    if (!_showWaitLoad) {
      _showWaitLoad = true;
      onListChange();
      _uploadListView();
    }
  }

  Future<void> initListView() async {
    await _clearListView();
    await _uploadList();
    _showWaitLoad = false;
    _isInitFinish = true;
    onListChange();
  }

  Future<void> _uploadListView() async {
    _readMorePage();
    await _uploadList();
    _showWaitLoad = false;
    onListChange();
  }

  ///MARK: 一次全讀 (for 留言回復清單)
  Future<void> allListView() async {
    await _clearListView();
    await _uploadList();
    while (nextItems.isNotEmpty) {
      _readMorePage();
      await _uploadList();
    }
    _showWaitLoad = false;
    _isInitFinish = true;
    onListChange();
  }

  Future<void> _uploadList() async {
    _showWaitLoad = true;
    onListChange();

    if (currentPage == 1) {
      currentItems = await widget.loadData(currentPage, widget.maxLoad);
    } else {
      currentItems.addAll(nextItems);
    }
    nextItems = await widget.loadData(currentPage + 1, widget.maxLoad);
  }

  Future<void> _clearListView() async {
    _isInitFinish = false;
    currentPage = 1;
    currentItems.clear();
    nextItems.clear();
    removeItems.clear();
    onListChange();
  }

  void removeItem(int index) {
    removeItems.add(index);
    onListChange();
  }

  void _readMorePage() {
    currentPage += 1;
  }

  List<dynamic> getShowList() {
    if (!_isInitFinish && reloadItems.isNotEmpty) {
      return reloadItems;
    }
    return currentItems;
  }
}
