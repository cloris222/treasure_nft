
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:treasure_nft_project/constant/theme/app_colors.dart';

import '../../../constant/ui_define.dart';
import '../../../widgets/label/personal_profile_icon.dart';

class HomePageWidgets {
  const HomePageWidgets._();

  static Widget homePageTop(dynamic data, String creatorName) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            Column(
              children: [
                Container(
                  height: UIDefine.getScreenWidth(16),
                ),

                Image.network(data.introPhoneUrl, height: UIDefine.getScreenWidth(44), fit: BoxFit.fill),

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
                      children: [
                        Image.asset('assets/icon/footer/btn_ig_01_nor.png',
                            width: UIDefine.getScreenWidth(6), height: UIDefine.getScreenWidth(6)),
                        SizedBox(width: UIDefine.getScreenWidth(5)),
                        Image.asset('assets/icon/footer/btn_fb_01_nor.png',
                            width: UIDefine.getScreenWidth(6), height: UIDefine.getScreenWidth(6)),
                        SizedBox(width: UIDefine.getScreenWidth(5)),
                        Image.asset('assets/icon/footer/btn_twitter_01_nor.png',
                            width: UIDefine.getScreenWidth(6), height: UIDefine.getScreenWidth(6)),
                        SizedBox(width: UIDefine.getScreenWidth(5)),
                        Image.asset('assets/icon/footer/btn_tg_01_nor.png',
                            width: UIDefine.getScreenWidth(6), height: UIDefine.getScreenWidth(6)),
                        SizedBox(width: UIDefine.getScreenWidth(5)),
                        Image.asset('assets/icon/footer/btn_discord_01_nor.png',
                            width: UIDefine.getScreenWidth(6), height: UIDefine.getScreenWidth(6)),
                        SizedBox(width: UIDefine.getScreenWidth(5)),
                        Image.asset('assets/icon/icon/icon_share_03.png',
                            width: UIDefine.getScreenWidth(6), height: UIDefine.getScreenWidth(6))
                      ],
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


  static Widget artistInfo(dynamic data) {
    return Padding(
      padding: EdgeInsets.fromLTRB(UIDefine.getScreenWidth(5), 0, UIDefine.getScreenWidth(10), 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _amountView(data.items.toString(), 'Items', false),
              _amountView(data.owners.toString(), 'Owners', false),
              _amountView(data.volume.toString(), 'Total volume', true),
            ],
          ),

          SizedBox(height: UIDefine.getScreenWidth(5.5)),

          _amountView(data.floorPrice.toString(), 'Floor Price', true),

        ],
      )
    );
  }

  static Widget _amountView(String amount, String title, bool bIcon) {
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



}