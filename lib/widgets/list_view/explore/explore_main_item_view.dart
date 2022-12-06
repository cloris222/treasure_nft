import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:treasure_nft_project/view_models/base_view_model.dart';
import 'package:treasure_nft_project/views/explore/homepage/explore_artist_home_page_view.dart';

import '../../../constant/ui_define.dart';
import '../../../views/explore/data/explore_main_response_data.dart';
import '../../label/personal_profile_icon.dart';

class ExploreMainItemView extends StatefulWidget {
  const ExploreMainItemView({super.key, required this.exploreMainResponseData});

  final ExploreMainResponseData exploreMainResponseData;

  @override
  State<StatefulWidget> createState() => _ExploreMainItemView();
}

class _ExploreMainItemView extends State<ExploreMainItemView> {
  ExploreMainResponseData get exploreMainResponseData {
    return widget.exploreMainResponseData;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => BaseViewModel().pushPage(context, ExploreArtistHomePageView(artistData: exploreMainResponseData)),
      child: Stack(
        children: [
          Card(
            margin: EdgeInsets.fromLTRB(UIDefine.getScreenWidth(5), 0, UIDefine.getScreenWidth(5), UIDefine.getScreenWidth(0)),
            elevation: 3,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10)),
                  child: Container(
                    alignment: Alignment.topCenter,
                    // height: UIDefine.getScreenWidth(40),
                    child: CachedNetworkImage(
                      imageUrl: exploreMainResponseData.introPhoneUrl,
                      fit: BoxFit.fill,
                      errorWidget: (context, url, error) => const Icon(Icons.cancel_rounded),
                    ),
                  ),
                ),
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10)),
                  child: Container(
                    height: UIDefine.getScreenWidth(17),
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),

          Positioned(
              left: UIDefine.getScreenWidth(9.72), bottom: UIDefine.getScreenWidth(4.16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  PersonalProfileIcon(userId: exploreMainResponseData.artistId, avatar: exploreMainResponseData.avatarUrl),

                  SizedBox(width: UIDefine.getScreenWidth(4)),

                  Container(
                    padding: EdgeInsets.fromLTRB(0, 0, 0, UIDefine.getScreenWidth(4.3)),
                    child: Text(exploreMainResponseData.artistName,
                      style: TextStyle(color: Colors.black, fontSize: UIDefine.fontSize14, fontWeight: FontWeight.w500),),
                  ),

                  SizedBox(width: UIDefine.getScreenWidth(2.4)),

                  Container(
                      padding: EdgeInsets.fromLTRB(0, 0, 0, UIDefine.getScreenWidth(5.13)),
                      child: Image.asset('assets/icon/icon/icon_check_ok_02.png',
                          width: UIDefine.getScreenWidth(3.33), height: UIDefine.getScreenWidth(3.33))
                  ),
                ],
              )
          )
        ],
      )
    );
  }
}