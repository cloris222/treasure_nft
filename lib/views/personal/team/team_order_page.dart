import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:treasure_nft_project/constant/enum/team_enum.dart';
import 'package:treasure_nft_project/constant/theme/app_colors.dart';
import 'package:treasure_nft_project/constant/theme/app_image_path.dart';
import 'package:treasure_nft_project/constant/theme/app_theme.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';
import 'package:treasure_nft_project/models/http/parameter/team_order.dart';
import 'package:treasure_nft_project/view_models/base_view_model.dart';
import 'package:treasure_nft_project/view_models/personal/team/team_member_viewmodel.dart';
import 'package:treasure_nft_project/views/home/widget/search_action_button.dart';
import 'package:treasure_nft_project/widgets/app_bottom_navigation_bar.dart';
import 'package:treasure_nft_project/widgets/appbar/custom_app_bar.dart';
import 'package:treasure_nft_project/widgets/date_picker/date_picker.dart';
import 'package:treasure_nft_project/widgets/list_view/team/team_order_listview.dart';


///MARK:團隊訂單
class TeamOrderPage extends StatelessWidget {
  const TeamOrderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.getCommonAppBar(() {
        BaseViewModel().popPage(context);
      }, tr('teamOrder')),
      body: const Body(),
      bottomNavigationBar:
      const AppBottomNavigationBar(initType: AppNavigationBarType.typePersonal),
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
  String dropDownValue = 'Price';
  String sortBy = 'price';
  bool bSort = true;


