import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:treasure_nft_project/constant/global_data.dart';
import 'package:treasure_nft_project/constant/theme/app_colors.dart';
import 'package:treasure_nft_project/constant/theme/app_image_path.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';
import 'package:treasure_nft_project/utils/language_util.dart';
import 'package:treasure_nft_project/view_models/home/home_main_viewmodel.dart';
import 'package:treasure_nft_project/views/home/home_sub_illustrate_view.dart';
import 'package:treasure_nft_project/views/home/home_sub_random_view.dart';
import 'package:treasure_nft_project/views/home/home_sub_usdt_view.dart';
import 'package:treasure_nft_project/views/home/home_sub_contact_view.dart';
import 'package:treasure_nft_project/widgets/gradient_text.dart';
import 'package:treasure_nft_project/widgets/list_view/home/artist_record_listview.dart';
import '../../constant/enum/setting_enum.dart';
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
  ScrollController scrollController = ScrollController();
  bool showArtAnimate = false;

  @override
  void initState() {
    scrollController.addListener(() {
      bool show = scrollController.offset > UIDefine.getPixelHeight(1275);
      if (show != showArtAnimate) {
        setState(() {
          showArtAnimate = show;
        });
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    emailEditingController.dispose();
    emailFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: scrollController,
      child: Column(children: [
        // const DomainBar(),
        ///MARK: 標題
        Padding(
            padding: EdgeInsets.symmetric(
                horizontal: UIDefine.getPixelWidth(20),
                vertical: UIDefine.getPixelHeight(10)),
            child: _buildTitleText()),

        ///MARK: USDT資訊
        const HomeSubUsdtView(),

        viewModel.buildSpace(height: 3),

        const HomeSubIllustrateView(),

        viewModel.buildSpace(height: 3),

        /// 熱門系列 畫家排行
        ArtistRecordListView(showArtAnimate: showArtAnimate),
        viewModel.buildSpace(height: 3),

        /// 隨機收藏集
        const HomeSubRandomView(),
        viewModel.buildSpace(height: 3),

        /// 教學影片
        // const HomeSubVideoView(),

        /// 贊助
        // sponsor(),

        /// Email訂閱
        mailSubmit(),

        /// 資訊頁
        ourInfo(),

        /// 聯絡方式
        const HomeSubContactView(),
      ]),
    );
  }

  Widget _buildTitleText() {
    ///MARK: 調整文字與英文未對齊的問題
    bool showZh =
        (LanguageUtil.getSettingLanguageType() == LanguageType.Mandarin);
    double styleHeight = 1.1;
    TextStyle black = TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w500,
        color: AppColors.textBlack,
        height: showZh ? 1.1 : null);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            // height: UIDefine.getScreenHeight(8),
            alignment: Alignment.centerLeft,
            child: showZh
                ? Wrap(alignment: WrapAlignment.start, children: [
                    Text('使用', style: black),
                    GradientText(
                      'Treasure NFT',
                      size: UIDefine.fontSize20,
                      weight: FontWeight.w500,
                      styleHeight: styleHeight,
                    ),
                    Text('交', style: black),
                    Text('易', style: black),
                    Text('賺', style: black),
                    Text('取', style: black),
                    Text('收', style: black),
                    Text('益', style: black),
                  ])
                : Wrap(alignment: WrapAlignment.start, children: [
                    Text('Earn profit with',
                        style: TextStyle(
                            fontSize: UIDefine.fontSize20,
                            fontWeight: FontWeight.w500,
                            color: AppColors.textBlack)),
                    GradientText(' Treasure NFT',
                        size: UIDefine.fontSize20, weight: FontWeight.w500)
                  ])),
        viewModel.buildSpace(height: 2),
        Text(tr('index-product-text-1\''),
            style: TextStyle(
                fontSize: UIDefine.fontSize14, color: AppColors.textGrey)),
        Text(tr('index-product-text-2\''),
            style: TextStyle(
                fontSize: UIDefine.fontSize14, color: AppColors.textGrey))
      ],
    );
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
          viewModel.buildSpace(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              viewModel.buildSpace(width: 3),
              Image.asset(AppImagePath.fileIcon),
              viewModel.buildSpace(width: 3),
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
          viewModel.buildSpace(width: 3),
        ]));
  }

  Widget mailSubmit() {
    OutlineInputBorder outlineInputBorder = const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.transparent, width: 2),
        borderRadius: BorderRadius.all(Radius.circular(10)));
    return Container(
        color: AppColors.mainBottomBg,
        padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              viewModel.buildSpace(height: 1),

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

              viewModel.buildSpace(height: 3),

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
                                                    FontWeight.w500)))))))
                  ])),
              viewModel.buildSpace(height: 5)
            ]));
  }

  Widget ourInfo() {
    double padding = 2;
    return Container(
        color: AppColors.mainBottomBg,
        padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
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
                    viewModel.buildSpace(height: padding),
                    GestureDetector(
                        onTap: () {
                          viewModel.launchInBrowser(
                              'https://treasurenft.gitbook.io/treasurenft-1/');
                        },
                        child: Text(tr('footer_docs'),
                            style: TextStyle(
                                fontSize: UIDefine.fontSize14,
                                color: AppColors.font02))),
                    viewModel.buildSpace(height: padding),
                    GestureDetector(
                        onTap: () {
                          viewModel.launchInBrowser(
                              'https://treasurenft-metaverse.gitbook.io/how-to-use/earn/how-to-share-invitations');
                        },
                        child: Text(tr('footer_friends'),
                            style: TextStyle(
                                fontSize: UIDefine.fontSize14,
                                color: AppColors.font02))),
                    viewModel.buildSpace(height: padding),
                    GestureDetector(
                        onTap: () {
                          viewModel.launchInBrowser(
                              'https://treasurenft-metaverse.gitbook.io/how-to-use/earn/how-to-trade');
                        },
                        child: Text(tr('footer_howtoBuy'),
                            style: TextStyle(
                                fontSize: UIDefine.fontSize14,
                                color: AppColors.font02)))
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
                    viewModel.buildSpace(height: padding),
                    GestureDetector(
                        onTap: () {
                          viewModel.launchInBrowser(
                              'https://medium.com/@Treasurenft_xyz');
                        },
                        child: Text(tr('footer_blog'),
                            style: TextStyle(
                                fontSize: UIDefine.fontSize14,
                                color: AppColors.font02)))
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
                    viewModel.buildSpace(height: padding),
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
                                color: AppColors.font02))),
                    viewModel.buildSpace(height: padding),
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
                                color: AppColors.font02)))
                  ]))
            ]));
  }
}
