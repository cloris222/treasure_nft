import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:treasure_nft_project/constant/global_data.dart';
import 'package:treasure_nft_project/constant/theme/app_colors.dart';
import 'package:treasure_nft_project/constant/theme/app_image_path.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';
import 'package:treasure_nft_project/utils/language_util.dart';
import 'package:treasure_nft_project/view_models/home/home_main_viewmodel.dart';
import 'package:treasure_nft_project/views/home/widget/home_usdt_info.dart';
import 'package:treasure_nft_project/views/main_page.dart';
import 'package:treasure_nft_project/widgets/app_bottom_navigation_bar.dart';
import 'package:treasure_nft_project/widgets/button/action_button_widget.dart';
import 'package:treasure_nft_project/widgets/domain_bar.dart';
import 'package:treasure_nft_project/widgets/gradient_text.dart';
import 'package:treasure_nft_project/widgets/list_view/home/artist_record_listview.dart';
import 'package:treasure_nft_project/widgets/list_view/home/carousel_listview.dart';
import 'package:video_player/video_player.dart';
import '../../constant/enum/setting_enum.dart';
import '../../constant/theme/app_theme.dart';
import '../../widgets/dialog/simple_custom_dialog.dart';
import 'home_pdf_viewer.dart';
import 'widget/sponsor_row_widget.dart';

class HomeMainView extends StatefulWidget {
  const HomeMainView({Key? key}) : super(key: key);

  @override
  State<HomeMainView> createState() => _HomeMainViewState();
}

class _HomeMainViewState extends State<HomeMainView> {
  HomeMainViewModel viewModel = HomeMainViewModel();

  TextEditingController emailEditingController = TextEditingController();
  FocusNode emailFocusNode = FocusNode();

  @override
  void dispose() {
    emailEditingController.dispose();
    emailFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(children: [
        Stack(children: [
          SizedBox(
              height: UIDefine.getScreenHeight(125),
              child: Transform.scale(
                  scaleX: 1.33,
                  child: Image.asset(AppImagePath.firstBackground))),
          Column(
            children: [
              const DomainBar(),
              viewModel.getPadding(5),
              Padding(
                  padding: EdgeInsets.only(
                      left: UIDefine.getScreenWidth(2),
                      right: UIDefine.getScreenWidth(2)),
                  child: _buildTitleText()),
              Padding(
                padding: EdgeInsets.only(
                    left: UIDefine.getScreenWidth(6),
                    right: UIDefine.getScreenWidth(6)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    viewModel.getPadding(3),

                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          tr('index-product-text-1\''),
                          style: TextStyle(
                            fontSize: UIDefine.fontSize14,
                            color: AppColors.textGrey,
                          ),
                        ),
                        Text(
                          tr('index-product-text-2\''),
                          style: TextStyle(
                            fontSize: UIDefine.fontSize12,
                            color: AppColors.textGrey,
                          ),
                        ),
                      ],
                    ),

                    viewModel.getPadding(5),

                    /// Trade
                    ActionButtonWidget(
                      setHeight: UIDefine.getScreenHeight(8),
                      btnText: tr('Trade'),
                      onPressed: () {
                        viewModel.isLogin()
                            ? viewModel.pushAndRemoveUntil(
                                context,
                                const MainPage(
                                    type: AppNavigationBarType.typeTrade))
                            : viewModel.pushAndRemoveUntil(
                                context,
                                const MainPage(
                                    type: AppNavigationBarType.typeLogin));
                      },
                    ),

                    viewModel.getPadding(5),

                    /// USDT_Info
                    const HomeUsdtInfo(),

                    viewModel.getPadding(4),

                    /// 輪播圖
                    SizedBox(
                      height: UIDefine.getHeight() * 0.5,
                      child: const CarouselListView(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ]),

        viewModel.getPadding(3),

        /// 畫家排行
        hotCollection(),

        /// View All
        TextButton(
          //圓角
          style: ButtonStyle(
            shadowColor: MaterialStateProperty.all(Colors.black38),
            backgroundColor: MaterialStateProperty.all(Colors.white),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                side: const BorderSide(width: 2, color: Colors.black12),
                borderRadius: BorderRadius.circular(10))),
          ),

          onPressed: () {
            viewModel.pushAndRemoveUntil(context,
                const MainPage(type: AppNavigationBarType.typeExplore));
          },
          child: Padding(
            padding:
                const EdgeInsets.only(left: 10, top: 3, right: 10, bottom: 3),
            child: Text(tr('seeAll'),
                style: const TextStyle(color: AppColors.textBlack)),
          ),
        ),

        viewModel.getPadding(2),

        /// 教學影片
        const VideoPlayWidget(),

        /// 贊助
        // sponsor(),

        /// Email訂閱
        mailSubmit(),

        /// 資訊頁
        ourInfo(),

        /// 聯絡方式
        contactUs(),
      ]),
    );
  }

