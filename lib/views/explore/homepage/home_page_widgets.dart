import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:treasure_nft_project/constant/call_back_function.dart';
import 'package:treasure_nft_project/constant/global_data.dart';
import 'package:treasure_nft_project/constant/theme/app_colors.dart';
import 'package:treasure_nft_project/constant/theme/app_image_path.dart';
import 'package:treasure_nft_project/utils/app_text_style.dart';
import 'package:treasure_nft_project/view_models/base_view_model.dart';
import 'package:treasure_nft_project/views/main_page.dart';
import 'package:treasure_nft_project/widgets/label/gradually_network_image.dart';

import '../../../constant/theme/app_theme.dart';
import '../../../constant/ui_define.dart';
import '../../../widgets/app_bottom_navigation_bar.dart';
import '../../login/circle_network_icon.dart';
import '../data/explore_artist_detail_response_data.dart';
import '../data/explore_main_response_data.dart';
import '../itemdetail/explore_product_detail_page.dart';

class HomePageWidgets {
  static HomePageWidgets? _homePageWidgets;

  HomePageWidgets._();

  factory HomePageWidgets() {
    return _homePageWidgets ??= HomePageWidgets._();
  }

  late onGetStringFunction callBack; // Sms的callBack

  Widget newHomePageTop(ExploreMainResponseData data,
      ExploreArtistDetailResponseData adData, bool bShowMore,
      {
        required VoidCallback popBack,
        required VoidCallback seeMoreAction,
        required onGetStringFunction callBack,
        required List<Sm> smList
      }) {
    this.callBack = callBack;
    adData.artistInfo = adData.artistInfo.replaceAll('\n', ''); // 不給換行,不然會破版
    return Stack(
      children: [
        GraduallyNetworkImage(
            width: double.infinity,
            height: UIDefine.getScreenWidth(80),
            imageUrl: data.introPhoneUrl,
            cacheWidth: 2080,
            fit: BoxFit.cover
        ),

        Container(
          width: double.infinity,
          height: bShowMore? _getHeightForInfoView(adData.artistInfo) : UIDefine.getScreenWidth(89),
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: FractionalOffset.topCenter,
                  end: FractionalOffset.bottomCenter,
                  colors: [
                    Colors.grey.withOpacity(0.0),
                    Colors.black,
                  ],
                  stops: const [0.0, 0.7]
              )),
        ),

        Positioned(
          left: UIDefine.getScreenWidth(5), right: UIDefine.getScreenWidth(5),
            top: UIDefine.getScreenWidth(6),
          child: _subBar(
              popBack: popBack,
              smList: smList
          )
        ),

        Positioned(
          left: UIDefine.getScreenWidth(5), right: UIDefine.getScreenWidth(5),
            top: UIDefine.getScreenWidth(30),
          child: _artistInfoView(data, adData, bShowMore, seeMoreAction: () { seeMoreAction(); })
        )
      ],
    );
  }

  Widget _subBar({
    required VoidCallback popBack,
    required List<Sm> smList
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: popBack,
          child: Image.asset('assets/icon/btn/btn_arrow_03_left.png'),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: _getSmsIcons(smList),
        ),
      ],
    );
  }

  Widget _artistInfoView(ExploreMainResponseData data,
      ExploreArtistDetailResponseData adData, bool bSeeMore,
      {required VoidCallback seeMoreAction}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// 頭貼 + 畫家名
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                decoration: AppTheme.style.baseGradient(radius: 100),
                padding: const EdgeInsets.all(2),
                child: CircleNetworkIcon(
                    networkUrl: data.avatarUrl, radius: 35)
            ),
            SizedBox(width: UIDefine.getScreenWidth(2.5)),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      constraints: BoxConstraints(maxWidth: UIDefine.getWidth()*0.55),
                      child: Text(data.artistName,
                          style: AppTextStyle.getBaseStyle(color: Colors.white, fontSize: UIDefine.fontSize18, fontWeight: FontWeight.w500)),
                    ),

                    SizedBox(width: UIDefine.getScreenWidth(1)),

                    Image.asset('assets/icon/icon/icon_check_ok_02.png',
                        width: UIDefine.getScreenWidth(5.55), height: UIDefine.getScreenWidth(5.55)),

                    SizedBox(width: UIDefine.getScreenWidth(1)),

                    GestureDetector(
                      onTap: () => callBack('polygon'),
                      child: Image.asset('assets/icon/btn/btn_polygon_01.png',
                          width: UIDefine.getScreenWidth(5.55), height: UIDefine.getScreenWidth(5.55))
                    )
                  ],
                ),
                const SizedBox(height: 5),
                Text('BY ${adData.creatorName}',
                  style: AppTextStyle.getBaseStyle(color: AppColors.textGrey, fontSize: UIDefine.fontSize14)),
              ],
            )
          ],
        ),

        SizedBox(height: UIDefine.getScreenWidth(2.5)),

        /// 畫家簡介 + 向下箭頭
        GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: seeMoreAction,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SizedBox(
                width: UIDefine.getScreenWidth(80),
                child: Text(
                  bSeeMore ? adData.artistInfo : _shortString(adData.artistInfo),
                  style: AppTextStyle.getBaseStyle(
                      color: AppColors.textWhite,
                      fontSize: UIDefine.fontSize12,
                      fontWeight: FontWeight.w500),
                )
              ),

              Image.asset(AppImagePath.arrowDown)
            ],
          )
        ),

        SizedBox(height: UIDefine.getScreenWidth(5)),

        /// 畫家數值資訊
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _amountView(BaseViewModel().numberCompatFormat(adData.list.total.toString()), tr("items"), false),
            _amountView(BaseViewModel().numberCompatFormat(adData.owners.toString()), tr('owners'), false),
            _amountView(BaseViewModel().numberCompatFormat(adData.volume.toString()), tr('tradeVol'), true),
            _amountView(BaseViewModel().numberCompatFormat(adData.floorPrice.toString()), tr('floorPrice'), true)
          ],
        ),

        SizedBox(height: UIDefine.getScreenWidth(2.5))
      ],
    );
  }

  List<Widget> _getSmsIcons(List<Sm> smList) {
    List<Widget> widgets = [];
    for (int i = 0; i < smList.length; i++) {
      switch(smList[i].type) {
        case 'twitter':
          widgets.add(
            GestureDetector(
              onTap: () => callBack(smList[i].data),
              child: Image.asset('assets/icon/btn/btn_twitter_white_01.png',
                  width: UIDefine.getScreenWidth(6), height: UIDefine.getScreenWidth(6))
            )
          );
          break;
        case 'discord':
          widgets.add(
              GestureDetector(
                  onTap: () => callBack(smList[i].data),
                  child: Image.asset('assets/icon/btn/btn_discord_white_01.png',
                      width: UIDefine.getScreenWidth(6), height: UIDefine.getScreenWidth(6))
              )
          );
          break;
        case 'youtube':
          widgets.add(
              GestureDetector(
                  onTap: () => callBack(smList[i].data),
                  child: Image.asset('assets/icon/btn/btn_yt_white_01.png',
                      width: UIDefine.getScreenWidth(6), height: UIDefine.getScreenWidth(6))
              )
          );
          break;
        case 'instagram':
          widgets.add(
              GestureDetector(
                  onTap: () => callBack(smList[i].data),
                  child: Image.asset('assets/icon/btn/btn_ig_white_01.png',
                      width: UIDefine.getScreenWidth(6), height: UIDefine.getScreenWidth(6))
              )
          );
          break;
        case 'facebook':
          widgets.add(
              GestureDetector(
                  onTap: () => callBack(smList[i].data),
                  child: Image.asset('assets/icon/btn/btn_fb_white_01.png',
                      width: UIDefine.getScreenWidth(6), height: UIDefine.getScreenWidth(6))
              )
          );
          break;
      }
      widgets.add(SizedBox(width: UIDefine.getScreenWidth(5)));
    }
    widgets.add(
        GestureDetector(
            onTap: () => callBack('Share'),
            child: Image.asset('assets/icon/btn/btn_share_01.png',
                width: UIDefine.getScreenWidth(6), height: UIDefine.getScreenWidth(6))
        )
    );
    return widgets;
  }

  Widget artistInfo(dynamic data) {
    BaseViewModel viewModel = BaseViewModel();
    return Padding(
      padding: EdgeInsets.fromLTRB(UIDefine.getScreenWidth(5), 0, UIDefine.getScreenWidth(10), 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _amountView(viewModel.numberCompatFormat(data.items.toString()), tr("items"), false),
              _amountView(viewModel.numberCompatFormat(data.owners.toString()), tr('owners'), false),
              _amountView(viewModel.numberCompatFormat(data.volume.toString()), tr('tradeVol'), true),
            ],
          ),

          SizedBox(height: UIDefine.getScreenWidth(5.5)),

          _amountView(data.floorPrice.toString(), tr('floorPrice'), true),

        ],
      )
    );
  }

  Widget _amountView(String amount, String title, bool bIcon) {
    return Column(
      // crossAxisAlignment: CrossAxisAlignment.start, // 第一版UI
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            bIcon? Image.asset('assets/icon/coins/icon_tether_01.png', width: UIDefine.getScreenWidth(4.44), height: UIDefine.getScreenWidth(4.44)) : Container(),
            bIcon? const SizedBox(width: 4) : const SizedBox(),
            Text(amount,
              // style: CustomTextStyle.getBaseStyle(color: AppColors.textBlack, fontSize: UIDefine.fontSize20, fontWeight: FontWeight.w500),), // 第一版UI
              style: AppTextStyle.getBaseStyle(color: AppColors.textWhite, fontSize: UIDefine.fontSize18, fontWeight: FontWeight.w500),),
          ],
        ),
        Text(title,
          // style: CustomTextStyle.getBaseStyle(color: AppColors.dialogGrey, fontSize: UIDefine.fontSize14, fontWeight: FontWeight.w400),), // 第一版UI
          style: AppTextStyle.getBaseStyle(color: AppColors.textWhite, fontSize: UIDefine.fontSize14, fontWeight: FontWeight.w400),),
      ],
    );
  }

  Widget productView(BuildContext context, dynamic data) {
    return SizedBox(
        width: UIDefine.getScreenWidth(43.4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                if (GlobalData.userToken != '') {
                  BaseViewModel().pushPage(context, ExploreItemDetailPage(itemId: data.itemId));
                } else {
                  BaseViewModel().pushReplacement(context, MainPage(type: AppNavigationBarType.typeLogin));
                }
              },
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                child: GraduallyNetworkImage(
                  width: UIDefine.getScreenWidth(43.4),
                  height: UIDefine.getScreenWidth(30),
                  fit: BoxFit.cover,
                  imageUrl: data.imgUrl,
                )
              )
            ),

            const SizedBox(height: 4),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                    child: Text(
                      data.name,
                      style: AppTextStyle.getBaseStyle(fontSize: UIDefine.fontSize12, fontWeight: FontWeight.w500),
                    )
                ),
              ],
            ),

            const SizedBox(height: 4),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Image.asset('assets/icon/coins/icon_tether_01.png', width: UIDefine.getScreenWidth(4), height: UIDefine.getScreenWidth(4)),
                    const SizedBox(width: 6),
                    Text(
                      BaseViewModel().numberFormat(data.price),
                      style: AppTextStyle.getBaseStyle(color: AppColors.textGrey, fontSize: UIDefine.fontSize12, fontWeight: FontWeight.w500),
                    )
                  ],
                ),
                Row(
                  children: [ num.parse(data.growAmount) > 0 ?
                    Image.asset('assets/icon/icon/icon_trend_up_01.png')
                       :
                    Image.asset('assets/icon/icon/icon_trend_down_01.png'),
                    Text(
                      BaseViewModel().numberFormat(data.growAmount),
                      style: AppTextStyle.getBaseStyle(color: AppColors.textGrey, fontSize: UIDefine.fontSize12, fontWeight: FontWeight.w500),
                    ),
                  ],
                )
              ],
            )
          ],
        )
    );
  }

  String _shortString(String sValue) {
    return sValue.length > 80 ? '${sValue.substring(0, 80)}....' : sValue;
  }

  double _getHeightForInfoView(String artistInfo) {
    int length = artistInfo.length;
    if (length <= 80 ) return UIDefine.getScreenWidth(90);
    if (length <= 160 ) return UIDefine.getScreenWidth(95);
    if (length <= 240 ) return UIDefine.getScreenWidth(100);
    if (length <= 320 ) return UIDefine.getScreenWidth(105);
    if (length <= 400 ) return UIDefine.getScreenWidth(110);
    if (length <= 480 ) return UIDefine.getScreenWidth(115);
    if (length <= 560 ) return UIDefine.getScreenWidth(120);
    if (length <= 640 ) return UIDefine.getScreenWidth(125);
    return UIDefine.getScreenWidth(130);
  }

}