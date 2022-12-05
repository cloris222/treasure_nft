
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:treasure_nft_project/constant/call_back_function.dart';
import 'package:treasure_nft_project/constant/global_data.dart';
import 'package:treasure_nft_project/constant/theme/app_colors.dart';
import 'package:treasure_nft_project/view_models/base_view_model.dart';
import 'package:treasure_nft_project/views/main_page.dart';

import '../../../constant/ui_define.dart';
import '../../../widgets/app_bottom_navigation_bar.dart';
import '../../../widgets/label/personal_profile_icon.dart';
import '../data/explore_artist_detail_response_data.dart';
import '../itemdetail/explore_product_detail_page.dart';

class HomePageWidgets {
  static HomePageWidgets? _homePageWidgets;

  HomePageWidgets._();

  factory HomePageWidgets() {
    return _homePageWidgets ??= HomePageWidgets._();
  }

  late onGetStringFunction callBack;

  Widget homePageTop(dynamic data, String creatorName,
      {required onGetStringFunction callBack, required List<Sm> smList}) {
    this.callBack = callBack;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            Column(
              children: [
                CachedNetworkImage(
                  imageUrl: data.introPhoneUrl,
                  fit: BoxFit.fill,
                  errorWidget: (context, url, error) => const Icon(Icons.cancel_rounded),
                ),

                Container(
                  height: UIDefine.getScreenWidth(17),
                ),
              ],
            ),

            Positioned(
                left: UIDefine.getScreenWidth(5), bottom: UIDefine.getScreenWidth(4.16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    PersonalProfileIcon(userId: data.artistId, avatar: data.avatarUrl, width: UIDefine.getScreenWidth(23.33), height: UIDefine.getScreenWidth(23.33)),
                  ],
                )

            ),

            Positioned(
                right: UIDefine.getScreenWidth(5), bottom: UIDefine.getScreenWidth(4.16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: _getSmsIcons(smList),
                    ),
                  ],
                )
            )
          ],
        ),

        Row(
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(UIDefine.getScreenWidth(5), 0,
                  0, UIDefine.getScreenWidth(5)),
              child: Text(data.artistName,
                style: TextStyle(color: Colors.black, fontSize: UIDefine.fontSize24, fontWeight: FontWeight.w600),),
            ),

            SizedBox(width: UIDefine.getScreenWidth(4)),

            Container(
                padding: EdgeInsets.fromLTRB(0, 0, 0, UIDefine.getScreenWidth(5.13)),
                child: Image.asset('assets/icon/icon/icon_check_ok_02.png',
                    width: UIDefine.getScreenWidth(5.55), height: UIDefine.getScreenWidth(5.55))
            ),
          ],
        ),

        Container(
          padding: EdgeInsets.fromLTRB(UIDefine.getScreenWidth(5), 0,
              UIDefine.getScreenWidth(5), 0),
          child: Visibility(
            visible: creatorName==''? false : true,
            child: Text(creatorName,
              style: TextStyle(color: Colors.black, fontSize: UIDefine.fontSize14, fontWeight: FontWeight.w600),),
          ),
        ),
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
              child: Image.asset('assets/icon/footer/btn_twitter_01_nor.png',
                  width: UIDefine.getScreenWidth(6), height: UIDefine.getScreenWidth(6))
            )
          );
          break;
        case 'discord':
          widgets.add(
              GestureDetector(
                  onTap: () => callBack(smList[i].data),
                  child: Image.asset('assets/icon/footer/btn_discord_01_nor.png',
                      width: UIDefine.getScreenWidth(6), height: UIDefine.getScreenWidth(6))
              )
          );
          break;
        case 'youtube':
          widgets.add(
              GestureDetector(
                  onTap: () => callBack(smList[i].data),
                  child: Image.asset('assets/icon/footer/btn_yt_01_nor.png',
                      width: UIDefine.getScreenWidth(6), height: UIDefine.getScreenWidth(6))
              )
          );
          break;
        case 'instagram':
          widgets.add(
              GestureDetector(
                  onTap: () => callBack(smList[i].data),
                  child: Image.asset('assets/icon/footer/btn_ig_01_nor.png',
                      width: UIDefine.getScreenWidth(6), height: UIDefine.getScreenWidth(6))
              )
          );
          break;
        case 'facebook':
          widgets.add(
              GestureDetector(
                  onTap: () => callBack(smList[i].data),
                  child: Image.asset('assets/icon/footer/btn_fb_01_nor.png',
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
            child: Image.asset('assets/icon/icon/icon_share_03.png',
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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            bIcon? Image.asset('assets/icon/coins/icon_tether_01.png', width: UIDefine.getScreenWidth(4.44), height: UIDefine.getScreenWidth(4.44)) : Container(),
            const SizedBox(width: 4),
            Text(amount,
              style: TextStyle(color: AppColors.textBlack, fontSize: UIDefine.fontSize20, fontWeight: FontWeight.w600),),
          ],
        ),
        Text(title,
          style: TextStyle(color: AppColors.dialogGrey, fontSize: UIDefine.fontSize14, fontWeight: FontWeight.w400),),
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
            child: CachedNetworkImage(
              imageUrl: data.imgUrl,
              height: UIDefine.getScreenWidth(43.4),
              width: UIDefine.getScreenWidth(43.4),
              errorWidget: (context, url, error) => const Icon(Icons.cancel_rounded),
            ),
          ),

          const SizedBox(height: 4),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: UIDefine.getScreenWidth(25),
                child: Text(
                  data.name,
                  style: TextStyle(fontSize: UIDefine.fontSize12, fontWeight: FontWeight.w600),
                )
              ),
              Row(
                children: [
                  Image.asset('assets/icon/icon/icon_trend_up_01.png'),
                  Text(
                    BaseViewModel().numberFormat(data.growAmount),
                    style: TextStyle(color: AppColors.growPrice, fontSize: UIDefine.fontSize12, fontWeight: FontWeight.w600),
                  ),
                ],
              )
            ],
          ),

          const SizedBox(height: 4),

          Row(
            children: [
              Image.asset('assets/icon/coins/icon_tether_01.png', width: UIDefine.getScreenWidth(4), height: UIDefine.getScreenWidth(4)),
              const SizedBox(width: 6),
              Text(
                BaseViewModel().numberFormat(data.price),
                style: TextStyle(fontSize: UIDefine.fontSize12, fontWeight: FontWeight.w500),
              ),
            ],
          )
        ],

      )
    );
  }



}