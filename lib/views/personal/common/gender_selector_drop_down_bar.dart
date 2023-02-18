import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:treasure_nft_project/constant/theme/app_image_path.dart';
import 'package:treasure_nft_project/models/http/parameter/user_info_data.dart';
import 'package:treasure_nft_project/utils/app_text_style.dart';
import 'package:treasure_nft_project/view_models/gobal_provider/user_info_provider.dart';
import 'package:treasure_nft_project/widgets/drop_buttom/custom_drop_button.dart';

import '../../../constant/call_back_function.dart';
import '../../../constant/theme/app_colors.dart';
import '../../../constant/theme/app_theme.dart';
import '../../../constant/ui_define.dart';

/// 性別下拉選單 男/女
class GenderSelectorDropDownBar extends ConsumerWidget {
  GenderSelectorDropDownBar({super.key, required this.getDropDownValue});

  final onGetStringFunction getDropDownValue;

  final List<String> _currencies = [
    "man",
    "woman",
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    UserInfoData userInfo = ref.watch(userInfoProvider);
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [_buildTextTitle(tr('gender')), _buildDropButton(userInfo)]);
  }

  Widget _buildDropButton(UserInfoData userInfo) {
    return CustomDropButton(
      listLength: _currencies.length,
      itemString: (int index, bool needArrow) {
        return _getCategoryText(_currencies[index]);
      },
      onChanged: (int index) {
        getDropDownValue(_currencies[index]);
      },
      initIndex: userInfo.gender == _currencies[1] ? 1 : 0,
    );
  }

  Widget _dropDownBar(UserInfoData userInfo) {
    var gender = userInfo.gender.isNotEmpty
        ? userInfo.gender
        : _currencies.first;
    getDropDownValue(gender);
    return DropdownButtonFormField(
      icon: Image.asset(AppImagePath.arrowDownGrey),
      onChanged: (newValue) {
        getDropDownValue(newValue!);
      },
      value: gender,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(UIDefine.getScreenWidth(4.16),
            UIDefine.getScreenWidth(4.16), UIDefine.getScreenWidth(4.16), 0),
        border: AppTheme.style.styleTextEditBorderBackground(
            color: AppColors.bolderGrey, radius: 8),
        focusedBorder: AppTheme.style.styleTextEditBorderBackground(
            color: AppColors.bolderGrey, radius: 8),
        enabledBorder: AppTheme.style.styleTextEditBorderBackground(
            color: AppColors.bolderGrey, radius: 8),
      ),
      items: _currencies.map((String category) {
        return DropdownMenuItem(
            value: category,
            child: Row(
              children: <Widget>[
                Text(_getCategoryText(category),
                    style:
                        AppTextStyle.getBaseStyle(color: AppColors.textBlack)),
              ],
            ));
      }).toList(),
    );
  }

  String _getCategoryText(String value) {
    // 下拉選單 多國
    switch (value) {
      case 'man':
        return tr('male');
      case 'woman':
        return tr('female');
    }
    return '';
  }

  Widget _buildTextTitle(String text) {
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 5),
        child: Text(text,
            style: AppTextStyle.getBaseStyle(
                color: Colors.black, fontSize: UIDefine.fontSize14)));
  }
}
