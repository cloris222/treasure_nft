import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:treasure_nft_project/constant/theme/app_colors.dart';
import 'package:treasure_nft_project/constant/theme/app_image_path.dart';
import 'package:treasure_nft_project/constant/theme/app_style.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';
import 'package:treasure_nft_project/view_models/base_view_model.dart';
import 'package:treasure_nft_project/views/personal/team/team_main_style.dart';
import 'package:treasure_nft_project/widgets/app_bottom_navigation_bar.dart';
import 'package:treasure_nft_project/widgets/appbar/title_app_bar.dart';
import 'package:treasure_nft_project/utils/app_text_style.dart';
import 'package:treasure_nft_project/widgets/gradient_third_text.dart';
import 'package:treasure_nft_project/widgets/label/icon/base_icon_widget.dart';
import 'package:treasure_nft_project/widgets/list_view/base_list_interface.dart';

import '../../../models/http/api/group_api.dart';
import '../../../models/http/parameter/team_order.dart';
import '../../../widgets/date_picker/custom_date_picker.dart';
import '../../../widgets/list_view/team/team_order_item.dart';
import '../../custom_appbar_view.dart';

///MARK:團隊訂單
class TeamOrderPage extends StatefulWidget {
  const TeamOrderPage({Key? key}) : super(key: key);

  @override
  State<TeamOrderPage> createState() => _TeamOrderPageState();
}

class _TeamOrderPageState extends State<TeamOrderPage> with BaseListInterface {
  TeamMainStyle style = TeamMainStyle();
  int currentBuyOrSellIndex = 0;
  int currentTimeOrPriceIndex = 0;

  String startTime = '';
  String endTime = '';

  // bool isSortDesc = true;
  String sortType = 'time';
  String nameAcct = '';
  String nameAcctType = 'ALL';

  final List<String> _currenciesBuyOrSell = [
    "ALL",
    "SELLER",
    "BUYER",
  ];

  final List<String> _currenciesTimeOrPrice = [
    "time",
    "price",
  ];

  @override
  Widget build(BuildContext context) {
    return CustomAppbarView(
      needScrollView: false,
      onLanguageChange: () {
        if (mounted) {
          setState(() {});
        }
      },
      type: AppNavigationBarType.typePersonal,
      body: _buildBody(),
    );
  }

  @override
  void initState() {
    init();
    super.initState();
  }

  Widget _buildBody() {
    bool hasItem = currentItems.isNotEmpty;
    return buildGridView(
        backgroundDecoration: hasItem
            ? AppStyle().styleColorsRadiusBackground(
                color: AppColors.defaultBackgroundSpace,
                hasBottomRight: false,
                hasBottomLef: false)
            : null,
        crossAxisCount: 2,
        padding: EdgeInsets.only(
            top: UIDefine.getPixelWidth(15),
            bottom: UIDefine.navigationBarPadding,
            left: UIDefine.getPixelWidth(15),
            right: UIDefine.getPixelWidth(15)),
        spaceWidget: SizedBox(width: UIDefine.getPixelWidth(8)));
  }