  Widget _buildTitleText() {
    ///MARK: 調整文字與英文未對齊的問題
    bool showZh =
        (LanguageUtil.getSettingLanguageType() == LanguageType.Mandarin);
    double styleHeight = 1.1;
    TextStyle black = TextStyle(
        fontSize: UIDefine.fontSize22,
        fontWeight: FontWeight.bold,
        color: AppColors.textBlack,
        height: showZh ? 1.1 : null);

    return SizedBox(
        // height: UIDefine.getScreenHeight(8),
        child: showZh
            ? Wrap(children: [
                Text('使用', style: black),
                GradientText(
                  ' Treasure NFT ',
                  size: UIDefine.fontSize22,
                  weight: FontWeight.bold,
                  styleHeight: styleHeight,
                ),
                Text('交', style: black),
                Text('易', style: black),
                Text('賺', style: black),
                Text('取', style: black),
                Text('收', style: black),
                Text('益', style: black),
              ])
            : Wrap(children: [
                Text('Earn profit with',
                    style: TextStyle(
                        fontSize: UIDefine.fontSize22,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textBlack)),
                GradientText(' Treasure NFT',
                    size: UIDefine.fontSize22, weight: FontWeight.bold)
              ]));
  }

  Widget hotCollection() {
    return Column(
      children: [
        Row(
          children: [
            Padding(
              padding: EdgeInsets.only(
                left: UIDefine.getScreenHeight(1.5),
                right: UIDefine.getScreenHeight(1.5),
              ),
              child: Image.asset(AppImagePath.starIcon),
            ),
            Text(
              tr('topCreator'),
              style: TextStyle(
                fontSize: UIDefine.fontSize24,
                fontWeight: FontWeight.w400,
                color: AppColors.textBlack,
              ),
            ),
          ],
        ),
        // Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        //   Text(
        //     tr('Last_24_hours'),
        //     style: TextStyle(
        //       fontSize: UIDefine.fontSize20,
        //       color: AppColors.mainThemeButton,
        //     ),
        //   ),
        //   Image.asset(AppImagePath.downArrow),
        // ]),

        Container(
            margin:
                EdgeInsets.symmetric(horizontal: UIDefine.getScreenWidth(15)),
            child: _buildChainDropDownBar()),
        const ArtistRecordListView(),
      ],
    );
  }

  Widget _buildChainDropDownBar() {
    return DropdownButtonFormField(
        icon: Image.asset(AppImagePath.downArrow),
        onChanged: (newValue) {},
        value: 1,
        isExpanded: true,
        alignment: Alignment.center,
        decoration: InputDecoration(
          // contentPadding: EdgeInsets.fromLTRB(UIDefine.getScreenWidth(4.16),
          //     UIDefine.getScreenWidth(4.16), UIDefine.getScreenWidth(4.16), 0),
          hintStyle:
              const TextStyle(height: 1.6, color: AppColors.mainThemeButton),
          border: AppTheme.style.styleTextEditBorderBackground(
              color: Colors.transparent, radius: 10),
          focusedBorder: AppTheme.style.styleTextEditBorderBackground(
              color: Colors.transparent, radius: 10),
          enabledBorder: AppTheme.style.styleTextEditBorderBackground(
              color: Colors.transparent, radius: 10),
        ),
        items: [
          DropdownMenuItem(
              value: 1,
              child: Text(tr('Last_24_hours'),
                  style: const TextStyle(color: AppColors.mainThemeButton))),
        ]);
  }

