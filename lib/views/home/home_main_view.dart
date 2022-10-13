import 'package:flutter/material.dart';
import 'package:treasure_nft_project/constant/theme/app_colors.dart';
import 'package:treasure_nft_project/constant/theme/app_image_path.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';
import 'package:treasure_nft_project/view_models/home/home_main_viewmodel.dart';
import 'package:treasure_nft_project/widgets/button/action_button_widget.dart';
import 'package:treasure_nft_project/widgets/domain_bar.dart';
import 'package:treasure_nft_project/widgets/gradient_text.dart';
import 'package:treasure_nft_project/widgets/list_view/home/carousel_listview.dart';


class HomeMainView extends StatelessWidget {
  const HomeMainView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Flexible(child:
      SingleChildScrollView(
        child:SizedBox(
          child:Column(children: [
            Stack(children: [

              Transform.scale(
                scaleY: 0.9,
                child:  Image.asset(AppImagePath.firstBackground),
              ),


              Column(children: [
                const DomainBar(),

                Padding(
                  /// 上半部總padding
                  padding: EdgeInsets.all(UIDefine.getScreenWidth(6)),
                  child:Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                          padding: EdgeInsets.all(UIDefine.getScreenWidth(3))
                      ),

                      SizedBox(
                        height: UIDefine.getScreenHeight(7),
                        child: Row(
                          children: [
                            Text('Earn profit with',
                              style: TextStyle(
                                fontSize: UIDefine.fontSize24,
                                fontWeight: FontWeight.bold,
                                color: AppColors.textBlack,
                              ),
                            ),

                            GradientText(' Treasure ',
                              size:UIDefine.fontSize24,
                              weight: FontWeight.bold,
                            ),
                          ],),
                      ),

                      Padding(
                          padding: EdgeInsets.all(UIDefine.getScreenWidth(3))
                      ),

                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Buy and sell NFTs daily and earn profit',
                            style: TextStyle(
                              fontSize: UIDefine.fontSize14,
                              color: AppColors.textGrey,
                            ),
                          ),

                          Text('Invite friends and daily earn extra income',
                            style: TextStyle(
                              fontSize: UIDefine.fontSize12,
                              color: AppColors.textGrey,
                            ),
                          ),
                        ],),

                      Padding(
                          padding: EdgeInsets.all(UIDefine.getScreenWidth(5))
                      ),

                      ActionButtonWidget(
                        setHeight: UIDefine.getScreenHeight(8),
                        btnText: 'Trade',
                        onPressed: () {},
                      ),

                      Padding(
                          padding: EdgeInsets.all(UIDefine.getScreenWidth(5))
                      ),

                      USDT_Info(),

                      Padding(
                          padding: EdgeInsets.all(UIDefine.getScreenWidth(4))
                      ),

                      /// 輪播圖
                      SizedBox(
                        height: UIDefine.getScreenHeight(57),
                        child:const CarouselListView(),
                      ),

                    ],),
                ),
              ],),
            ]),

            Padding(
              /// 下半部總padding
              padding: EdgeInsets.all(UIDefine.getScreenWidth(4)),
              child:
                  Column(children: [
                    Container(
                        child: hotCollection()
                    ),



                  ],)
            ),
          ]),
        ),
      ),
      ),
    );
  }
}


Widget USDT_Info() {
  return Row(
    children: [
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('VOL (USDT)',
            style: TextStyle(
                fontSize: UIDefine.fontSize14,
                color: AppColors.textBlack,
                fontWeight: FontWeight.w300
            ),
          ),

          Padding(
              padding: EdgeInsets.all(UIDefine.getScreenWidth(1))
          ),

          Text('12,373.6',
            style: TextStyle(
              fontSize: UIDefine.fontSize20,
              color: AppColors.textBlack,
            ),
          ),

          Padding(
              padding: EdgeInsets.all(UIDefine.getScreenWidth(1))
          ),

          Text('Last 24h',
            style: TextStyle(
              fontSize: UIDefine.fontSize12,
              color: AppColors.textGrey,
            ),
          ),
        ],),

      Padding(
          padding: EdgeInsets.all(UIDefine.getScreenWidth(1))
      ),

      //分隔線
      SizedBox(
          height: UIDefine.getScreenHeight(10),
          child:const VerticalDivider(
            width: 3,
            color: AppColors.dialogBlack,
            thickness: 0.5,
          )),

      Padding(
          padding: EdgeInsets.all(UIDefine.getScreenWidth(1))
      ),


      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('FEE (USDT)',
            style: TextStyle(
                fontSize: UIDefine.fontSize14,
                color: AppColors.textBlack,
                fontWeight: FontWeight.w300
            ),
          ),

          Padding(
              padding: EdgeInsets.all(UIDefine.getScreenWidth(1))
          ),

          Text('1.54',
            style: TextStyle(
              fontSize: UIDefine.fontSize20,
              color: AppColors.textBlack,
            ),
          ),

          Padding(
              padding: EdgeInsets.all(UIDefine.getScreenWidth(1))
          ),

          Text('updated 3 minutes ago',
            style: TextStyle(
              fontSize: UIDefine.fontSize12,
              color: AppColors.textGrey,
            ),
          ),
        ],),

      Padding(
          padding: EdgeInsets.all(UIDefine.getScreenWidth(1))
      ),

      //分隔線
      SizedBox(
          height: UIDefine.getScreenHeight(10),
          child:const VerticalDivider(
            width: 3,
            color: AppColors.dialogBlack,
            thickness: 0.5,
          )),

      Padding(
          padding: EdgeInsets.all(UIDefine.getScreenWidth(1))
      ),


      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('NFTs(USDT)',
            style: TextStyle(
                fontSize: UIDefine.fontSize14,
                color: AppColors.textBlack,
                fontWeight: FontWeight.w300
            ),
          ),

          Padding(
              padding: EdgeInsets.all(UIDefine.getScreenWidth(1))
          ),

          GradientText(
            '108.7',
            size: UIDefine.fontSize20,
            endColor:AppColors.subThemePurple,
          ),

          Padding(
              padding: EdgeInsets.all(UIDefine.getScreenWidth(1))
          ),

          Text('Trading',
            style: TextStyle(
              fontSize: UIDefine.fontSize12,
              color: AppColors.textGrey,
            ),
          ),
        ],),

  ],);
}


Widget hotCollection() {
  return Container(
    child: Column(children: [
      Row(children: [

        Padding(padding: EdgeInsets.all(UIDefine.getScreenHeight(1.5)),
          child: Image.asset(AppImagePath.starIcon),
        ),

        Text('Hot Collections',
          style: TextStyle(
            fontSize: UIDefine.fontSize24,
            fontWeight: FontWeight.bold,
            color: AppColors.textBlack,
          ),
        ),
      ],),

      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        Text('Last 24 hours',
          style: TextStyle(
            fontSize: UIDefine.fontSize20,
            color: AppColors.mainThemeButton,
          ),
        ),
        Image.asset(AppImagePath.downArrow),
      ],)



    ],),

  );

}

