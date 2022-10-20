import 'dart:io';

import 'package:flutter/material.dart';
import 'package:treasure_nft_project/constant/global_data.dart';
import 'package:treasure_nft_project/constant/theme/app_colors.dart';
import 'package:treasure_nft_project/constant/theme/app_image_path.dart';
import 'package:treasure_nft_project/constant/theme/app_style.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';
import 'package:treasure_nft_project/view_models/home/home_main_viewmodel.dart';
import 'package:treasure_nft_project/widgets/button/action_button_widget.dart';
import 'package:treasure_nft_project/widgets/domain_bar.dart';
import 'package:treasure_nft_project/widgets/gradient_text.dart';
import 'package:treasure_nft_project/widgets/list_view/home/artist_record_listview.dart';
import 'package:treasure_nft_project/widgets/list_view/home/carousel_listview.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';
import 'home_pdf_viewer.dart';
import 'widget/sponsor_row_widget.dart';


class HomeMainView extends StatelessWidget {
  const HomeMainView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HomeMainViewModel viewModel = HomeMainViewModel();
    return SingleChildScrollView(
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

                  /// Trade
                  ActionButtonWidget(
                    setHeight: UIDefine.getScreenHeight(8),
                    btnText: 'Trade',
                    onPressed: () {},
                  ),

                  viewModel.getPadding(5),

                  /// USDT_Info
                  USDT_Info(),

                  viewModel.getPadding(4),

                  /// 輪播圖
                    SizedBox(
                      height: UIDefine.getScreenHeight(57),
                      child: const CarouselListView(),
                    ),

                ],),
            ),
          ],),
        ]),

        /// 畫家排行
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
                    side: const BorderSide(width: 2, color: Colors.black12),
                    borderRadius: BorderRadius.circular(10))),
          ),

          onPressed: () {},
          child: const Padding (
            padding: EdgeInsets.only(left: 10, top: 3, right: 10, bottom: 3),
            child:Text('View all', style: TextStyle(color: AppColors.textBlack)),
          ),
        ),

        viewModel.getPadding(1),

        /// 教學影片
        SizedBox(
          width: UIDefine.getWidth(),
          child: const VideoPlayWidget(),
        ),

        /// 贊助
        sponsor(),

        /// Email訂閱
        mailSubmit(),

        /// 資訊頁
        ourInfo(),

        /// 聯絡方式
        contactUs(),

      ]),
    );
  }
}


Widget USDT_Info() {
  HomeMainViewModel viewModel = HomeMainViewModel();

  return SizedBox(
      width: UIDefine.getWidth(),
      child:Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('VOL (USDT)',
                style: TextStyle(
                    fontSize: UIDefine.fontSize12,
                    color: AppColors.textBlack,
                    fontWeight: FontWeight.w300
                ),
              ),

              viewModel.getPadding(1),

              Text('12,373.6',
                style: TextStyle(
                  fontSize: UIDefine.fontSize18,
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
              Text('FEE (USDT)',
                style: TextStyle(
                    fontSize: UIDefine.fontSize12,
                    color: AppColors.textBlack,
                    fontWeight: FontWeight.w300
                ),
              ),

              viewModel.getPadding(1),

              Text('1.54',
                style: TextStyle(
                  fontSize: UIDefine.fontSize18,
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
                    fontSize: UIDefine.fontSize12,
                    color: AppColors.textBlack,
                    fontWeight: FontWeight.w300
                ),
              ),

              viewModel.getPadding(1),

              GradientText(
                '108.7',
                size: UIDefine.fontSize18,
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

        ],));
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
    _controller = VideoPlayerController
        .network('https://devimage.treasurenft.xyz/Treasure2.5/index/pc_ad_01.mp4')
      ..initialize().then((value) {setState(() {});})
      ..play();

    super.initState();
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


Widget sponsor() {
  HomeMainViewModel vm = HomeMainViewModel();
  return SizedBox(
    height: UIDefine.getHeight()/1.2,
    child: Stack(children: [
      Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color.fromARGB(255, 255, 255, 255),
                  Color.fromARGB(255, 230, 247, 255),
                  Color.fromARGB(255, 215, 224, 255)
                ])),
      ),

      Column(children: [
        vm.getPadding(5),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            vm.getPadding(3),
            Image.asset(AppImagePath.fileIcon),
            vm.getPadding(3),
            Text('Investors and patrons',
              style: TextStyle(
                  fontSize: UIDefine.fontSize24
              ),),
          ],),

        const SponsorRowWidget(
          leftLogo: AppImagePath.openSea,
          rightLogo: AppImagePath.coinBase,
        ),

        const SponsorRowWidget(
          leftLogo: AppImagePath.mintBase,
          rightLogo: AppImagePath.trustWallet,
        ),

        const SponsorRowWidget(
          leftLogo: AppImagePath.tron,
          rightLogo: AppImagePath.binance,
        ),

        const SponsorRowWidget(
          leftLogo: AppImagePath.minTable,
          rightLogo: AppImagePath.zora,
        ),

        const SponsorRowWidget(
          leftLogo: AppImagePath.polygon,
          rightLogo: AppImagePath.ethereum,
        ),

        vm.getPaddingWithView(5, Image.asset(AppImagePath.tozfuft)),

      ]),

    ],),
  );
}