  Widget sponsor() {
    return Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
              Color.fromARGB(255, 255, 255, 255),
              Color.fromARGB(255, 230, 247, 255),
              Color.fromARGB(255, 215, 224, 255)
            ])),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          viewModel.getPadding(5),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              viewModel.getPadding(3),
              Image.asset(AppImagePath.fileIcon),
              viewModel.getPadding(3),
              Text(
                'Investors and patrons',
                style: TextStyle(fontSize: UIDefine.fontSize24),
              ),
            ],
          ),
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
          viewModel.getPaddingWithView(5, Image.asset(AppImagePath.tozfuft)),
          viewModel.getPadding(3),
        ]));
  }

  Widget mailSubmit() {
    OutlineInputBorder outlineInputBorder = const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.transparent, width: 2),
        borderRadius: BorderRadius.all(Radius.circular(10)));
    return Container(
        color: AppColors.mainBottomBg,
        padding: EdgeInsets.only(
            top: UIDefine.getScreenWidth(6),
            left: UIDefine.getScreenWidth(6),
            right: UIDefine.getScreenWidth(6)),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              viewModel.getPadding(1),

              Text(
                tr('emailIllustrate'),
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: UIDefine.fontSize12),
              ),
              // Text('feature releases, NFT drops, and tips and tricks',
              //   style: TextStyle(fontSize: UIDefine.fontSize12),
              // ),
              // Text('for navigating DeepLink.',
              //   style: TextStyle(fontSize: UIDefine.fontSize12),
              // ),

              viewModel.getPadding(3),

              Container(
                  height: UIDefine.getScreenHeight(7),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppColors.textWhite,
                      boxShadow: const [
                        BoxShadow(
                            color: Colors.black12,
                            spreadRadius: 2,
                            blurRadius: 5),
                      ]),
                  child: Stack(alignment: Alignment.centerRight, children: [
                    TextField(
                        controller: emailEditingController,
                        focusNode: emailFocusNode,
                        decoration: InputDecoration(
                            hintText: tr('placeholder-email-address\''),
                            hintStyle:
                                const TextStyle(color: AppColors.textGrey),
                            enabledBorder: outlineInputBorder,
                            focusedBorder: outlineInputBorder,
                            border: outlineInputBorder,
                            filled: true,
                            fillColor: AppColors.textWhite,
                            contentPadding: const EdgeInsets.only(
                                left: 14.0, bottom: 8.0, top: 8.0))),

                    /// Submit按鈕
                    ClipRRect(
                        borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(10),
                            bottomRight: Radius.circular(10)),
                        child: SizedBox(
                            height: UIDefine.getScreenHeight(15),
                            width: UIDefine.getScreenWidth(25),
                            child: GestureDetector(
                                onTap: () {
                                  SimpleCustomDialog(context,
                                          mainText: tr('subscriptSucceed'),
                                          isSuccess: true)
                                      .show();
                                },
                                child: Container(
                                    color: AppColors.mainThemeButton,
                                    child: Center(
                                        child: Text(tr('submit'),
                                            style: TextStyle(
                                                color: AppColors.textWhite,
                                                fontSize: UIDefine.fontSize16,
                                                fontWeight:
                                                    FontWeight.bold)))))))
                  ])),
              viewModel.getPadding(5)
            ]));
  }

  Widget ourInfo() {
    double padding = 2;
    return Container(
        color: AppColors.mainBottomBg,
        padding: EdgeInsets.only(
            top: UIDefine.getScreenWidth(6),
            left: UIDefine.getScreenWidth(6),
            right: UIDefine.getScreenWidth(6)),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Resources
              Flexible(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                    Text(tr('footer_resource'),
                        style: TextStyle(
                            fontSize: UIDefine.fontSize16,
                            color: AppColors.textBlack)),
                    viewModel.getPadding(padding),
                    GestureDetector(
                        onTap: () {
                          viewModel.launchInBrowser(
                              'https://treasurenft.gitbook.io/treasurenft-1/');
                        },
                        child: Text(tr('footer_docs'),
                            style: TextStyle(
                                fontSize: UIDefine.fontSize14,
                                color: AppColors.textGrey))),
                    viewModel.getPadding(padding),
                    GestureDetector(
                        onTap: () {
                          viewModel.launchInBrowser(
                              'https://treasurenft-metaverse.gitbook.io/how-to-use/earn/how-to-share-invitations');
                        },
                        child: Text(tr('footer_friends'),
                            style: TextStyle(
                                fontSize: UIDefine.fontSize14,
                                color: AppColors.textGrey))),
                    viewModel.getPadding(padding),
                    GestureDetector(
                        onTap: () {
                          viewModel.launchInBrowser(
                              'https://treasurenft-metaverse.gitbook.io/how-to-use/earn/how-to-trade');
                        },
                        child: Text(tr('footer_howtoBuy'),
                            style: TextStyle(
                                fontSize: UIDefine.fontSize14,
                                color: AppColors.textGrey)))
                  ])),

              /// News
              Flexible(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                    Text(
                      tr('footer_news'),
                      style: TextStyle(
                        fontSize: UIDefine.fontSize16,
                        color: AppColors.textBlack,
                      ),
                    ),
                    viewModel.getPadding(padding),
                    GestureDetector(
                        onTap: () {
                          viewModel.launchInBrowser(
                              'https://medium.com/@Treasurenft_xyz');
                        },
                        child: Text(tr('footer_blog'),
                            style: TextStyle(
                                fontSize: UIDefine.fontSize14,
                                color: AppColors.textGrey)))
                  ])),

              /// Company
              Flexible(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                    Text(
                      tr('footer_company'),
                      style: TextStyle(
                        fontSize: UIDefine.fontSize16,
                        color: AppColors.textBlack,
                      ),
                    ),
                    viewModel.getPadding(padding),
                    GestureDetector(
                        onTap: () {
                          viewModel.pushPage(
                              GlobalData.globalKey.currentContext!,
                              PDFViewerPage(
                                title: tr('footer_privacy'),
                                assetPath: 'assets/pdf/PrivacyPolicy.pdf',
                              ));
                        },
                        child: Text(tr('footer_privacy'),
                            style: TextStyle(
                                fontSize: UIDefine.fontSize14,
                                color: AppColors.textGrey))),
                    viewModel.getPadding(padding),
                    GestureDetector(
                        onTap: () {
                          viewModel.pushPage(
                              GlobalData.globalKey.currentContext!,
                              PDFViewerPage(
                                title: tr('footer_agreement'),
                                assetPath: 'assets/pdf/TermsOfUse.pdf',
                              ));
                        },
                        child: Text(tr('footer_agreement'),
                            style: TextStyle(
                                fontSize: UIDefine.fontSize14,
                                color: AppColors.textGrey)))
                  ]))
            ]));
  }

  Widget contactUs() {
    return Container(
        color: AppColors.mainBottomBg,
        child: Column(children: [
          Padding(
              padding: EdgeInsets.only(
                  top: UIDefine.getScreenWidth(2),
                  left: UIDefine.getScreenWidth(6),
                  right: UIDefine.getScreenWidth(6)),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    viewModel.getPadding(5),

                    Text(tr('footer_contactUs'),
                        style: TextStyle(
                            fontSize: UIDefine.fontSize16,
                            color: AppColors.textBlack)),
                    viewModel.getPadding(2),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              viewModel.launchInBrowser(
                                  'mailto:treasurenft.metaverse@gmail.com');
                            },
                            child: Image.asset(AppImagePath.mail),
                          ),

                          GestureDetector(
                              onTap: () {
                                viewModel.launchInBrowser(
                                    'https://www.tiktok.com/@treasurenft_xyz');
                              },
                              child: Image.asset(AppImagePath.tiktok)),

                          GestureDetector(
                              onTap: () {
                                viewModel.launchInBrowser(
                                    'https://twitter.com/Treasurenft_xyz');
                              },
                              child: Image.asset(AppImagePath.twitter)),

                          // GestureDetector(
                          //   onTap: () {
                          //      viewModel.launchInBrowser('');
                          //   },
                          //   child: Image.asset(AppImagePath.yt),
                          // ),

                          GestureDetector(
                              onTap: () {
                                viewModel.launchInBrowser(
                                    'https://t.me/TreasureNFTchat');
                              },
                              child: Image.asset(AppImagePath.tg)),

                          GestureDetector(
                              onTap: () {
                                viewModel.launchInBrowser(
                                    'https://www.facebook.com/Treasurenft-101676776000520');
                              },
                              child: Image.asset(AppImagePath.fb)),

                          GestureDetector(
                              onTap: () {
                                viewModel.launchInBrowser(
                                    'https://www.instagram.com/treasurenft_xyz/');
                              },
                              child: Image.asset(AppImagePath.ig)),

                          GestureDetector(
                              onTap: () {
                                viewModel.launchInBrowser(
                                    'https://discord.gg/H54mUVeQRQ');
                              },
                              child: Image.asset(AppImagePath.dc))
                        ]),
                    // viewModel.getPadding(4),
                    // Text(
                    //   tr('document-title-2'),
                    //   style: TextStyle(
                    //       fontSize: UIDefine.fontSize16,
                    //       color: AppColors.textBlack,
                    //       height: 1.3),
                    // ),
                    // viewModel.getPadding(2),
                    // Text(
                    //   tr('document-text-1'),
                    //   style: TextStyle(
                    //       fontSize: UIDefine.fontSize14,
                    //       color: AppColors.textGrey,
                    //       height: 1.3),
                    // ),
                    // viewModel.getPadding(10),
                    // Center(
                    //     child: Text('Copyright 2022',
                    //         style: TextStyle(
                    //           fontSize: UIDefine.fontSize14,
                    //           color: AppColors.textBlack,
                    //         ))),
                    viewModel.getPadding(5),
                    Center(
                        child: Text('TreasureMeta Technology',
                            style: TextStyle(
                                fontSize: UIDefine.fontSize14,
                                color: AppColors.textBlack))),
                    viewModel.getPadding(5),
                  ]))
        ]));
  }
}

