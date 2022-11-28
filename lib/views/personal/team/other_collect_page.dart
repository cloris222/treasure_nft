import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:treasure_nft_project/views/custom_appbar_view.dart';

import '../../../constant/theme/app_colors.dart';
import '../../../constant/ui_define.dart';
import '../../../models/http/parameter/user_info_data.dart';
import '../../../view_models/personal/team/other_collect_viewmodel.dart';
import '../personal_sub_user_info_view.dart';

///MARK: 其他買/賣家的收藏
class OtherCollectPage extends StatefulWidget {
  const OtherCollectPage(
      {Key? key, required this.orderNo, required this.isSeller})
      : super(key: key);
  final String orderNo;
  final bool isSeller;

  @override
  State<OtherCollectPage> createState() => _OtherCollectPageState();
}

class _OtherCollectPageState extends State<OtherCollectPage> {
  late OtherCollectViewModel viewModel;
  final borderType = const OutlineInputBorder(
      borderSide: BorderSide(color: AppColors.datePickerBorder, width: 3),
      borderRadius: BorderRadius.all(Radius.circular(10)));
  final List<String> _currenciesTwo = [
    "Price",
  ];

  @override
  void initState() {
    super.initState();
    viewModel = OtherCollectViewModel(
        onListChange: () {
          if (mounted) {
            setState(() {});
          }
        },
        topView: _buildTopView);
    viewModel.initState(widget.orderNo, widget.isSeller);
  }

  @override
  Widget build(BuildContext context) {
    return CustomAppbarView(
        needCover: true,
        needScrollView: false,
        title: tr('collection'),
        body: viewModel.buildGridView(
            crossAxisCount: 2,
            childAspectRatio: 0.8,
            mainAxisSpacing: UIDefine.getScreenHeight(2),
            crossAxisSpacing: UIDefine.getScreenWidth(2),
          ),
    );
  }

  Widget _buildTopView(UserInfoData data) {
    Widget space = SizedBox(height: UIDefine.getScreenHeight(2));
    return Column(
      children: [
        PersonalSubUserInfoView(
            setUserInfo: data,
            showPoint: false,
            enableLevel: false,
            enablePoint: false,
            enableModify: false),
        space,
        _buildSearchNameView(),
        space,
        _buildSortView(),
        space,
      ],
    );
  }

  Widget _buildSearchNameView() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: UIDefine.getScreenWidth(4)),
      child: TextField(
          onChanged: (text) {
            // 撈產品資料 by text
            viewModel.nftName = text;
            viewModel.initListView();
          },
          style: TextStyle(fontSize: UIDefine.fontSize14),
          decoration: InputDecoration(
            prefixIcon: Image.asset('assets/icon/btn/btn_discover_01_nor.png'),
            hintText: tr("select-placeholder'"),
            hintStyle: const TextStyle(height: 1.6, color: AppColors.searchBar),
            labelStyle: const TextStyle(color: Colors.black),
            alignLabelWithHint: true,
            border: borderType,
            focusedBorder: borderType,
            enabledBorder: borderType,
          ))
    );
  }

  Widget _buildSortView() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: UIDefine.getScreenWidth(4)),
      child: Row(children: [
        Expanded(child: _buildDropDownBar()),
        SizedBox(width: UIDefine.getScreenWidth(2.77)),
        GestureDetector(
            onTap: () => _onPressSort(),
            child: Container(
              alignment: Alignment.center,
              width: UIDefine.getScreenWidth(17.77),
              height: UIDefine.getScreenWidth(13.88),
              decoration: BoxDecoration(
                  border: Border.all(width: 3, color: AppColors.datePickerBorder),
                  borderRadius: BorderRadius.circular(10)),
              child: Image.asset('assets/icon/btn/btn_sort_01_nor.png'),
            ))
      ])
    );
  }

  Widget _buildDropDownBar() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: UIDefine.getScreenWidth(0)),
      child: DropdownButtonFormField(
        icon: Image.asset('assets/icon/btn/btn_arrow_02_down.png'),
        onChanged: (newValue) {},
        value: _currenciesTwo.first,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(UIDefine.getScreenWidth(4.16),
              UIDefine.getScreenWidth(4.16), UIDefine.getScreenWidth(4.16), 0),
          border: borderType,
          focusedBorder: borderType,
          enabledBorder: borderType,
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
      )
    );
  }

  String _getCategoryText(String value) {
    switch (value) {
      case 'Price':
        return tr('price');
    }
    return '';
  }

  void _onPressSort() {
    viewModel.isDesc = !viewModel.isDesc;
    viewModel.initListView();
  }
}
