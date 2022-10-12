import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:treasure_nft_project/widgets/dialog/base_dialog.dart';

import '../../constant/theme/app_colors.dart';
import '../../constant/theme/app_image_path.dart';

class SimpleCustomDialog extends BaseDialog{
  SimpleCustomDialog(super.context,{
    this.mainText = '',
    this.isSuccess = true,
    this.mainMargin = const EdgeInsets.only(top: 10, bottom: 10),
    this.mainTextSize = 20,
  });

  String? mainText;
  bool isSuccess;
  double mainTextSize;
  EdgeInsetsGeometry mainMargin;

  @override
  Widget initContent(BuildContext context, StateSetter setState) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        createImageWidget(asset: isSuccess
            ? AppImagePath.dialogSuccess
            : AppImagePath.dialogClose),
        Container(
          margin: mainMargin,
          child: Text(mainText ?? '${tr('Success')}!',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: AppColors.dialogBlack,
                  fontSize: mainTextSize,
                  fontWeight: FontWeight.w500)),
        ),
      ],
    );
  }

  @override
  Widget initTitle() {
    return Container();
  }

  @override
  void initValue() {
    // TODO: implement initValue
  }

}