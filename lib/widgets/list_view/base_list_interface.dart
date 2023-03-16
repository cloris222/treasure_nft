import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../constant/global_data.dart';
import '../../constant/theme/app_colors.dart';
import '../../constant/ui_define.dart';
import '../../utils/app_shared_Preferences.dart';
import '../../utils/app_text_style.dart';

abstract class BaseListInterface {
  ///MARK:判斷是否要顯示讀取
  bool _showWaitLoad = false;

  ///MARK:目前頁數
  int _currentPage = 1;

  ///MARK: 目前的清單
  List<dynamic> currentItems = [];

  ///MARK: 暫存的下一筆資料
  List<dynamic> nextItems = [];

  ///MARK:移除項目清單
  List<int> removeItems = [];

  ///---- 實體化的function

  void loadingFinish();

  ///MARK: 轉型別，需轉成此清單的類型
  dynamic changeDataFromJson(json);

  ///MARK: 讀取資料
  Future<List<dynamic>> loadData(int page, int size);

  ///MARK: 判斷是否要存進sharePref
  bool needSave(int page);

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

  ///MARK: 判斷是否要讀取SharedPreferences的內容
  bool needReadSharedPreferencesValue() {
    return true;
  }

  ///-----暫存相關-----
  /// 定義此SharedPreferencesKey
  String setKey();

  /// 定義此provider 是否為user相關資料
  /// 如果為true，則會在使用者登出後自動清除
  bool setUserTemporaryValue();

  ///-----初始化-----

  /// 設定初始值
  Future<void> initValue() async {
    currentItems = [];
  }

  /// 讀取 SharedPreferencesKey 內容並轉成對應值
  Future<void> readSharedPreferencesValue() async {
    if (needReadSharedPreferencesValue()) {
      var json = await AppSharedPreferences.getJson(getSharedPreferencesKey());
      if (json != null) {
        List<dynamic> list =
            List<dynamic>.from(json.map((x) => changeDataFromJson(x)));
        currentItems = [...list];
      }
    } else {
      currentItems = [];
    }
  }

  /// 將 內容 存入 SharedPreferencesKey
  /// list view的狀態下 最多只會存10筆
  Future<void> setSharedPreferencesValue({int? maxSize}) async {
    if (maxSize != null) {
      List<dynamic> preList = [];
      for (int i = 0; i < currentItems.length && i < maxSize; i++) {
        preList.add(currentItems[i].toJson());
      }
      await AppSharedPreferences.setJson(getSharedPreferencesKey(), preList);
    } else {
      await AppSharedPreferences.setJson(getSharedPreferencesKey(),
          List<dynamic>.from(currentItems.map((x) => x.toJson())));
    }
  }

  String getSharedPreferencesKey() {
    return '${setKey()}${setUserTemporaryValue() ? "_tmp" : ""}';
  }

  Future<void> init() async {
    await Future.delayed(const Duration(milliseconds: 300));
    if (await AppSharedPreferences.checkKey(getSharedPreferencesKey())) {
      await readSharedPreferencesValue();
    } else {
      await initValue();
    }
    loadingFinish();
    initListView();
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

  Future<void> reloadInit() async {
    _clearListView();
    init();
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
      var list = await loadData(_currentPage, maxLoad());
      currentItems.clear();
      currentItems.addAll(list);

      ///MARK:代表需要讀下一筆
      if (list.length >= maxLoad()) {
        nextItems = await loadData(_currentPage + 1, maxLoad());
      }

      ///MARK:代表已讀完不需要下一筆
      else {
        nextItems = [];
      }
    } else {
      currentItems.addAll(nextItems);

      ///MARK:代表需要讀下一筆
      if (nextItems.length >= maxLoad()) {
        nextItems = await loadData(_currentPage + 1, maxLoad());
      }

      ///MARK:代表已讀完不需要下一筆
      else {
        nextItems = [];
      }
    }
    if (needSave(_currentPage)) {
      setSharedPreferencesValue();
    }
  }

