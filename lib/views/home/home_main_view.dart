import 'package:flutter/material.dart';
import 'package:treasure_nft_project/constant/theme/app_colors.dart';
import 'package:treasure_nft_project/constant/theme/app_image_path.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';
import 'package:treasure_nft_project/view_models/home/home_main_viewmodel.dart';
import 'package:treasure_nft_project/widgets/button/action_button_widget.dart';
import 'package:treasure_nft_project/widgets/domain_bar.dart';
import 'package:treasure_nft_project/widgets/gradient_text.dart';
import 'package:treasure_nft_project/widgets/list_view/home/artist_record_listview.dart';
import 'package:treasure_nft_project/widgets/list_view/home/carousel_listview.dart';
import 'package:video_player/video_player.dart';


class HomeMainView extends StatelessWidget {
  const HomeMainView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HomeMainViewModel viewModel = HomeMainViewModel();
    return SingleChildScrollView(
        child:SizedBox(
          child:Column(children: [
            Stack(children: [

              SizedBox(
                height: UIDefine.getScreenHeight(121),
                child:  Transform.scale(
                  scaleX: 1.33,
                  child: Image.asset(AppImagePath.firstBackground),
                ),
              ),

              Column(children: [
                const DomainBar(),

                Padding(
                  /// 上半部總padding
                  padding: EdgeInsets.only(
                      left:UIDefine.getScreenWidth(6),
                      right: UIDefine.getScreenWidth(6)),
                  child:Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      viewModel.getPadding(5),

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

                      viewModel.getPadding(3),

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

                      viewModel.getPadding(5),

                      ActionButtonWidget(
                        setHeight: UIDefine.getScreenHeight(8),
                        btnText: 'Trade',
                        onPressed: () {},
                      ),

                      viewModel.getPadding(5),

                      USDT_Info(),

                      viewModel.getPadding(4),

                      /// 輪播圖
                      SizedBox(
                        height: UIDefine.getScreenHeight(57),
                        child:const CarouselListView(),
                      ),

                    ],),
                ),
              ],),
            ]),

          hotCollection(),

            /// View All
            TextButton(
              //圓角
              style: ButtonStyle(
                // elevation: MaterialStateProperty.all(5),
                shadowColor: MaterialStateProperty.all(Colors.black38),
                backgroundColor: MaterialStateProperty.all(Colors.white),
                shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                        side: const BorderSide(width: 3, color: Colors.black12),
                        borderRadius: BorderRadius.circular(10))),
              ),

              onPressed: () {},
              child: const Padding (
                padding: EdgeInsets.only(left: 10, top: 3, right: 10, bottom: 3),
                child:Text('View all', style: TextStyle(color: AppColors.textBlack)),
              ),
            ),

            viewModel.getPadding(1),

            SizedBox(
              width: UIDefine.getWidth(),
              height: UIDefine.getScreenHeight(50),
              child: const VideoPlayWidget(),
            ),


          ]),
        ),
      );
  }
}


Widget USDT_Info() {
  HomeMainViewModel viewModel = HomeMainViewModel();

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

          viewModel.getPadding(1),

          Text('12,373.6',
            style: TextStyle(
              fontSize: UIDefine.fontSize20,
              color: AppColors.textBlack,
            ),
          ),

          viewModel.getPadding(1),

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

      viewModel.getPadding(1),

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

          viewModel.getPadding(1),

          Text('1.54',
            style: TextStyle(
              fontSize: UIDefine.fontSize20,
              color: AppColors.textBlack,
            ),
          ),

          viewModel.getPadding(1),

          Text('updated 3 minutes ago',
            style: TextStyle(
              fontSize: UIDefine.fontSize12,
              color: AppColors.textGrey,
            ),
          ),
        ],),

      viewModel.getPadding(1),

      //分隔線
      SizedBox(
          height: UIDefine.getScreenHeight(10),
          child:const VerticalDivider(
            width: 3,
            color: AppColors.dialogBlack,
            thickness: 0.5,
          )),

      viewModel.getPadding(1),

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

          viewModel.getPadding(1),

          GradientText(
            '108.7',
            size: UIDefine.fontSize20,
            endColor:AppColors.subThemePurple,
          ),

          viewModel.getPadding(1),

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
  return  Column(children: [
    Row(children: [
      Padding(padding: EdgeInsets.only(
          left:UIDefine.getScreenHeight(1.5),
          right: UIDefine.getScreenHeight(1.5),
      ),
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
    ]),

    const ArtistRecordListView(),

  ],);
}

class VideoPlayWidget extends StatefulWidget {
  const VideoPlayWidget({super.key});
  @override
  State<StatefulWidget> createState() =>VideoPlayWidgetState();
}

class VideoPlayWidgetState extends State<VideoPlayWidget> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(
        'https://www.youtube.com/watch?v=GNQu64S5uFc&ab_channel=%E9%98%BF%E6%BB%B4%E6%97%A5%E5%B8%B8')
      ..initialize().then((_) {
        setState(() {});
      });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      child: _controller.value.isInitialized
          ? AspectRatio(
        aspectRatio: _controller.value.aspectRatio,
        child: VideoPlayer(_controller),
      )
          : Container(),
    );
  }
}

