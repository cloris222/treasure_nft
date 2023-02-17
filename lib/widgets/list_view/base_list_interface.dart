import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../constant/global_data.dart';
import '../../constant/theme/app_colors.dart';
import '../../constant/ui_define.dart';
import '../../utils/app_text_style.dart';

abstract class BaseListInterface {
  ///MARK:判斷是否要顯示讀取
  bool _showWaitLoad = false;

  ///MARK:目前頁數
  int _currentPage = 1;

  ///MARK: 暫存的下一筆資料
  List<dynamic> nextItems = [];

  ///MARK:移除項目清單
  List<int> removeItems = [];

  ///---- 實體化的function

  ///MARK: 取得清單
  List getCurrentList();

  ///MARK: 更新清單
  void addCurrentList(List data);

  void clearCurrentList();
  void loadingFinish();

  ///MARK: 讀取資料
  Future<List<dynamic>> loadData(int page, int size);

  ///MARK:判斷是否有上方view
  Widget? buildTopView();

  ///MARK: 建立子項目
  Widget buildItemBuilder(int index, dynamic data);

  ///MARK: 建立間隔view
  Widget buildSeparatorBuilder(int index) {
    return const SizedBox();
  }

  ///MARK: 最大筆數
  int maxLoad() {
    return 10;
  }

  ///MARK: 是否自動讀取(僅支援listview)
  bool isAutoReloadMore() {
    return true;
  }

  ///-----邏輯判斷------

  ///MARK:判斷是否一次全讀
  bool readAll() {
    return false;
  }

  Future<void> initListView() async {
    if (readAll()) {
      readAllListView();
    } else {
      _readInitListView();
    }
  }

  Future<void> reloadListView() async {
    if (readAll()) {
      await readAllListView();
    } else {
      _clearListView();
      await _readInitListView();
    }
  }

  Future<void> _readInitListView() async {
    await _uploadList();
    _showWaitLoad = false;
    loadingFinish();
  }

  Future<void> _uploadListView() async {
    _readMorePage();
    await _uploadList();
    _showWaitLoad = false;
    loadingFinish();
  }

  ///MARK: 一次全讀 (for 留言回復清單)
  Future<void> readAllListView() async {
    _clearListView();
    await _uploadList();
    while (nextItems.isNotEmpty) {
      _readMorePage();
      await _uploadList();
    }
    _showWaitLoad = false;
    loadingFinish();
  }

  Future<void> _uploadList() async {
    _showWaitLoad = true;
    if (_currentPage == 1) {
      clearCurrentList();
      addCurrentList(await loadData(_currentPage, maxLoad()));
    } else {
      addCurrentList(nextItems);
    }
    nextItems = await loadData(_currentPage + 1, maxLoad());
  }

  void _clearListView() {
    _currentPage = 1;
    nextItems.clear();
    removeItems.clear();
    clearCurrentList();
  }

  void removeItem(int index) {
    removeItems.add(index);
  }

  void _readMorePage() {
    _currentPage += 1;
  }

  ///-----View 建立

  Widget buildListView(
      {bool shrinkWrap = true,
      ScrollPhysics? physics,
      EdgeInsetsGeometry? padding}) {
    List<dynamic> list = getCurrentList();
    int length = list.length;
    Widget? topView = buildTopView();
    bool hasTopView = topView != null;

    if (_showWaitLoad || (!isAutoReloadMore() && nextItems.isNotEmpty)) {
      length += 1;
    }

    return _buildListListener(
        topView: topView,
        listBody: ListView.separated(
            padding: padding,
            itemCount: length,
            shrinkWrap: hasTopView ? true : shrinkWrap,
            physics:
                hasTopView ? const NeverScrollableScrollPhysics() : physics,
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              int itemIndex = index;
              if (itemIndex != list.length) {
                return Visibility(
                    visible: !removeItems.contains(itemIndex),
                    child: buildItemBuilder(itemIndex, list[itemIndex]));
              } else {
                if (!_showWaitLoad &&
                    (!isAutoReloadMore() && nextItems.isNotEmpty)) {
                  return _buildReadMore();
                }
                return _buildLoading();
              }
            },
            separatorBuilder: (BuildContext context, int index) =>
                buildSeparatorBuilder(index)));
  }

  Widget _buildListListener({required Widget listBody, Widget? topView}) {
    return NotificationListener<ScrollEndNotification>(
        onNotification: (scrollEnd) {
          final metrics = scrollEnd.metrics;
          if (metrics.atEdge) {
            bool isTop = metrics.pixels == 0;
            if (isTop) {
              GlobalData.printLog('At the top');
            } else {
              GlobalData.printLog('At the bottom');
              if (nextItems.isNotEmpty && isAutoReloadMore()) {
                _onMorePress();
              }
            }
          }
          return true;
        },
        child: topView != null
            ? SingleChildScrollView(
                child: Column(
                children: [topView, listBody],
              ))
            : listBody);
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

  void _onMorePress() {
    if (!_showWaitLoad) {
      _showWaitLoad = true;
      _uploadListView();
    }
  }
}
