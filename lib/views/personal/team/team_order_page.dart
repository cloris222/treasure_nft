import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:treasure_nft_project/constant/enum/team_enum.dart';
import 'package:treasure_nft_project/constant/theme/app_colors.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';
import 'package:treasure_nft_project/models/http/parameter/team_order.dart';
import 'package:treasure_nft_project/view_models/personal/team/team_member_viewmodel.dart';
import 'package:treasure_nft_project/widgets/app_bottom_navigation_bar.dart';
import 'package:treasure_nft_project/widgets/date_picker/date_picker.dart';
import 'package:treasure_nft_project/widgets/list_view/team/team_order_listview.dart';

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
  TeamMemberViewModel viewModel = TeamMemberViewModel();

  String startDate = 'Select date';
  String endDate = '';

  Search buttonType = Search.All;
  List<TeamOrderData> list = [];

  bool bMore = false;
  String searchValue = '';
  String dropDownValueOne = 'All';
  String dropDownValueTwo = 'Price';
  String sortByOne = 'all';
  String sortByTwo = 'price';
  bool bSort = true;


  @override
  void initState() {
    super.initState();
    viewModel.getTeamOrder('', '', '', '', '').then((value) => {
      list = value,
      setState(() {}),
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(

        child:Padding(
            padding: EdgeInsets.only(
                left:UIDefine.getScreenWidth(6),
                right: UIDefine.getScreenWidth(6)),

            child:Column(children: [
              viewModel.getPadding(2),

              /// 日期選擇器 & 按鈕
              DatePickerWidget(
                dateCallback: (String startDate, String endDate) async {
                  await viewModel.getTeamOrder(startDate, endDate, '', '', ''
                  ).then((value)  => {list = value});
                  setState(() {});
                },
              ),

              /// 輸入Bar
              _searchBar(),
              viewModel.getPadding(2),

              Row(children: [
                Expanded(child: _priceAndTimeDropDownBar()),
                SizedBox(width: UIDefine.getScreenWidth(2.77)),
                GestureDetector(
                    onTap: () => _onPressSort(),
                    child: Container(
                      alignment: Alignment.center,
                      width: UIDefine.getScreenWidth(17.77),
                      height: UIDefine.getScreenWidth(13.88),
                      decoration: viewModel.setBoxDecoration(),
                      child: Image.asset('assets/icon/btn/btn_sort_01_nor.png'),
                    ))
              ]),

              viewModel.getPadding(3),

              /// 訂單列表
              SizedBox(
                height: UIDefine.getScreenHeight(300),
                child:TeamOrderListView(list:list),
              ),

            ],)));
  }


  _onPressSort() {
    // 撈產品資料 by sort
    bSort = !bSort;
    _getNewProductListResponse();
  }

  _getNewProductListResponse() {
    if (bSort) {
      if (dropDownValueTwo == 'Price') {
        sortByTwo = 'price';
      } else {
        sortByTwo = 'time';
      }
    } else {
      if (dropDownValueTwo == 'Price') {
        sortByTwo = 'priceAsc';
      } else {
        sortByTwo = 'timeAsc';
      }
    }

    if(dropDownValueOne == 'All') {
      sortByOne = 'ALL';
    }else if (dropDownValueOne == 'Seller') {
      sortByOne = 'SELLER';
    }else {
      sortByOne = 'BUYER';
    }

    list.clear();
    _updateView();
  }

  _updateView() {
    viewModel.getTeamOrder(startDate, endDate, sortByTwo, searchValue, sortByOne
    ).then((value) async => {
      list = value,
      setState(() {}),
    });
  }

  Widget _searchBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
      SizedBox(
        width: UIDefine.getScreenWidth(30),
        child:_buyOrSellDropDownBar(),
      ),

      SizedBox(
          width: UIDefine.getScreenWidth(55),
          child:TextField(onChanged: (text) {
            // 撈產品資料 by text
            searchValue = text;
            _getNewProductListResponse();
          },
              style: TextStyle(fontSize: UIDefine.fontSize14),
              decoration: InputDecoration(
                contentPadding:
                EdgeInsets.fromLTRB(0, UIDefine.getScreenWidth(4.16), 0, 0),
                prefixIcon: Image.asset('assets/icon/btn/btn_discover_01_nor.png'),
                hintText: tr("select-placeholder'"),
                hintStyle: const TextStyle(height: 1.6, color: AppColors.searchBar),
                labelStyle: const TextStyle(color: Colors.black),
                alignLabelWithHint: true,
                border: viewModel.setOutlineInputBorder(),
                focusedBorder: viewModel.setOutlineInputBorder(),
                enabledBorder:  viewModel.setOutlineInputBorder(),
              ))),
    ],);
  }



  Widget _priceAndTimeDropDownBar() {
    return DropdownButtonFormField(
      icon: Image.asset('assets/icon/btn/btn_arrow_02_down.png'),
      onChanged: (newValue) {
        // 將選擇的暫存在全域
        dropDownValueTwo = newValue!;
        _getNewProductListResponse();
      },
      value: _currenciesTwo.first,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(UIDefine.getScreenWidth(4.16),
            UIDefine.getScreenWidth(4.16), UIDefine.getScreenWidth(4.16), 0),
        border: viewModel.setOutlineInputBorder(),
        focusedBorder:  viewModel.setOutlineInputBorder(),
        enabledBorder:  viewModel.setOutlineInputBorder(),
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
        // 將選擇的暫存在全域
        dropDownValueOne = newValue!;
        _getNewProductListResponse();
      },
      value: _currenciesOne.first,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(UIDefine.getScreenWidth(4.16),
            UIDefine.getScreenWidth(4.16), UIDefine.getScreenWidth(4.16), 0),
        border: viewModel.setOutlineInputBorder(),
        focusedBorder: viewModel.setOutlineInputBorder(),
        enabledBorder: viewModel.setOutlineInputBorder(),
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

  String _getCategoryText(String value) { // 下拉選單 多國
    switch(value) {
      case 'Price':
        return tr('price');
      case 'Time':
        return tr('time');
      case 'All':
        return tr('all');
      case 'Seller':
        return tr('seller');
      case 'Buyer':
        return tr('buyer');
    }
    return '';
  }

  final List<String> _currenciesOne = [
    "All",
    "Seller",
    "Buyer",
  ];

  final List<String> _currenciesTwo = [
    "Price",
    "Time",
  ];

}
