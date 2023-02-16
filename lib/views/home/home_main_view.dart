import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:treasure_nft_project/constant/enum/style_enum.dart';
import 'package:treasure_nft_project/constant/theme/app_colors.dart';
import 'package:treasure_nft_project/constant/theme/app_image_path.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';
import 'package:treasure_nft_project/utils/app_text_style.dart';
import 'package:treasure_nft_project/utils/language_util.dart';
import 'package:treasure_nft_project/view_models/home/home_main_viewmodel.dart';
import 'package:treasure_nft_project/views/home/home_sub_discover_nft_view.dart';
import 'package:treasure_nft_project/views/home/home_sub_illustrate_view.dart';
import 'package:treasure_nft_project/views/home/home_sub_info_view.dart';
import 'package:treasure_nft_project/views/home/home_sub_random_view.dart';
import 'package:treasure_nft_project/views/home/home_sub_signup_view.dart';
import 'package:treasure_nft_project/views/home/home_sub_usdt_view.dart';
import 'package:treasure_nft_project/views/home/home_sub_contact_view.dart';
import 'package:treasure_nft_project/views/server_web_page.dart';
import 'package:treasure_nft_project/widgets/button/login_button_widget.dart';
import 'package:treasure_nft_project/widgets/gradient_third_text.dart';
import 'package:treasure_nft_project/widgets/list_view/home/artist_record_listview.dart';
import 'package:treasure_nft_project/widgets/text_field/login_text_widget.dart';
import '../../constant/enum/setting_enum.dart';
import '../../widgets/dialog/simple_custom_dialog.dart';
import 'widget/sponsor_row_widget.dart';

