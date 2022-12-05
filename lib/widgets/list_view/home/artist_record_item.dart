import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:treasure_nft_project/constant/theme/app_colors.dart';
import 'package:treasure_nft_project/constant/theme/app_image_path.dart';
import 'package:treasure_nft_project/constant/theme/app_style.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';
import 'package:treasure_nft_project/models/http/parameter/home_artist_record.dart';
import 'package:treasure_nft_project/view_models/home/home_main_viewmodel.dart';

import '../../../utils/number_format_util.dart';
import '../../../views/explore/data/explore_main_response_data.dart';
import '../../../views/explore/homepage/explore_artist_home_page_view.dart';
import '../../label/coin/tether_coin_widget.dart';

class ArtistRecordItemView extends StatefulWidget {
  const ArtistRecordItemView({super.key, required this.itemData});

  final ArtistRecord itemData;

  @override
  State<StatefulWidget> createState() => _ArtistRecordItem();
}

class _ArtistRecordItem extends State<ArtistRecordItemView> {
  HomeMainViewModel viewModel = HomeMainViewModel();
  bool show = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: show
          ? AppStyle().styleColorsRadiusBackground(color: AppColors.homeArtBg)
          : null,
      padding: show
          ? EdgeInsets.symmetric(vertical: UIDefine.getScreenHeight(2))
          : null,
      child: Column(
        children: [
          GestureDetector(
            onTap: _onShowArt,
            child: Container(
                padding: const EdgeInsets.all(10),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('${widget.itemData.sort}',
                          style: TextStyle(
                              fontSize: UIDefine.fontSize14,
                              fontWeight: FontWeight.w600,
                              color: AppColors.font02)),
                      viewModel.buildSpace(width: 1),

                      /// Avatar
                      SizedBox(
                        height: UIDefine.getWidth() * 0.1,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: CachedNetworkImage(
                            imageUrl: widget.itemData.avatarUrl,
                            fit: BoxFit.fill,
                            errorWidget: (context, url, error) => const Icon(Icons.cancel_rounded),
                          ),
                        ),
                      ),
                      viewModel.buildSpace(width: 1),

                      Expanded(
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                            /// NAME
                            Text(widget.itemData.name,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: UIDefine.fontSize14,
                                    color: AppColors.textBlack,
                                    fontWeight: FontWeight.w400)),

                            viewModel.buildSpace(height: 1),

                            /// Vol. & Sales
                            Row(children: [
                              _buildVolView(
                                  tr('lastDayAmount'), widget.itemData.ydayAmt),
                              const SizedBox(width: 20),
                              _buildVolView(tr('transcationAmount'),
                                  widget.itemData.amtTotal),
                            ])
                          ])),
                      viewModel.buildSpace(width: 5),
                      InkWell(
                        onTap: _flipView,
                        child: Container(
                          alignment: Alignment.center,
                          width: UIDefine.getScreenWidth(4),
                          child: Image.asset(
                            show
                                ? AppImagePath.upArrowGrey
                                : AppImagePath.downArrowGrey,
                          ),
                        ),
                      ),
                    ])),
          ),
          Visibility(
              visible: show,
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: UIDefine.getScreenWidth(5)),
                child: _subView(context),
              ))
        ],
      ),
    );
  }

  Widget _buildVolView(String title, String count) {
    return Expanded(
        child:
            Row(mainAxisAlignment: MainAxisAlignment.start, children: [
      Expanded(
        child: Wrap(
          alignment: WrapAlignment.start,
          children: [
            Text(title,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: TextStyle(
                    fontSize: UIDefine.fontSize12,
                    fontWeight: FontWeight.w400,
                    color: AppColors.font02)),
          ],
        ),
      ),
      Row(children: [
        Text(viewModel.numberCompatFormat(count),
            style: TextStyle(
                fontSize: UIDefine.fontSize14,
                fontWeight: FontWeight.w600,
                color: AppColors.textBlack)),
        const SizedBox(width: 5),
        SizedBox(
            height: UIDefine.getScreenWidth(4),
            child: Image.asset(AppImagePath.tetherImg)),
      ])
    ]));
  }

  Widget _subView(BuildContext context) {
    return Column(
      children: [
        Divider(height: UIDefine.getScreenWidth(4.16)),
        viewModel.buildSpace(height: 0.5),
        Row(
          children: [
            _buildSubItem(
                value: double.parse(widget.itemData.baseItemPrice),
                title: tr('floorPrice'),
                hasCoin: true),
            Expanded(
              child: _buildSubItem(
                  value: widget.itemData.ownerCount.toDouble(),
                  title: tr('owners')),
            ),
            _buildSubItem(
                value: widget.itemData.itemCount.toDouble(),
                title: tr('creator_items')),
          ],
        )
      ],
    );
  }

  Widget _buildSubItem(
      {bool hasCoin = false, required double value, required String title}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(children: [
              Text(NumberFormatUtil().removeTwoPointFormat(value),
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: UIDefine.fontSize14)),
              SizedBox(width: UIDefine.getScreenWidth(1)),
              Visibility(
                  visible: hasCoin,
                  child: TetherCoinWidget(
                    size: UIDefine.getScreenWidth(4),
                  ))
            ]),
            Text(
              title,
              style: TextStyle(
                  fontSize: UIDefine.fontSize12, color: AppColors.dialogGrey),
            ),
          ],
        ),
      ],
    );
  }

  void _flipView() {
    setState(() {
      show = !show;
    });
  }

  void _onShowArt() {
    ExploreMainResponseData data = ExploreMainResponseData(
        artistName: widget.itemData.name,
        artistId: widget.itemData.id,
        avatarUrl: widget.itemData.avatarUrl,
        introPhoneUrl: widget.itemData.introPhoneUrl,
        introPcUrl: widget.itemData.introPcUrl);
    viewModel.pushPage(context, ExploreArtistHomePageView(artistData: data));
  }
}
