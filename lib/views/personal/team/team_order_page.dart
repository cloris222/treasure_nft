import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:treasure_nft_project/constant/theme/app_colors.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';
import 'package:treasure_nft_project/view_models/personal/team/team_member_viewmodel.dart';
import 'package:treasure_nft_project/widgets/app_bottom_navigation_bar.dart';
import 'package:treasure_nft_project/widgets/appbar/title_app_bar.dart';
import 'package:treasure_nft_project/utils/app_text_style.dart';

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

  final List<String> _currenciesOne = [
    "ALL",
    "SELLER",
    "BUYER",
  ];

  final List<String> _currenciesTwo = [
    "time",
    "price",
  ];

  @override
  Widget build(BuildContext context) {
    return CustomAppbarView(
      needScrollView: false,
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
    viewModel.sortType = (viewModel.sortType == _currenciesTwo.first)
        ? _currenciesTwo.last
        : _currenciesTwo.first;
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
    return DropdownButtonFormField(
      icon: Image.asset('assets/icon/btn/btn_arrow_02_down.png'),
      onChanged: (newValue) {
        if (newValue != viewModel.sortType) {
          viewModel.sortType = newValue!;
          viewModel.initListView();
        }
      },
      value: viewModel.sortType,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(
            UIDefine.getScreenWidth(4.16), 0, UIDefine.getScreenWidth(4.16), 0),
        border: viewMemberModel.setOutlineInputBorder(),
        focusedBorder: viewMemberModel.setOutlineInputBorder(),
        enabledBorder: viewMemberModel.setOutlineInputBorder(),
      ),
      items: _currenciesTwo.map((String category) {
        return DropdownMenuItem(
            value: category,
            child: Row(
              children: <Widget>[
                Text(_getCategoryText(category),
                    style: AppTextStyle.getBaseStyle(
                        color: AppColors.textHintGrey,
                        fontSize: UIDefine.fontSize14)),
              ],
            ));
      }).toList(),
    );
  }

  Widget _buyOrSellDropDownBar() {
    return DropdownButtonFormField(
      icon: Image.asset('assets/icon/btn/btn_arrow_02_down.png'),
      onChanged: (newValue) {
        if (newValue != viewModel.nameAcctType) {
          viewModel.nameAcctType = newValue!;
          viewModel.initListView();
        }
      },
      value: _currenciesOne.first,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(
            UIDefine.getScreenWidth(4.16), 0, UIDefine.getScreenWidth(4.16), 0),
        border: viewMemberModel.setOutlineInputBorder(),
        focusedBorder: viewMemberModel.setOutlineInputBorder(),
        enabledBorder: viewMemberModel.setOutlineInputBorder(),
      ),
      items: _currenciesOne.map((String category) {
        return DropdownMenuItem(
            value: category,
            child: Row(
              children: <Widget>[
                Text(_getCategoryText(category),
                    style: AppTextStyle.getBaseStyle(
                        color: AppColors.textHintGrey,
                        fontSize: UIDefine.fontSize14)),
              ],
            ));
      }).toList(),
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
