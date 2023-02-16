import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:treasure_nft_project/constant/enum/style_enum.dart';
import 'package:treasure_nft_project/constant/theme/app_colors.dart';
import 'package:treasure_nft_project/constant/theme/app_style.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';
import 'package:treasure_nft_project/models/http/parameter/random_collect_info.dart';
import 'package:treasure_nft_project/utils/app_text_style.dart';
import 'package:treasure_nft_project/views/home/home_main_style.dart';
import 'package:treasure_nft_project/views/login/circle_network_icon.dart';
import 'package:treasure_nft_project/widgets/button/login_button_widget.dart';
import 'package:treasure_nft_project/widgets/label/gradually_network_image.dart';

import '../../models/provider/home/home_collect_random_provider.dart';

/// 隨機收藏集
class HomeSubRandomView extends ConsumerWidget with HomeMainStyle {
  const HomeSubRandomView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<RandomCollectInfo> list = ref.watch(homeCollectRandomProvider);
    return Container(
        width: UIDefine.getWidth(),
        decoration: AppStyle().buildGradient(
            radius: 0, colors: AppColors.gradientBackgroundColorBg),
        padding: getMainPadding(height: 30),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Text(tr('collection-fetured'),
              textAlign: TextAlign.center, style: getMainTitleStyle()),
          SizedBox(height: UIDefine.getPixelWidth(30)),
          ListView.builder(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) =>
                  _buildSubView(context, list[index]),
              itemCount: list.length)
        ]));
  }

  Widget _buildSubView(BuildContext context, RandomCollectInfo info) {
    return Column(mainAxisSize: MainAxisSize.min, children: [
      _buildSubImageView(context, info),
      SizedBox(height: UIDefine.getPixelWidth(5)),
      Container(
        alignment: Alignment.centerLeft,
        child: Text(info.collectionName,
            style: AppTextStyle.getBaseStyle(
                fontSize: UIDefine.fontSize18,
                fontWeight: FontWeight.w400,
                color: AppColors.textBlack)),
      ),
      SizedBox(height: UIDefine.getPixelWidth(5)),
      Row(children: [
        SizedBox(
            width: UIDefine.getPixelWidth(30),
            height: UIDefine.getPixelWidth(30),
            child: CircleNetworkIcon(networkUrl: info.creatorAvatarUrl)),
        Text(' by ${info.creator}', style: getContextStyle()),
        const Spacer(),
        LoginButtonWidget(
            btnText: '${tr('total')} ${info.itemCount} ${tr('item')}',
            isFillWidth: false,
            margin: EdgeInsets.zero,
            fontSize: UIDefine.fontSize12,
            fontWeight: FontWeight.w600,
            fontFamily: AppTextFamily.Posterama1927,
            height: UIDefine.getPixelWidth(40),
            padding:
                EdgeInsets.symmetric(horizontal: UIDefine.getPixelWidth(8)),
            radius: 19,
            onPressed: () {})
      ])
    ]);
  }

  Widget _buildSubImageView(BuildContext context, RandomCollectInfo info) {
    return Container(
      height: UIDefine.getPixelWidth(240),
      margin: EdgeInsets.symmetric(vertical: UIDefine.getPixelWidth(10)),
      child: Row(children: [
        Expanded(child: _buildImage(info, 0)),
        SizedBox(width: UIDefine.getPixelWidth(5)),
        SizedBox(
            width: UIDefine.getPixelWidth(100),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: UIDefine.getPixelWidth(3)),
                Expanded(child: _buildImage(info, 1)),
                SizedBox(height: UIDefine.getPixelWidth(5)),
                Expanded(child: _buildImage(info, 2)),
                SizedBox(height: UIDefine.getPixelWidth(5)),
                Expanded(child: _buildImage(info, 3)),
                SizedBox(height: UIDefine.getPixelWidth(3)),
              ],
            ))
      ]),
    );
  }

  Widget _buildImage(RandomCollectInfo info, int index) {
    return info.nftItemInfo.length > index
        ? ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(15)),
            child: SizedBox(
              width: UIDefine.getWidth(),
              height: UIDefine.getHeight(),
              child: GraduallyNetworkImage(
                  imageUrl: info.nftItemInfo[index].imgUrl, fit: BoxFit.cover),
            ))
        : const SizedBox();
  }
}
