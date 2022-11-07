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
                // height: UIDefine.getScreenHeight(15),
                padding: EdgeInsets.all(UIDefine.getScreenHeight(1.5)),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text('${widget.itemData.sort}'),
                      viewModel.getPadding(1),

                      /// Avatar
                      SizedBox(
                        height: UIDefine.getScreenWidth(16),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Image.network(widget.itemData.avatarUrl,
                              fit: BoxFit.fill),
                        ),
                      ),
                      viewModel.getPadding(1),

                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            /// NAME
                            Text(
                              widget.itemData.name,
                              style: TextStyle(
                                  fontSize: UIDefine.fontSize14,
                                  color: AppColors.textBlack),
                            ),

                            viewModel.getPadding(1),

                            /// Vol. & Sales
                            Row(
                              children: [
                                Flexible(
                                  child: Text(
                                    tr('tradeVol'),
                                    style: TextStyle(
                                        fontSize: UIDefine.fontSize12,
                                        fontWeight: FontWeight.w300,
                                        color: AppColors.textGrey),
                                  ),
                                ),
                                viewModel.getPadding(1),
                                Text(
                                  viewModel.numberCompatFormat(
                                      widget.itemData.ydayAmt),
                                  style: TextStyle(
                                      fontSize: UIDefine.fontSize14,
                                      fontWeight: FontWeight.w300,
                                      color: AppColors.textBlack),
                                ),
                                viewModel.getPadding(0.5),
                                SizedBox(
                                  height: UIDefine.getScreenWidth(5),
                                  child: Image.asset(AppImagePath.tetherImg),
                                ),
                                viewModel.getPadding(3),
                                Flexible(
                                  child: Text(
                                    tr('transcationAmount'),
                                    style: TextStyle(
                                        fontSize: UIDefine.fontSize12,
                                        fontWeight: FontWeight.w300,
                                        color: AppColors.textGrey),
                                  ),
                                ),
                                viewModel.getPadding(1),
                                Text(
                                  viewModel.numberCompatFormat(
                                      widget.itemData.amtTotal),
                                  style: TextStyle(
                                      fontSize: UIDefine.fontSize14,
                                      fontWeight: FontWeight.w300,
                                      color: AppColors.textBlack),
                                ),
                                viewModel.getPadding(0.5),
                                SizedBox(
                                  height: UIDefine.getScreenWidth(5),
                                  child: Image.asset(AppImagePath.tetherImg),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      InkWell(
                        onTap: _flipView,
                        child: Container(
                            alignment: Alignment.centerRight,
                            child: Image.asset(show
                                ? AppImagePath.upArrowGrey
                                : AppImagePath.downArrowGrey)),
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

  Widget _subView(BuildContext context) {
    return Column(
      children: [
        Divider(height: UIDefine.getScreenWidth(4.16)),
        viewModel.getPadding(0.5),
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(NumberFormatUtil().removeTwoPointFormat(value),
              style: TextStyle(
                  fontWeight: FontWeight.w600, fontSize: UIDefine.fontSize14)),
          SizedBox(width: UIDefine.getScreenWidth(1)),
          Visibility(
              visible: hasCoin,
              child: TetherCoinWidget(
                size: UIDefine.getScreenWidth(5),
              ))
        ]),
        Center(
          child: Text(
            title,
            style: TextStyle(
                fontSize: UIDefine.fontSize14, color: AppColors.dialogGrey),
          ),
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