  @override
  void initState() {
    super.initState();
    viewModel.getTeamOrder('', '', '', '').then((value) => {
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

              DatePickerWidget(
                dateCallback: (String startDate, String endDate) async {
                  await viewModel.getTeamOrder(startDate, endDate, '', ''
                  ).then((value)  => {list = value});
                  setState(() {});
                },
              ),

              // /// 日期選擇器
              // GestureDetector(
              //     onTap: () async{
              //       await _showDatePicker(context);
              //       setState(() {});
              //     },
              //     child: Container(
              //       width: UIDefine.getWidth(),
              //       height: UIDefine.getScreenHeight(10),
              //       decoration: viewModel.setBoxDecoration(),
              //
              //
              //       child:Row(children: [
              //         viewModel.getPadding(1),
              //         Image.asset(AppImagePath.dateIcon),
              //         viewModel.getPadding(1),
              //
              //         Text(startDate,
              //           style: const TextStyle(color: AppColors.textGrey),
              //         ),
              //
              //         viewModel.getPadding(1),
              //         Visibility(
              //             visible: endDate != '',
              //             child: const Text('～',
              //               style: TextStyle(color: AppColors.textGrey),
              //             )),
              //         viewModel.getPadding(1),
              //
              //         Text(endDate,
              //           style: const TextStyle(color: AppColors.textGrey),
              //         )
              //
              //       ],),
              //     )),
              //
              // viewModel.getPadding(3),
              //
              // /// 快速搜尋按鈕列
              // SizedBox(
              //     height: UIDefine.getScreenHeight(10),
              //     child:SingleChildScrollView(
              //         scrollDirection:Axis.horizontal,
              //         child:Row(
              //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //           children: [
              //
              //             SearchActionButton(
              //               isSelect: buttonType == Search.All,
              //               btnText: '  ${tr('all')}  ',
              //               onPressed: () async{
              //                 buttonType = Search.All;
              //                 await viewModel.getTeamOrder(
              //                     '', '', '', ''
              //                 ).then((value)  => {
              //                   list = value,
              //                 });
              //                 startDate = ''; endDate = '';
              //                 setState(() {});
              //               },
              //             ),
              //
              //             viewModel.getPadding(2),
              //
              //             SearchActionButton(
              //               isSelect: buttonType == Search.Today,
              //               btnText: tr('today'),
              //               onPressed: () async{
              //                 buttonType = Search.Today;
              //
              //                 startDate = viewModel.dateTimeFormat(DateTime.now());
              //                 endDate = viewModel.dateTimeFormat(DateTime.now());
              //                 await viewModel.getTeamOrder(
              //                     startDate, endDate, sortBy, searchValue
              //                 ).then((value)  => {
              //                   list = value,
              //                 });
              //                 setState(() {});
              //               },
              //             ),
              //
              //             viewModel.getPadding(2),
              //
              //             SearchActionButton(
              //               isSelect: buttonType == Search.Yesterday,
              //               btnText: tr('yesterday'),
              //               onPressed: () async{
              //                 buttonType = Search.Yesterday;
              //
              //                 startDate = viewModel.getDays(1);
              //                 endDate =viewModel.getDays(1);
              //                 await viewModel.getTeamOrder(
              //                     startDate, endDate, sortBy, searchValue
              //                 ).then((value)  => {
              //                   list = value,
              //                 });
              //                 setState(() {});
              //               },
              //             ),
              //
              //             viewModel.getPadding(2),
              //
              //             SearchActionButton(
              //               isSelect: buttonType == Search.SevenDays,
              //               btnText: tr('day7'),
              //               onPressed: () async{
              //                 buttonType = Search.SevenDays;
              //
              //                 startDate =  viewModel.getDays(7);
              //                 endDate = viewModel.dateTimeFormat(DateTime.now());
              //                 await viewModel.getTeamOrder(
              //                     startDate, endDate, sortBy, searchValue
              //                 ).then((value)  => {
              //                   list = value,
              //                 });
              //                 setState(() {});
              //               },
              //             ),
              //
              //             viewModel.getPadding(2),
              //
              //             SearchActionButton(
              //               isSelect: buttonType == Search.ThirtyDays,
              //               btnText: tr('day30'),
              //               onPressed: () async{
              //                 buttonType = Search.ThirtyDays;
              //
              //                 startDate =  viewModel.getDays(30);
              //                 endDate = viewModel.dateTimeFormat(DateTime.now());
              //                 await viewModel.getTeamOrder(
              //                     startDate, endDate, sortBy, searchValue
              //                 ).then((value)  => {
              //                   list = value,
              //                 });
              //                 setState(() {});
              //               },
              //             ),
              //           ],))),

              /// 輸入Bar
              _searchBar(),
              viewModel.getPadding(2),

              Row(children: [
                Expanded(child: _dropDownBar()),
                SizedBox(width: UIDefine.getScreenWidth(2.77)),
                GestureDetector(
                    onTap: () => _onPressSort(),
                    child: Container(
                      alignment: Alignment.center,
                      width: UIDefine.getScreenWidth(17.77),
                      height: UIDefine.getScreenWidth(13.88),
                      decoration: viewModel.setBoxDecoration(),
                      child: Image.asset(
                          'assets/icon/btn/btn_sort_01_nor.png'),
                    ))
              ],
              ),

              viewModel.getPadding(2),

              TeamOrderListView(list:list),

              SizedBox(
                height: UIDefine.getScreenHeight(20),
              ),

            ],)));
  }

  Future<void> _showDatePicker(BuildContext context) async{
    await showDateRangePicker(
        context:context,
        firstDate: DateTime(2022, 10),
        lastDate: DateTime.now()).then((value) => {
      startDate = viewModel.dateTimeFormat(value?.start),
      endDate = viewModel.dateTimeFormat(value?.end),
    }).then((value) async => {
      await viewModel.getTeamOrder(startDate, endDate, sortBy, searchValue).then((value) => {
        list = value,
        setState(() {}),
      }),
    });
    debugPrint('startDate: $startDate');
  }

  _onPressSort() {
    // 撈產品資料 by sort
    bSort = !bSort;
    _getNewProductListResponse();
  }

  _getNewProductListResponse() {
    if (bSort) {
      if (dropDownValue == 'Price') {
        sortBy = 'price';
      } else {
        sortBy = 'time';
      }
    } else {
      if (dropDownValue == 'Price') {
        sortBy = 'priceAsc';
      } else {
        sortBy = 'timeAsc';
      }
    }
    list.clear();
    _updateView();
  }

  _updateView() {
    viewModel.getTeamOrder(startDate, endDate, sortBy, searchValue)
        .then((value) async => {
      list = value,
      setState(() {}),
    });
  }

  Widget _searchBar() {
    return TextField(
        onChanged: (text) {
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
        ));
  }

  final List<String> _currencies = [
    "Price",
    "Time",
  ];

  Widget _dropDownBar() {
    return DropdownButtonFormField(
      icon: Image.asset('assets/icon/btn/btn_arrow_02_down.png'),
      onChanged: (newValue) {
        // 將選擇的暫存在全域
        dropDownValue = newValue!;
        _getNewProductListResponse();
      },
      value: _currencies.first,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(UIDefine.getScreenWidth(4.16),
            UIDefine.getScreenWidth(4.16), UIDefine.getScreenWidth(4.16), 0),
        border: viewModel.setOutlineInputBorder(),
        focusedBorder:  viewModel.setOutlineInputBorder(),
        enabledBorder:  viewModel.setOutlineInputBorder(),
      ),
      items: _currencies.map((String category) {
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
    }
    return '';
  }

}
