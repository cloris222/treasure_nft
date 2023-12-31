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
      BuildContext context,{
        this.mainText,
        this.subText = '',
        required this.img,
        required this.isNetWorkImg,///圖片是否netWork
        this.mainTextSize,
        this.mainMargin = const EdgeInsets.only(top: 10, bottom: 10),
        this.buttonMargin = const EdgeInsets.only(top: 10),
        this.singleBottom = false,///單一按鈕
        this.needBackColor = false,///圖片與副文背景色
        this.wordImg = "",///副文圖片
        this.onLeftPress,
        this.onRightPress,
        this.imgUp = true,///圖片在主文上,
        this.isWordImgFront = false,
        this.bgWidth,
        this.subTextStyle,
        this.description,
        this.imgSize
  }):super(context, isDialogCancel: false);

  String? mainText;
  String subText;
  double? mainTextSize;
  String img;
  bool isNetWorkImg;
  bool singleBottom;
  bool needBackColor;
  String wordImg;
  EdgeInsetsGeometry mainMargin, buttonMargin;
  Function? onLeftPress;
  Function? onRightPress;
  bool imgUp;
  bool isWordImgFront;
  double? bgWidth;
  TextStyle? subTextStyle;
  String? description;
  double? imgSize;

  @override
  Widget initContent(BuildContext context, StateSetter setState, WidgetRef ref){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: UIDefine.getPixelWidth(15)),
      child: needBackColor?
          _haveBackColorStyle(context):_noBackColorStyle(context),
    );
  }


  Widget _haveBackColorStyle(BuildContext context){
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        imgUp? _buildImg(context) : _buildTitle(context),
        Container(
          width: bgWidth,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            color: AppColors.animateBackGrey,
          ),
          // margin: EdgeInsets.symmetric(horizontal: UIDefine.getPixelWidth(5),vertical: UIDefine.getPixelWidth(16)),
          padding: EdgeInsets.symmetric(horizontal: UIDefine.getPixelWidth(5),vertical: UIDefine.getPixelWidth(10)),
          child: Column(
            children: [
              imgUp? _buildTitle(context):_buildImg(context),
              description == null?Container():_buildDescription(description!),
              isWordImgFront?_buildSubWithImgFront(context):_buildSub(context),
            ],
          ),
        ),
        Container(
            margin: buttonMargin,
            child: singleBottom?
            _singlePart(context):_notSinglePart(context)
        )
      ]);
  }

  Widget _noBackColorStyle(BuildContext context){
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        imgUp? _buildImg(context) : _buildTitle(context),
        imgUp? _buildTitle(context): _buildImg(context),
        description == null?Container():_buildDescription(description!),
        isWordImgFront?_buildSubWithImgFront(context):_buildSub(context),
        Container(
            margin: buttonMargin,
            child: singleBottom?
            _singlePart(context):_notSinglePart(context)
        )
      ]);
  }

  Widget _buildSub(BuildContext context){
    return subText.isNotEmpty ?
    Padding(
      padding: EdgeInsets.symmetric(vertical: 10,horizontal: UIDefine.getPixelWidth(30)),
      child: wordImg.isNotEmpty?
      RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          text: subText, // Your text here
          style: subTextStyle?? DefaultTextStyle.of(context).style, // Use the default text style
          children: <InlineSpan>[
            WidgetSpan(
              child: Padding(
                padding: EdgeInsets.only(top: UIDefine.getPixelWidth(0)),
                child: Image.asset(wordImg,
                  height: imgSize?? UIDefine.getPixelWidth(16),width: imgSize?? UIDefine.getPixelWidth(16),),
              ),
            ),
          ],
        ),
      ):
      Text(subText,
          textAlign: TextAlign.center,
          style: subTextStyle?? AppTextStyle.getBaseStyle(
              color: AppColors.textThreeBlack,
              fontSize: UIDefine.fontSize14)),
    ): const Text('');
  }

  Widget _buildSubWithImgFront(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.only(top: UIDefine.getPixelWidth(0)),
          child: Image.asset(wordImg,
            height: imgSize?? UIDefine.getPixelWidth(16),width: imgSize?? UIDefine.getPixelWidth(16),),
        ),
        SizedBox(width: UIDefine.getPixelWidth(4),),
        Text(subText,style: subTextStyle?? DefaultTextStyle.of(context).style,)
      ],
    );
  }
  
  Widget _singlePart(BuildContext context){
    return  Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: LoginButtonWidget(
            height: UIDefine.getPixelWidth(38),
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

  Widget _buildTitle(BuildContext context){
    return Container(
      margin: mainMargin,
      child: Text(mainText ?? '${tr('success')} !',
          textAlign: TextAlign.center,
          style: AppTextStyle.getBaseStyle(
              color: AppColors.textBlack,
              fontSize: mainTextSize ?? UIDefine.fontSize16,
              fontWeight: FontWeight.w600)),
    );
  }

  Widget _buildImg(BuildContext context){
    return isNetWorkImg?
      Image.network(img,height: UIDefine.getPixelWidth(140),width: UIDefine.getPixelWidth(140),):
      createImageWidget(asset: img);
  }

  Widget _buildDescription(String text) {
    return Text(text, style: AppTextStyle.getBaseStyle(
        color: AppColors.textBlack,
        fontSize:UIDefine.fontSize12,
        fontWeight: FontWeight.w400),);
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