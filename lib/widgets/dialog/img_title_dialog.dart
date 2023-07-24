import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:treasure_nft_project/constant/call_back_function.dart';

import '../../constant/theme/app_colors.dart';
import '../../constant/ui_define.dart';
import '../../utils/app_text_style.dart';
import '../button/login_bolder_button_widget.dart';
import '../button/login_button_widget.dart';
import 'base_dialog.dart';

class ImgTitleDialog extends BaseDialog{
  ImgTitleDialog(
      super.context,{
        this.mainText,
        this.subText = '',
        required this.img,
        this.mainTextSize,
        this.mainMargin = const EdgeInsets.only(top: 10, bottom: 10),
        this.buttonMargin = const EdgeInsets.only(top: 10),
        this.singleBottom = false,
        this.wordImg = "",
        this.onLeftPress,
        this.onRightPress,
  });

  String? mainText;
  String subText;
  double? mainTextSize;
  String img;
  bool singleBottom;
  String wordImg;
  EdgeInsetsGeometry mainMargin, buttonMargin;
  Function? onLeftPress;
  Function? onRightPress;

  @override
  Widget initContent(BuildContext context, StateSetter setState, WidgetRef ref){
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        createImageWidget(asset: img),
        Container(
          margin: mainMargin,
          child: Text(mainText ?? '${tr('success')} !',
              textAlign: TextAlign.center,
              style: AppTextStyle.getBaseStyle(
                  color: AppColors.textBlack,
                  fontSize: mainTextSize ?? UIDefine.fontSize16,
                  fontWeight: FontWeight.w600)),
        ),
        subText.isNotEmpty ?
         Padding(
          padding: EdgeInsets.symmetric(vertical: 10,horizontal: UIDefine.getPixelWidth(30)),
            child: wordImg.isNotEmpty?
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: subText, // Your text here
                style: DefaultTextStyle.of(context).style, // Use the default text style
                children: <InlineSpan>[
                  WidgetSpan(
                    child: Padding(
                      padding: EdgeInsets.only(top: UIDefine.getPixelWidth(0)),
                      child: Image.asset(wordImg,
                        height: 16,width: 16,),
                    ),
                  ),
                ],
              ),
            ):
            Text(subText,
              textAlign: TextAlign.center,
              style: AppTextStyle.getBaseStyle(
                color: AppColors.textThreeBlack,
                fontSize: UIDefine.fontSize14)),
        ): const Text(''),
        Container(
          margin: buttonMargin,
          child: singleBottom?
              _singlePart(context):_notSinglePart(context)
        )
      ]);
  }
  
  Widget _singlePart(BuildContext context){
    return  Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        LoginButtonWidget(
          height: UIDefine.getPixelWidth(34),
          width: UIDefine.getPixelWidth(109),
          isFillWidth: false,
          btnText: tr("check"),
          onPressed: (){
            if(onRightPress != null){
              Navigator.pop(context);
              onRightPress!();
            }else{
              Navigator.pop(context);
            }
          }
        ),
      ],
    );
  }
  
  Widget _notSinglePart(BuildContext context){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: LoginBolderButtonWidget(
              fontSize: UIDefine.fontSize16,
              isFillWidth: false,
              radius: 17,
              padding:
              EdgeInsets.symmetric(horizontal: UIDefine.getPixelWidth(20)),
              btnText: tr('cancel'),
              onPressed: () {
                if(onLeftPress != null){
                  Navigator.pop(context);
                  onLeftPress!();
                }else{
                  Navigator.pop(context);
                }
              }),
        ),
        Expanded(
          child: LoginButtonWidget(
              padding: EdgeInsets.symmetric(
                  horizontal: UIDefine.getPixelWidth(26),
                  vertical: UIDefine.getPixelWidth(3)),
              isFillWidth: false,
              btnText: tr("check"),
              onPressed: (){
                if(onRightPress != null){
                  Navigator.pop(context);
                  onRightPress!();
                }else{
                  Navigator.pop(context);
                }
              }
          ),
        )
      ],
    );
  }

  @override
  Widget initTitle() {
    return Container();
  }

  @override
  Future<void> initValue() async {
    // TODO: implement initValue
  }
}