Widget mailSubmit() {
  HomeMainViewModel vm = HomeMainViewModel();
  TextEditingController textEditingController = TextEditingController();
  FocusNode focusNode = FocusNode();
  return SizedBox(
      height: UIDefine.getScreenHeight(30),
      child: Stack(
        alignment: Alignment.center,
        children: [
          /// 背景顏色
          Container(
            decoration: const BoxDecoration(
                color: Color.fromARGB(255, 224, 234, 246)
            ),
          ),

          Padding(padding: EdgeInsets.only(
              top: UIDefine.getScreenWidth(6),
              left:UIDefine.getScreenWidth(6),
              right: UIDefine.getScreenWidth(6)),
              child:
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  vm.getPadding(1),

                  Text('Join our mailing list to stay in the loop with our newest',
                    style: TextStyle(fontSize: UIDefine.fontSize12),
                  ),
                  Text('feature releases, NFT drops, and tips and tricks',
                    style: TextStyle(fontSize: UIDefine.fontSize12),
                  ),
                  Text('for navigating DeepLink.',
                    style: TextStyle(fontSize: UIDefine.fontSize12),
                  ),

                  vm.getPadding(3),

                  Container(
                      height: UIDefine.getScreenHeight(7),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: AppColors.textWhite,
                          boxShadow: const [
                            BoxShadow(
                                color: Colors.black12,
                                spreadRadius: 2,
                                blurRadius: 5
                            ),
                          ]),

                      child:Stack(
                        alignment: Alignment.centerRight,
                        children: [
                          TextField(
                            controller: textEditingController,
                            focusNode: focusNode,
                            decoration: InputDecoration(
                                hintText: 'Enter your email address',
                                hintStyle: const TextStyle(color: AppColors.textGrey),
                                border: AppStyle().styleTextEditBorderBackground(radius: 10),
                                filled: true,
                                fillColor: AppColors.textWhite,
                                contentPadding: const EdgeInsets.only(
                                    left: 14.0, bottom: 8.0, top: 8.0)),
                          ),

                          /// Submit按鈕
                          ClipRRect(
                            borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(10),
                              bottomRight: Radius.circular(10),
                            ),
                            child: SizedBox(
                              height: UIDefine.getScreenHeight(15),
                              width: UIDefine.getScreenWidth(25),
                              child: GestureDetector(
                                onTap: () {},
                                child: Container(
                                  color: AppColors.mainThemeButton,
                                  child: Center(
                                    child: Text('Submit',
                                      style: TextStyle(
                                          color: AppColors.textWhite,
                                          fontSize: UIDefine.fontSize20,
                                          fontWeight: FontWeight.bold
                                      ),),
                                  ),
                                ),
                              ),
                            ),
                          ),

                        ],)
                  ),
                ],)),
        ],));
}


