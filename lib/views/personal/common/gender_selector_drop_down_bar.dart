import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:treasure_nft_project/constant/global_data.dart';

import '../../../constant/call_back_function.dart';
import '../../../constant/theme/app_colors.dart';
import '../../../constant/theme/app_theme.dart';
import '../../../constant/ui_define.dart';

/// 性別下拉選單 男/女
class GenderSelectorDropDownBar extends StatelessWidget {
  GenderSelectorDropDownBar({super.key, required this.getDropDownValue});

  final onGetStringFunction getDropDownValue;

  final List<String> _currencies = [
    "Male",
    "FeMale",
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [_buildTextTitle(tr('gender')), _dropDownBar()]);
  }

  Widget _dropDownBar() {
    var gender = GlobalData.userInfo.gender.isNotEmpty
        ? GlobalData.userInfo.gender
        : _currencies.first;
    getDropDownValue(gender);
    return DropdownButtonFormField(
      icon: Image.asset('assets/icon/btn/btn_arrow_02_down.png'),
      onChanged: (newValue) {
        getDropDownValue(newValue!);
      },
      value: gender,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(UIDefine.getScreenWidth(4.16),
            UIDefine.getScreenWidth(4.16), UIDefine.getScreenWidth(4.16), 0),
        border: AppTheme.style.styleTextEditBorderBackground(
            color: AppColors.searchBar, radius: 10),
        focusedBorder: AppTheme.style.styleTextEditBorderBackground(
            color: AppColors.searchBar, radius: 10),
        enabledBorder: AppTheme.style.styleTextEditBorderBackground(
            color: AppColors.searchBar, radius: 10),
      ),
      items: _currencies.map((String category) {
        return DropdownMenuItem(
            value: category,
            child: Row(
              children: <Widget>[
                Text(_getCategoryText(category),
                    style: const TextStyle(color: AppColors.textBlack)),
              ],
            ));
      }).toList(),
    );
  }

  String _getCategoryText(String value) {
    // 下拉選單 多國
    switch (value) {
      case 'Male':
        return tr('male');
      case 'FeMale':
        return tr('female');
    }
    return '';
  }

  Widget _buildTextTitle(String text) {
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 5),
        child: Text(text,
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: UIDefine.fontSize14)));
  }
}
