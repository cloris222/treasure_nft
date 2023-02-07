import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:format/format.dart';
import 'package:treasure_nft_project/constant/theme/app_style.dart';
import 'package:treasure_nft_project/models/http/http_setting.dart';
import 'package:treasure_nft_project/views/custom_appbar_view.dart';
import 'package:treasure_nft_project/views/personal/personal_new_sub_user_info_view.dart';
import 'package:treasure_nft_project/utils/app_text_style.dart';
import 'package:treasure_nft_project/widgets/label/background_with_land.dart';
import 'package:treasure_nft_project/widgets/text_field/login_text_widget.dart';

import '../../../constant/theme/app_colors.dart';
import '../../../constant/ui_define.dart';
import '../../../models/http/parameter/user_info_data.dart';
import '../../../view_models/personal/team/other_collect_viewmodel.dart';

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
      borderSide: BorderSide(color: AppColors.bolderGrey, width: 1),
      borderRadius: BorderRadius.all(Radius.circular(8)));
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
        topView: _buildTopView,
        padding: EdgeInsets.only(bottom: UIDefine.navigationBarPadding));
    viewModel.initState(widget.orderNo, widget.isSeller);
  }

  @override
  Widget build(BuildContext context) {
    return CustomAppbarView(
      needCover: true,
      needScrollView: false,
      onLanguageChange: () {
        if (mounted) {
          setState(() {});
        }
      },
      body: viewModel.buildGridView(
        crossAxisCount: 2,
        childAspectRatio: 1,
        mainAxisSpacing: UIDefine.getScreenHeight(2),
        crossAxisSpacing: UIDefine.getScreenWidth(2),
      ),
    );
  }

  Widget _buildTopView(UserInfoData data) {
    Widget space = SizedBox(height: UIDefine.getScreenHeight(2));
    return Column(
      children: [
        BackgroundWithLand(
          mainHeight: 200,
          bottomHeight: 80,
          onBackPress: () => viewModel.popPage(context),
          body: Container(
              alignment: Alignment.center,
              margin: EdgeInsets.all(UIDefine.getPixelWidth(10)),
              padding: EdgeInsets.all(UIDefine.getPixelWidth(10)),
              decoration: AppStyle().styleNewUserSetting(),
              child: PersonalNewSubUserInfoView(
                  shareUrl: format(HttpSetting.shareOther, {
                    "orderNo": widget.orderNo,
                    "type": widget.isSeller ? "MAKER" : "TAKER"
                  }),
                  setUserInfo: data,
                  showId: false,
                  showPoint: false,
                  enableLevel: false,
                  enablePoint: false,
                  enableModify: false)),
        ),
        space,
        _buildSearchNameView(),
        space,
        _buildSortView(),
        space,
      ],
    );
  }

  Widget _buildSearchNameView() {
    return Container(
        height: UIDefine.getPixelHeight(45),
        margin: EdgeInsets.symmetric(horizontal: UIDefine.getScreenWidth(4)),
        child: TextField(
            onChanged: (text) {
              // 撈產品資料 by text
              viewModel.nftName = text;
              viewModel.initListView();
            },
            style: AppTextStyle.getBaseStyle(fontSize: UIDefine.fontSize14),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.zero,
              prefixIcon:
                  Image.asset('assets/icon/btn/btn_discover_01_nor.png'),
              hintText: tr("select-placeholder'"),
              hintStyle: AppTextStyle.getBaseStyle(
                  height: 1.7, color: AppColors.textHintGrey),
              labelStyle: AppTextStyle.getBaseStyle(color: Colors.black),
              alignLabelWithHint: true,
              border: borderType,
              focusedBorder: borderType,
              enabledBorder: borderType,
            )));
  }

  Widget _buildSortView() {
    return Container(
        height: UIDefine.getPixelWidth(40),
        margin: EdgeInsets.symmetric(horizontal: UIDefine.getScreenWidth(4)),
        child: Row(children: [
          Expanded(child: _buildDropDownBar()),
          SizedBox(width: UIDefine.getScreenWidth(2.77)),
          GestureDetector(
              onTap: () => _onPressSort(),
              child: Container(
                alignment: Alignment.center,
                width: UIDefine.getPixelWidth(50),
                child: Image.asset('assets/icon/btn/btn_filter_02.png'),
              ))
        ]));
  }

  Widget _buildDropDownBar() {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: UIDefine.getScreenWidth(0)),
        child: DropdownButtonFormField(
          icon: Image.asset('assets/icon/btn/btn_arrow_02_down.png'),
          onChanged: (newValue) {},
          value: _currenciesTwo.first,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.fromLTRB(
                UIDefine.getScreenWidth(4.16),
                UIDefine.getScreenWidth(4.16),
                UIDefine.getScreenWidth(4.16),
                0),
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
                        style: AppTextStyle.getBaseStyle(
                            color: AppColors.searchBar)),
                  ],
                ));
          }).toList(),
        ));
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