class HomeMainView extends ConsumerStatefulWidget {
  const HomeMainView({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _HomeMainViewState();
}

class _HomeMainViewState extends ConsumerState<HomeMainView> {
  HomeMainViewModel viewModel = HomeMainViewModel();

  TextEditingController emailEditingController = TextEditingController();
  ScrollController scrollController = ScrollController();
  bool showArtAnimate = false;

  @override
  void initState() {
    scrollController.addListener(() {
      if (viewModel.needRecordAnimation) {
        bool show = scrollController.offset > UIDefine.getPixelHeight(1275);
        if (show != showArtAnimate) {
          if (mounted) {
            showArtAnimate = show;
            if (showArtAnimate) {
              viewModel.playAnimate(ref);
            } else {
              viewModel.resetAnimate(ref);
            }
          }
        }
      }
    });
    viewModel.initState(ref);
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    emailEditingController.dispose();
    viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => viewModel.clearAllFocus(),
      child: Stack(
        children: [
          ListView(
              padding: EdgeInsets.only(bottom: UIDefine.navigationBarPadding),
              controller: scrollController,
              children: [
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
                ArtistRecordListView(viewModel: viewModel),
                viewModel.buildSpace(height: 3),

                /// 隨機收藏集
                const HomeSubRandomView(),
                viewModel.buildSpace(height: 3),

                /// 邀請註冊
                const HomeSubSignupView(),
                viewModel.buildSpace(height: 3),

                /// Discover NFT
               const HomeSubDiscoverNftView(),

                /// 聯絡方式
                const HomeSubContactView(),

                /// 資訊頁
                HomeSubInfoView(viewModel: viewModel),

                /// Email訂閱
                mailSubmit(),

                /// 教學影片
                // const HomeSubVideoView(),

                /// 贊助
                // sponsor(),

                viewModel.buildSpace(height: 3),
                Center(
                    child: Text('TreasureMeta Technology',
                        style: AppTextStyle.getBaseStyle(
                            fontSize: UIDefine.fontSize14,
                            color: AppColors.textBlack))),
                SizedBox(
                  height: UIDefine.getPixelHeight(70),
                )
              ]),
          Positioned(
              right: 0,
              bottom: UIDefine.navigationBarPadding,
              child: GestureDetector(
                onTap: () {
                  viewModel.pushPage(context, const ServerWebPage());
                  // scrollController.jumpTo(0);
                },
                child: SizedBox(
                  width: UIDefine.getPixelWidth(80),
                  height: UIDefine.getPixelWidth(80),
                  child: Image.asset(
                    AppImagePath.helpIcon,
                    fit: BoxFit.contain,
                  ),
                ),
              ))
        ],
      ),
    );
  }

  Widget _buildTitleText() {
    ///MARK: 調整文字與英文未對齊的問題
    bool showZh =
        (LanguageUtil.getSettingLanguageType() == LanguageType.Mandarin);

    ///MARK: 一堆title 的參數
    double styleHeight = 1.1;
    double titleFontSize = UIDefine.fontSize26;
    AppTextFamily titleFamily = AppTextFamily.Posterama1927;
    FontWeight titleFontWeight = FontWeight.w900;

    TextStyle black = AppTextStyle.getBaseStyle(
      fontSize: titleFontSize,
      fontFamily: titleFamily,
      fontWeight: titleFontWeight,
      color: AppColors.textBlack,
      // height: styleHeight,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Wrap(
          crossAxisAlignment: WrapCrossAlignment.end,
          children: [
            Text('EARN UP TO', style: black),
            GradientThirdText(
              ' 30 %',
              fontFamily: titleFamily,
              weight: titleFontWeight,
              size: UIDefine.fontSize30,
              // styleHeight: 1.1,
            ),
            GradientThirdText(
              'MONTHLY',
              fontFamily: titleFamily,
              weight: titleFontWeight,
              size: titleFontSize,
              styleHeight: styleHeight,
            )
          ],
        ),
        viewModel.buildSpace(height: 2),
        Text(tr('index-product-text-1\''),
            style: viewModel.getContextStyle(color: AppColors.textGrey)),
        Text(tr('index-product-text-2\''),
            style: viewModel.getContextStyle(color: AppColors.textGrey))
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
                style: AppTextStyle.getBaseStyle(fontSize: UIDefine.fontSize24),
              ),
            ],
          ),
          SponsorRowWidget(
            leftLogo: AppImagePath.openSea,
            rightLogo: AppImagePath.coinBase,
            viewModel: viewModel,
          ),
          SponsorRowWidget(
            leftLogo: AppImagePath.mintBase,
            rightLogo: AppImagePath.trustWallet,
            viewModel: viewModel,
          ),
          SponsorRowWidget(
            leftLogo: AppImagePath.tron,
            rightLogo: AppImagePath.binance,
            viewModel: viewModel,
          ),
          SponsorRowWidget(
            leftLogo: AppImagePath.minTable,
            rightLogo: AppImagePath.zora,
            viewModel: viewModel,
          ),
          SponsorRowWidget(
            leftLogo: AppImagePath.polygon,
            rightLogo: AppImagePath.ethereum,
            viewModel: viewModel,
          ),
          Padding(
            padding: EdgeInsets.all(UIDefine.getScreenWidth(5)),
            child: Image.asset(AppImagePath.tozfuft),
          ),
          viewModel.buildSpace(width: 3),
        ]));
  }

  Widget mailSubmit() {
    OutlineInputBorder outlineInputBorder = const OutlineInputBorder(
        borderSide: BorderSide(color: Color(0xFFF3F3F3), width: 1),
        borderRadius: BorderRadius.all(Radius.circular(10)));
    return Container(
        padding: EdgeInsets.only(
            top: UIDefine.getPixelWidth(20),
            left: UIDefine.getPixelWidth(20),
            right: UIDefine.getPixelWidth(20)),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                tr('emailIllustrate'),
                textAlign: TextAlign.start,
                style: viewModel.getContextStyle(
                    color: AppColors.textSixBlack,
                    fontSize: UIDefine.fontSize12),
              ),
              // Text('feature releases, NFT drops, and tips and tricks',
              //   style: CustomTextStyle.getBaseStyle(fontSize: UIDefine.fontSize12),
              // ),
              // Text('for navigating DeepLink.',
              //   style: CustomTextStyle.getBaseStyle(fontSize: UIDefine.fontSize12),
              // ),

              viewModel.buildSpace(height: 3),

              Stack(alignment: Alignment.centerRight, children: [
                LoginTextWidget(
                    hintText: tr('placeholder-email-address\''),
                    controller: emailEditingController),

                /// Submit按鈕
                Positioned(
                    right: UIDefine.getPixelWidth(5),
                    top: UIDefine.getPixelWidth(15),
                    bottom: UIDefine.getPixelWidth(15),
                    child: LoginButtonWidget(
                        padding: EdgeInsets.symmetric(
                            horizontal: UIDefine.getPixelWidth(5)),
                        isFillWidth: false,
                        btnText: tr('submit'),
                        fontSize: UIDefine.fontSize12,
                        fontWeight: FontWeight.w400,
                        onPressed: () {
                          SimpleCustomDialog(context,
                                  mainText: tr('subscriptSucceed'),
                                  isSuccess: true)
                              .show();
                        }))
              ]),
              viewModel.buildSpace(height: 5)
            ]));
  }
}
