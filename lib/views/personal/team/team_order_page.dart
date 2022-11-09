import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:treasure_nft_project/constant/theme/app_colors.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';
import 'package:treasure_nft_project/view_models/personal/team/team_member_viewmodel.dart';
import 'package:treasure_nft_project/widgets/app_bottom_navigation_bar.dart';
import 'package:treasure_nft_project/widgets/date_picker/date_picker.dart';

import '../../../view_models/personal/team/team_order_viewmodel.dart';
import '../../../widgets/date_picker/custom_date_picker.dart';
import '../../custom_appbar_view.dart';

///MARK:團隊訂單
class TeamOrderPage extends StatelessWidget {
  const TeamOrderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomAppbarView(
      needScrollView: false,
      title: tr("teamOrder"),
      type: AppNavigationBarType.typePersonal,
      body: const Body(),
    );
  }
}

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<StatefulWidget> createState() {
    return BodyState();
  }
}

class BodyState extends State<Body> {
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
  void initState() {
    super.initState();
    viewModel = TeamOrderViewModel(
        onListChange: () {
          if (mounted) {
            setState(() {});
          }
        },
        topView: _buildTopView);
    viewModel.initListView();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          left: UIDefine.getScreenWidth(6), right: UIDefine.getScreenWidth(6)),
      child: viewModel.buildGridView(
          crossAxisCount: 2,
          childAspectRatio: 0.4,
          mainAxisSpacing: UIDefine.getScreenHeight(3),
          crossAxisSpacing: UIDefine.getScreenWidth(3)),
    );
  }

  Widget _buildTopView() {
    return Column(
      children: [
        // viewMemberModel.getPadding(1),

        /// 日期選擇器 & 按鈕
        CustomDatePickerWidget(
          dateCallback: (String startDate, String endDate) {
            viewModel.startDate = startDate;
            viewModel.endDate = endDate;
            viewModel.initListView();
          },
        ),
        viewMemberModel.getPadding(3),

        /// 輸入Bar
        _searchBar(),
        viewMemberModel.getPadding(2),

        Row(children: [
          Expanded(child: _priceAndTimeDropDownBar()),
          SizedBox(width: UIDefine.getScreenWidth(2.77)),
          GestureDetector(
              onTap: () => _onPressSort(),
              child: Container(
                alignment: Alignment.center,
                width: UIDefine.getScreenWidth(17.77),
                height: UIDefine.getScreenWidth(13.88),
                decoration: viewMemberModel.setBoxDecoration(),
                child: Image.asset('assets/icon/btn/btn_sort_01_nor.png'),
              ))
        ]),

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
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: UIDefine.getScreenWidth(30),
          child: _buyOrSellDropDownBar(),
        ),
        SizedBox(
            width: UIDefine.getScreenWidth(55),
            child: TextField(
                onChanged: (text) {
                  if (text != viewModel.nameAcct) {
                    viewModel.nameAcct = text;
                    viewModel.initListView();
                  }
                },
                style: TextStyle(fontSize: UIDefine.fontSize14),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(
                      0, UIDefine.getScreenWidth(4.16), 0, 0),
                  prefixIcon:
                      Image.asset('assets/icon/btn/btn_discover_01_nor.png'),
                  hintText: tr("select-placeholder'"),
                  hintStyle:
                      const TextStyle(height: 1.6, color: AppColors.searchBar),
                  labelStyle: const TextStyle(color: Colors.black),
                  alignLabelWithHint: true,
                  border: viewMemberModel.setOutlineInputBorder(),
                  focusedBorder: viewMemberModel.setOutlineInputBorder(),
                  enabledBorder: viewMemberModel.setOutlineInputBorder(),
                ))),
      ],
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
        contentPadding: EdgeInsets.fromLTRB(UIDefine.getScreenWidth(4.16),
            UIDefine.getScreenWidth(4.16), UIDefine.getScreenWidth(4.16), 0),
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
                    style: const TextStyle(color: AppColors.searchBar)),
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
        contentPadding: EdgeInsets.fromLTRB(UIDefine.getScreenWidth(4.16),
            UIDefine.getScreenWidth(4.16), UIDefine.getScreenWidth(4.16), 0),
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
                    style: const TextStyle(color: AppColors.searchBar)),
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