class VideoPlayWidget extends StatefulWidget {
  const VideoPlayWidget({super.key});

  @override
  State<StatefulWidget> createState() => VideoPlayWidgetState();
}

class VideoPlayWidgetState extends State<VideoPlayWidget> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    _controller = VideoPlayerController.network(
        'https://devimage.treasurenft.xyz/Treasure2.5/index/pc_ad_01.mp4')
      ..initialize().then((value) {
        setState(() {});
        _controller.setLooping(true);
      });

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: UIDefine.getWidth(),
        height: UIDefine.getScreenHeight(27),
        child: Container(
          child: _controller.value.isInitialized
              ? _controller.value.isPlaying
                  ? InkWell(
                      onTap: _onStop,
                      child: AspectRatio(
                          aspectRatio: _controller.value.aspectRatio,
                          child: VideoPlayer(_controller)))
                  : Container(
                      color: Colors.white,
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(UIDefine.getScreenWidth(2)),
                      child: InkWell(
                          onTap: _onStart,
                          child: Stack(alignment: Alignment.center, children: [
                            Image.asset(AppImagePath.videoImg,
                                height: UIDefine.getScreenHeight(15)),
                            Opacity(
                                opacity: 0.87,
                                child: CircleAvatar(
                                    radius: UIDefine.getScreenWidth(8),
                                    backgroundColor: Colors.white,
                                    child: Icon(Icons.play_arrow,
                                        color: Colors.black,
                                        size: UIDefine.getScreenWidth(8))))
                          ])))
              : Container(),
        ));
  }

  void _onStop() {
    _controller.pause().then((value) => setState(() {}));
  }

  void _onStart() {
    _controller
        .seekTo(const Duration(seconds: 0))
        .then((value) => _controller.play().then((value) => setState(() {})));
  }
}