  Widget _buildTopView() {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.only(
          left: UIDefine.getPixelWidth(15), right: UIDefine.getPixelWidth(15)),
      child: Column(
        children: [
          TitleAppBar(title: tr('teamOrder')),
          // viewMemberModel.getPadding(1),

          /// 日期選擇器 & 按鈕
          CustomDatePickerWidget(dateCallback: _onDateCallback),

          SizedBox(height: UIDefine.getPixelHeight(10)),

          /// 輸入Bar
          _searchBar(),
          SizedBox(height: UIDefine.getPixelHeight(10)),

          SizedBox(
            ///MARK: v0.0.2 壓高度
            height: UIDefine.getPixelWidth(40),
            child: Row(children: [
              Expanded(child: _priceAndTimeDropDownBar()),
              SizedBox(width: UIDefine.getScreenWidth(2.77)),
              GestureDetector(
                  onTap: () => _onPressSort(),
                  child: Container(
                    alignment: Alignment.center,
                    child: BaseIconWidget(
                      imageAssetPath: 'assets/icon/btn/btn_filter_02.png',
                      size: UIDefine.getPixelWidth(50),
                    ),
                  ))
            ]),
          ),

          style.getPadding(3),
        ],
      ),
    );
  }

  _onPressSort() {
    currentTimeOrPriceIndex = (currentTimeOrPriceIndex == 0 ? 1 : 0);
    sortType = _currenciesTimeOrPrice[currentTimeOrPriceIndex];
    initListView();
  }

  Widget _searchBar() {
    return SizedBox(
      ///MARK: v0.0.2 壓高度
      height: UIDefine.getPixelWidth(40),
      child: Row(
        children: [
          SizedBox(
            width: UIDefine.getScreenWidth(30),
            child: _buyOrSellDropDownBar(),
          ),
          SizedBox(width: UIDefine.getPixelWidth(5)),
          Expanded(
            child: TextField(
                onChanged: (text) {
                  if (text != nameAcct) {
                    nameAcct = text;
                    onUpgradeListView();
                  }
                },
                style: AppTextStyle.getBaseStyle(fontSize: UIDefine.fontSize14),
                decoration: InputDecoration(
                  isDense: true,
                  isCollapsed: true,
                  contentPadding: EdgeInsets.symmetric(
                      vertical: UIDefine.getPixelWidth(10)),
                  prefixIcon:
                      Image.asset('assets/icon/btn/btn_discover_01_nor.png'),
                  hintText: tr("select-placeholder'"),
                  hintStyle: AppTextStyle.getBaseStyle(
                      height: 1.6, color: AppColors.textHintGrey),
                  labelStyle: AppTextStyle.getBaseStyle(color: Colors.black),
                  alignLabelWithHint: true,
                  border: style.setOutlineInputBorder(),
                  focusedBorder: style.setOutlineInputBorder(),
                  enabledBorder: style.setOutlineInputBorder(),
                )),
          ),
        ],
      ),
    );
  }

  Widget _priceAndTimeDropDownBar() {
    return Container(
      decoration: AppStyle().styleColorBorderBackground(
          color: AppColors.bolderGrey, radius: 8, borderLine: 1),
      padding: EdgeInsets.symmetric(
          horizontal: UIDefine.getPixelWidth(10),
          vertical: UIDefine.getPixelWidth(3)),
      child: DropdownButtonHideUnderline(
          child: DropdownButton2(
        customButton:
            _buildTimeOrPriceDropItem(currentTimeOrPriceIndex, false, true),
        isExpanded: true,
        items: List<DropdownMenuItem<int>>.generate(
            _currenciesTimeOrPrice.length, (index) {
          return DropdownMenuItem<int>(
              value: index,
              child: _buildTimeOrPriceDropItem(index, true, false));
        }),
        value: currentTimeOrPriceIndex,
        onChanged: (value) {
          if (value != null) {
            if (currentTimeOrPriceIndex != value) {
              currentTimeOrPriceIndex = value;
              sortType = _currenciesTimeOrPrice[currentTimeOrPriceIndex];
              onUpgradeListView();
            }
          }
        },
        itemPadding: const EdgeInsets.symmetric(horizontal: 8.0),
      )),
    );
  }

  Widget _buildTimeOrPriceDropItem(
      int index, bool needGradientText, bool needArrow) {
    var text = _getCategoryText(_currenciesTimeOrPrice[index]);
    return Container(
      alignment: Alignment.centerLeft,
      height: UIDefine.getPixelWidth(40),
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: [
          currentTimeOrPriceIndex == index && needGradientText
              ? GradientThirdText(
                  text,
                  maxLines: needArrow ? 1 : null,
                  size: UIDefine.fontSize14,
                )
              : Text(
                  text,
                  maxLines: needArrow ? 1 : null,
                  style: AppTextStyle.getBaseStyle(
                      fontSize: UIDefine.fontSize14,
                      color: AppColors.textSixBlack),
                ),
          const Spacer(),
          Visibility(
              visible: needArrow,
              child: BaseIconWidget(
                  imageAssetPath: AppImagePath.arrowDownGrey,
                  size: UIDefine.getPixelWidth(8)))
        ],
      ),
    );
  }

  Widget _buyOrSellDropDownBar() {
    return Container(
      decoration: AppStyle().styleColorBorderBackground(
          color: AppColors.bolderGrey, radius: 8, borderLine: 1),
      padding: EdgeInsets.symmetric(
          horizontal: UIDefine.getPixelWidth(10),
          vertical: UIDefine.getPixelWidth(3)),
      child: DropdownButtonHideUnderline(
          child: DropdownButton2(
        customButton:
            _buildBuyOrSellDropItem(currentBuyOrSellIndex, false, true),
        isExpanded: true,
        items: List<DropdownMenuItem<int>>.generate(_currenciesBuyOrSell.length,
            (index) {
          return DropdownMenuItem<int>(
              value: index, child: _buildBuyOrSellDropItem(index, true, false));
        }),
        value: currentBuyOrSellIndex,
        onChanged: (value) {
          if (value != null) {
            if (currentBuyOrSellIndex != value) {
              currentBuyOrSellIndex = value;
              nameAcctType = _currenciesBuyOrSell[currentBuyOrSellIndex];
              onUpgradeListView();
            }
          }
        },
        itemPadding: const EdgeInsets.symmetric(horizontal: 8.0),
      )),
    );
  }

  Widget _buildBuyOrSellDropItem(
      int index, bool needGradientText, bool needArrow) {
    var text = _getCategoryText(_currenciesBuyOrSell[index]);
    return Container(
      alignment: Alignment.centerLeft,
      height: UIDefine.getPixelWidth(40),
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: [
          currentBuyOrSellIndex == index && needGradientText
              ? GradientThirdText(
                  text,
                  maxLines: needArrow ? 1 : null,
                  size: UIDefine.fontSize14,
                )
              : Text(
                  text,
                  maxLines: needArrow ? 1 : null,
                  style: AppTextStyle.getBaseStyle(
                      fontSize: UIDefine.fontSize14,
                      color: AppColors.textSixBlack),
                ),
          const Spacer(),
          Visibility(
              visible: needArrow,
              child: BaseIconWidget(
                  imageAssetPath: AppImagePath.arrowDownGrey,
                  size: UIDefine.getPixelWidth(8)))
        ],
      ),
    );
  }

  String _getCategoryText(String value) {
    // 下拉選單 多國
    switch (value) {
      case 'price':
        return tr('price');
      case 'time':
        return tr('time');
      case 'ALL':
        return tr('all');
      case 'SELLER':
        return tr('seller');
      case 'BUYER':
        return tr('buyer');
    }
    return '';
  }

  @override
  Widget buildItemBuilder(int index, data) {
    return TeamOrderItemView(itemData: data);
  }

  @override
  Widget buildSeparatorBuilder(int index) {
    return SizedBox(height: UIDefine.getPixelWidth(8));
  }

  @override
  Widget? buildTopView() {
    return _buildTopView();
  }

  @override
  changeDataFromJson(json) {
    return TeamOrderData.fromJson(json);
  }

  @override
  Future<List> loadData(int page, int size) {
    return GroupAPI().getTeamOrder(
        page: page,
        size: size,
        startTime: BaseViewModel().getStartTime(startTime),
        endTime: BaseViewModel().getEndTime(endTime),
        sortBy: sortType,
        nameAcct: nameAcct,
        nameAcctType: nameAcctType);
  }

  @override
  void loadingFinish() {
    if (mounted) {
      setState(() {});
    }
  }

  void onUpgradeListView() {
    if (endTime.isEmpty && startTime.isEmpty && nameAcct.isEmpty) {
      reloadInit();
    } else {
      reloadListView();
    }
  }

  @override
  bool needSave(int page) {
    return startTime.isEmpty &&
        endTime.isEmpty &&
        nameAcct.isEmpty &&
        page == 1;
  }

  @override
  String setKey() {
    return 'teamOrder_${nameAcctType}_$sortType';
  }

  @override
  bool setUserTemporaryValue() {
    return true;
  }

  void _onDateCallback(String startDate, String endDate) {
    if (startDate.compareTo(startTime) != 0 ||
        endDate.compareTo(endTime) != 0) {
      setState(() {
        startTime = startDate;
        endTime = endDate;
        onUpgradeListView();
      });
    }
  }
}