Widget ourInfo() {
  HomeMainViewModel viewModel = HomeMainViewModel();
  double p = 2;
  return  SizedBox(
      height: UIDefine.getScreenHeight(30),
      child: Stack(
        alignment: Alignment.center,
        children: [
          /// 背景顏色
          Container(
            decoration: const BoxDecoration(
                color: Color.fromARGB(255, 224, 234, 246)
            ),
          ),
          Padding(padding: EdgeInsets.only(
              top: UIDefine.getScreenWidth(6),
              left:UIDefine.getScreenWidth(6),
              right: UIDefine.getScreenWidth(6)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

              /// Resources
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                Text('Resources', style: TextStyle(
                  fontSize: UIDefine.fontSize16,
                  color: AppColors.textBlack,
                ),),

                viewModel.getPadding(p),

                  GestureDetector(
                    onTap: () {
                      viewModel.launchInBrowser('https://treasurenft.gitbook.io/treasurenft-1/');
                    },
                    child:Text('Docs', style: TextStyle(
                      fontSize: UIDefine.fontSize14,
                      color: AppColors.textGrey,
                    ),),
                  ),

                viewModel.getPadding(p),

                  GestureDetector(
                    onTap: () {
                      viewModel.launchInBrowser('https://treasurenft-metaverse.gitbook.io/how-to-use/earn/how-to-share-invitations');
                    },
                    child:Text('Invite Friends', style: TextStyle(
                      fontSize: UIDefine.fontSize14,
                      color: AppColors.textGrey,
                    ),),
                  ),

                viewModel.getPadding(p),

                  GestureDetector(
                    onTap: () {
                      viewModel.launchInBrowser('https://treasurenft-metaverse.gitbook.io/how-to-use/earn/how-to-trade');
                    },
                    child:Text('How to buy', style: TextStyle(
                      fontSize: UIDefine.fontSize14,
                      color: AppColors.textGrey,
                    ),),
                  ),
              ],),

              /// News
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                Text('News', style: TextStyle(
                  fontSize: UIDefine.fontSize16,
                  color: AppColors.textBlack,
                ),),

                viewModel.getPadding(p),

                  GestureDetector(
                    onTap: () {
                      viewModel.launchInBrowser('https://medium.com/@Treasurenft_xyz');
                    },
                    child:Text('Blog', style: TextStyle(
                      fontSize: UIDefine.fontSize14,
                      color: AppColors.textGrey,
                    ),),
                  ),
              ],),

              /// Company
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                Text('Company', style: TextStyle(
                  fontSize: UIDefine.fontSize16,
                  color: AppColors.textBlack,
                ),),

                viewModel.getPadding(p),

                  GestureDetector(
                    onTap: () {
                      viewModel.pushPage(GlobalData.globalKey.currentContext!,
                          const PDFViewerPage(
                            title: 'Privacy Policy',
                            assetPath: 'assets/pdf/PrivacyPolicy.pdf',
                          ));
                    },
                    child: Text('Privacy Policy', style: TextStyle(
                      fontSize: UIDefine.fontSize14,
                      color: AppColors.textGrey,
                    ),),
                  ),

                viewModel.getPadding(p),

                  GestureDetector(
                    onTap: () {
                      viewModel.pushPage(GlobalData.globalKey.currentContext!,
                          const PDFViewerPage(
                            title: 'User Agreement',
                            assetPath: 'assets/pdf/TermsOfUse.pdf',
                          ));
                    },
                    child: Text('User Agreement', style: TextStyle(
                      fontSize: UIDefine.fontSize14,
                      color: AppColors.textGrey,
                    ),),
                  ),

              ],),
            ],),

          )],)
  );
}

Widget contactUs() {
  HomeMainViewModel viewModel = HomeMainViewModel();
  return SizedBox(
      height: UIDefine.getScreenHeight(55),
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          /// 背景顏色
          Container(
            decoration: const BoxDecoration(
                color: Color.fromARGB(255, 224, 234, 246)
            ),
          ),
          Padding(padding: EdgeInsets.only(
              top: UIDefine.getScreenWidth(2),
              left:UIDefine.getScreenWidth(6),
              right: UIDefine.getScreenWidth(6)),
            child:Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Contact us', style: TextStyle(
                      fontSize: UIDefine.fontSize16,
                      color: AppColors.textBlack,
                    ),),

                    viewModel.getPadding(2),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                      GestureDetector(
                        onTap: () {
                        },
                        child: Image.asset(AppImagePath.mail),
                      ),

                      GestureDetector(
                        onTap: () {
                        },
                        child: Image.asset(AppImagePath.tiktok),
                      ),

                      GestureDetector(
                        onTap: () {
                        },
                        child: Image.asset(AppImagePath.twitter),
                      ),

                      GestureDetector(
                        onTap: () {
                        },
                        child: Image.asset(AppImagePath.yt),
                      ),

                      GestureDetector(
                        onTap: () {
                        },
                        child: Image.asset(AppImagePath.tg),
                      ),

                      GestureDetector(
                        onTap: () {
                        },
                        child: Image.asset(AppImagePath.fb),
                      ),

                      GestureDetector(
                        onTap: () {
                        },
                        child: Image.asset(AppImagePath.ig),
                      ),

                      GestureDetector(
                        onTap: () {
                        },
                        child: Image.asset(AppImagePath.dc),
                      ),

                    ],),

                    viewModel.getPadding(4),

                    Text('The world\'s first encrypted NFT integrated '
                        '\nmarketplace-TreasureNFT', style: TextStyle(
                      fontSize: UIDefine.fontSize16,
                      color: AppColors.textBlack,
                      height: 1.3
                    ),),

                    viewModel.getPadding(2),

                    Text('Through innovative algorithmic trading mode, '
                        '\nit gives encrypted NFT assets new vigour and '
                        '\nvitality From TreasureMeta Technology ltd',
                      style: TextStyle(
                        fontSize: UIDefine.fontSize14,
                        color: AppColors.textGrey,
                        height: 1.3
                      ),),

                    viewModel.getPadding(10),

                    Center(
                      child: Text('Copyright 2022', style: TextStyle(
                          fontSize: UIDefine.fontSize14,
                          color: AppColors.textBlack,
                      ),),
                    ),

                  ],),
          )],)
  );

}