  void _clearListView() {
    _currentPage = 1;
    nextItems.clear();
    removeItems.clear();
    currentItems.clear();
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
    int length = currentItems.length;
    Widget? topView = buildTopView();
    bool hasTopView = topView != null;

    if (_showWaitLoad || (!isAutoReloadMore() && nextItems.isNotEmpty)) {
      length += 1;
    }

    return _buildListListener(
        topView: topView,
        listBody: ListView.separated(
            padding: padding ??
                EdgeInsets.only(
                    bottom: UIDefine.navigationBarPadding,
                    right: UIDefine.getScreenWidth(5),
                    left: UIDefine.getScreenWidth(5)),
            itemCount: length,
            shrinkWrap: hasTopView ? true : shrinkWrap,
            physics:
                hasTopView ? const NeverScrollableScrollPhysics() : physics,
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              int itemIndex = index;
              if (itemIndex != currentItems.length) {
                return Visibility(
                    visible: !removeItems.contains(itemIndex),
                    child:
                        buildItemBuilder(itemIndex, currentItems[itemIndex]));
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

  Widget buildGridView(
      {required int crossAxisCount,
      Widget spaceWidget = const SizedBox(),
      bool shrinkWrap = true,
      ScrollPhysics? physics,
      EdgeInsetsGeometry? padding,
      Decoration? backgroundDecoration}) {
    int rowLength =
        currentItems.isNotEmpty ? currentItems.length ~/ crossAxisCount : 0;

    ///MARK: 有多一行就++
    if (rowLength > 0) {
      rowLength += (currentItems.length % crossAxisCount > 0) ? 1 : 0;
    }
    Widget? topView = buildTopView();
    bool hasTopView = topView != null;
    int finalLength;
    if (_showWaitLoad || (!isAutoReloadMore() && nextItems.isNotEmpty)) {
      finalLength = rowLength + 1;
    } else {
      finalLength = rowLength;
    }

    return _buildListListener(
        topView: topView,
        listBody: Container(
          decoration: backgroundDecoration,
          child: ListView.separated(
              padding: padding ??
                  EdgeInsets.only(
                      bottom: UIDefine.navigationBarPadding,
                      right: UIDefine.getScreenWidth(5),
                      left: UIDefine.getScreenWidth(5)),
              itemCount: finalLength,
              shrinkWrap: hasTopView ? true : shrinkWrap,
              physics:
                  hasTopView ? const NeverScrollableScrollPhysics() : physics,
              scrollDirection: Axis.vertical,
              itemBuilder: (context, rowIndex) {
                if (rowIndex != rowLength) {
                  List<Widget> row = [];
                  for (int i = 0; i < crossAxisCount; i++) {
                    int itemIndex = rowIndex * crossAxisCount + i;
                    if (itemIndex >= currentItems.length) {
                      row.add(const Expanded(child: SizedBox()));
                    } else {
                      row.add(Expanded(
                        child: Container(
                          alignment: Alignment.center,
                          child: Visibility(
                              visible: !removeItems.contains(itemIndex),
                              child: buildItemBuilder(
                                  itemIndex, currentItems[itemIndex])),
                        ),
                      ));
                    }
                    row.add(spaceWidget);
                  }
                  row.removeLast();

                  return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: row);
                } else {
                  if (!_showWaitLoad &&
                      (!isAutoReloadMore() && nextItems.isNotEmpty)) {
                    return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [_buildReadMore()]);
                  }
                  return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [_buildLoading()]);
                }
              },
              separatorBuilder: (BuildContext context, int index) =>
                  buildSeparatorBuilder(index)),
        ));
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

  Widget _buildLoading() {
    return Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.symmetric(vertical: 10),
        child: LoadingAnimationWidget.hexagonDots(
            color: AppColors.textBlack, size: 30));
  }

  Widget _buildReadMore() {
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
