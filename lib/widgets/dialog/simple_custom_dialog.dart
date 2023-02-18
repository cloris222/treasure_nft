import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:treasure_nft_project/widgets/dialog/base_dialog.dart';
import 'package:treasure_nft_project/utils/app_text_style.dart';

import '../../constant/theme/app_colors.dart';
import '../../constant/theme/app_image_path.dart';

class SimpleCustomDialog extends BaseDialog {
  SimpleCustomDialog(
    super.context, {
    this.mainText,
    this.isSuccess = true,
    this.mainMargin = const EdgeInsets.only(top: 10, bottom: 10),
    this.mainTextSize = 20,
  });

  String? mainText;
  bool isSuccess;
  double mainTextSize;
  EdgeInsetsGeometry mainMargin;

  @override
  Widget initContent(BuildContext context, StateSetter setState,WidgetRef ref) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        createImageWidget(
            asset: isSuccess
                ? AppImagePath.dialogSuccess
                : AppImagePath.dialogCancel),
        Container(
          margin: mainMargin,
          child: Text(mainText ?? tr('success'),
              textAlign: TextAlign.center,
              style: AppTextStyle.getBaseStyle(
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
  Future<void> initValue() async{
    // TODO: implement initValue
  }
}
