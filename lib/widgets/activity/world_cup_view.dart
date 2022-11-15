import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../constant/theme/app_colors.dart';
import '../../constant/theme/app_image_path.dart';
import '../../constant/theme/app_style.dart';
import '../../constant/ui_define.dart';

class WorldCupView extends StatefulWidget {
  const WorldCupView({Key? key,required this.countdownTime, required this.drawnTime, required this.poolSize}) : super(key: key);
  
  final String countdownTime;
  final String drawnTime;
  final String poolSize;

  @override
  State<WorldCupView> createState() => _WorldCupViewState();
}

class _WorldCupViewState extends State<WorldCupView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
            width: UIDefine.getWidth(),
            child: Container(
              margin: EdgeInsets.all(UIDefine.fontSize14),
              child: Image.asset(
                AppImagePath.worldCupTitleImg,
                fit: BoxFit.contain,
              ),
            )),
        _infoView(context),
        _reservationView(context)
      ],
    );
  }

  Widget _infoView(BuildContext context) {
    TextStyle titleStyle = TextStyle(
        fontSize: UIDefine.fontSize18,
        color: Colors.black,
        fontWeight: FontWeight.w500);
    TextStyle contentStyle =
        TextStyle(fontSize: UIDefine.fontSize12, color: Colors.grey);
    TextStyle blackContent = TextStyle(fontSize: UIDefine.fontSize12, color: Colors.black,fontWeight: FontWeight.w500);
    return Container(
      margin: EdgeInsets.all(UIDefine.fontSize10),
      decoration: AppStyle().styleColorBorderBackground(
          color: AppColors.bolderGrey, borderLine: 2),
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                tr("activity-title-text"),
                style: titleStyle,
              ),
              InkWell(onTap: (){},child: Image.asset(AppImagePath.questionBtn),)
            ],
          ),
          SizedBox(height: UIDefine.fontSize8,),
          Row(children: [
            Text('${tr("activity-countdown")} : ',style: contentStyle,),
            Text(widget.countdownTime,style: contentStyle,)
          ],),
          const SizedBox(height: 5,),
          Row(children: [
            Text('${tr("activity-time")} : ',style: contentStyle,),
            Text(widget.drawnTime,style: contentStyle,)
          ],),
          SizedBox(height: UIDefine.fontSize14,),
          Row(children: [
            Text('${tr("prizePool")} : ',style: blackContent,),
            Text(widget.poolSize,style: blackContent,)
          ],),
        ],
      ),
    );
  }

  Widget _reservationView(BuildContext context){
    return Container(
      width: UIDefine.getWidth(),
      child: Image.asset(AppImagePath.worldCupBackground,fit: BoxFit.fitWidth,)
    );
  }
}
