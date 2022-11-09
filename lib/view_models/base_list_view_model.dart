import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:treasure_nft_project/constant/theme/app_colors.dart';

import '../constant/call_back_function.dart';
import '../constant/ui_define.dart';
import 'base_view_model.dart';

abstract class BaseListViewModel extends BaseViewModel {
  BaseListViewModel(
      {this.maxLoad = 10,
      required this.onListChange,
      this.shrinkWrap = true,
      this.hasTopView = false,
      this.isAutoReloadMore = true,
      this.physics});

  ///MARK:一次讀幾筆
  final int maxLoad;
  final onClickFunction onListChange;
  final bool shrinkWrap;
  final ScrollPhysics? physics;

  ///MARK: 是否有上方view(僅支援listview)
  final bool hasTopView;

  ///MARK: 是否自動讀取(僅支援listview)
  final bool isAutoReloadMore;

  ///MARK: 讀取資料
  Future<List<dynamic>> loadData(int page, int size);

  ///MARK: 建立子項目
  Widget itemView(int index, dynamic data);

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

  @protected
  Widget buildTopView() {
    return const SizedBox();
  }

  List<dynamic> getList() {
    return currentItems;
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

  bool _checkHasNextPage() {
    return nextItems.isNotEmpty;
  }

  void _readMorePage() {
    currentPage += 1;
  }

  Widget buildListView() {
    int length = currentItems.length;

    if (hasTopView) {
      length += 1;
    }

    if (_showWaitLoad || (!isAutoReloadMore && nextItems.isNotEmpty)) {
      length += 1;
    }
    return _buildListListener(
        listBody: ListView.builder(
            itemCount: length,
            shrinkWrap: shrinkWrap,
            physics: physics,
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              int itemIndex = index;
              if (hasTopView && index == 0) {
                return buildTopView();
              }

              if (hasTopView) {
                itemIndex -= 1;
              }
              if (itemIndex != currentItems.length) {
                return Visibility(
                    visible: !removeItems.contains(itemIndex),
                    child: itemView(itemIndex, currentItems[itemIndex]));
              } else {
                if (!_showWaitLoad &&
                    (!isAutoReloadMore && nextItems.isNotEmpty)) {
                  return _buildReadMore();
                }
                return _buildLoading();
              }
            }));
  }

  Widget buildGridView({
    required int crossAxisCount,
    double mainAxisSpacing = 0.0,
    double crossAxisSpacing = 0.0,
    double childAspectRatio = 1.0,
  }) {
    int length = currentItems.length;

    if (hasTopView) {
      length += 1;
    }

    if (_showWaitLoad || (!isAutoReloadMore && nextItems.isNotEmpty)) {
      length += 1;
    }
    return _buildListListener(
        listBody: GridView.builder(
            itemCount: length,
            shrinkWrap: shrinkWrap,
            physics: physics,
            scrollDirection: Axis.vertical,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              childAspectRatio: crossAxisSpacing,
              mainAxisSpacing: mainAxisSpacing,
              crossAxisSpacing: crossAxisSpacing,
            ),
            itemBuilder: (context, index) {
              int itemIndex = index;
              if (hasTopView && index == 0) {
                return buildTopView();
              }

              if (hasTopView) {
                itemIndex -= 1;
              }
              if (itemIndex != currentItems.length) {
                return Visibility(
                    visible: !removeItems.contains(itemIndex),
                    child: itemView(itemIndex, currentItems[itemIndex]));
              } else {
                if (!_showWaitLoad &&
                    (!isAutoReloadMore && nextItems.isNotEmpty)) {
                  return _buildReadMore();
                }
                return _buildLoading();
              }
            }));
  }

  _buildListListener({required Widget listBody}) {
    return NotificationListener<ScrollEndNotification>(
        onNotification: (scrollEnd) {
          final metrics = scrollEnd.metrics;
          if (metrics.atEdge) {
            bool isTop = metrics.pixels == 0;
            if (isTop) {
              debugPrint('At the top');
            } else {
              debugPrint('At the bottom');
              if (nextItems.isNotEmpty && isAutoReloadMore) {
                _onMorePress();
              }
            }
          }
          return true;
        },
        child: listBody);
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
              style: TextStyle(
                  color: AppColors.textBlack, fontSize: UIDefine.fontSize12),
            )));
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
    onListChange();
  }

  Future<void> _clearListView() async {
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
}
