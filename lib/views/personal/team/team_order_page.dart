import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:treasure_nft_project/constant/theme/app_colors.dart';
import 'package:treasure_nft_project/constant/theme/app_image_path.dart';
import 'package:treasure_nft_project/constant/theme/app_style.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';
import 'package:treasure_nft_project/view_models/personal/team/team_member_viewmodel.dart';
import 'package:treasure_nft_project/widgets/app_bottom_navigation_bar.dart';
import 'package:treasure_nft_project/widgets/appbar/title_app_bar.dart';
import 'package:treasure_nft_project/utils/app_text_style.dart';
import 'package:treasure_nft_project/widgets/gradient_third_text.dart';
import 'package:treasure_nft_project/widgets/label/icon/base_icon_widget.dart';

import '../../../view_models/personal/team/team_order_viewmodel.dart';
import '../../../widgets/date_picker/custom_date_picker.dart';
import '../../custom_appbar_view.dart';

///MARK:團隊訂單
class TeamOrderPage extends StatefulWidget {
  const TeamOrderPage({Key? key}) : super(key: key);

  @override
  State<TeamOrderPage> createState() => _TeamOrderPageState();
}

class _TeamOrderPageState extends State<TeamOrderPage> {
  TeamMemberViewModel viewMemberModel = TeamMemberViewModel();
  late TeamOrderViewModel viewModel;
  int currentBuyOrSellIndex = 0;
  int currentTimeOrPriceIndex = 0;

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
    super.initState();
    viewModel = TeamOrderViewModel(
        onListChange: () {
          if (mounted) {
            setState(() {});
          }
        },
        topView: _buildTopView,
        padding: EdgeInsets.only(
            bottom: UIDefine.navigationBarPadding + UIDefine.getPixelWidth(5)));
    viewModel.initListView();
  }

  Widget _buildBody() {
    return Padding(
      padding: EdgeInsets.only(
          left: UIDefine.getScreenWidth(6), right: UIDefine.getScreenWidth(6)),
      child: viewModel.buildGridView(
          crossAxisCount: 2,
          childAspectRatio: 0.5,
          mainAxisSpacing: UIDefine.getScreenHeight(3),
          crossAxisSpacing: UIDefine.getScreenWidth(3)),
    );
  }

  Widget _buildTopView() {
    return Column(
      children: [
        TitleAppBar(title: tr('teamOrder')),
        // viewMemberModel.getPadding(1),

        /// 日期選擇器 & 按鈕
        CustomDatePickerWidget(
          dateCallback: (String startDate, String endDate) {
            if (startDate != startDate || endDate != endDate) {
              viewModel.startDate = startDate;
              viewModel.endDate = endDate;
              viewModel.initListView();
            }
          },
        ),

        SizedBox(height: UIDefine.getPixelHeight(10)),

        /// 輸入Bar
        _searchBar(),
        SizedBox(height: UIDefine.getPixelHeight(10)),

        SizedBox(
          ///MARK: v0.0.2 壓高度
          height: UIDefine.getPixelHeight(40),
          child: Row(children: [
            Expanded(child: _priceAndTimeDropDownBar()),
            SizedBox(width: UIDefine.getScreenWidth(2.77)),
            GestureDetector(
                onTap: () => _onPressSort(),
                child: Container(
                  alignment: Alignment.center,
                  width: UIDefine.getPixelWidth(50),
                  child: Image.asset('assets/icon/btn/btn_filter_02.png'),
                ))
          ]),
        ),

        viewMemberModel.getPadding(3),
      ],
    );
  }

  _onPressSort() {
    viewModel.sortType = (viewModel.sortType == _currenciesTimeOrPrice.first)
        ? _currenciesTimeOrPrice.last
        : _currenciesTimeOrPrice.first;
    viewModel.initListView();
  }

  Widget _searchBar() {
    return SizedBox(
      ///MARK: v0.0.2 壓高度
      height: UIDefine.getPixelHeight(40),
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
                  if (text != viewModel.nameAcct) {
                    viewModel.nameAcct = text;
                    viewModel.initListView();
                  }
                },
                style: AppTextStyle.getBaseStyle(fontSize: UIDefine.fontSize14),
                decoration: InputDecoration(
                  isDense: true,
                  contentPadding: EdgeInsets.zero,
                  prefixIcon:
                      Image.asset('assets/icon/btn/btn_discover_01_nor.png'),
                  hintText: tr("select-placeholder'"),
                  hintStyle: AppTextStyle.getBaseStyle(
                      height: 1.6, color: AppColors.textHintGrey),
                  labelStyle: AppTextStyle.getBaseStyle(color: Colors.black),
                  alignLabelWithHint: true,
                  border: viewMemberModel.setOutlineInputBorder(),
                  focusedBorder: viewMemberModel.setOutlineInputBorder(),
                  enabledBorder: viewMemberModel.setOutlineInputBorder(),
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
              viewModel.sortType =
                  _currenciesTimeOrPrice[currentTimeOrPriceIndex];
              viewModel.initListView();
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
          Spacer(),
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
              viewModel.nameAcctType =
                  _currenciesBuyOrSell[currentBuyOrSellIndex];
              viewModel.initListView();
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
          Spacer(),
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
}
