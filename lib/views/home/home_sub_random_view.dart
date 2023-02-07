import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:treasure_nft_project/constant/enum/style_enum.dart';
import 'package:treasure_nft_project/constant/subject_key.dart';
import 'package:treasure_nft_project/constant/theme/app_colors.dart';
import 'package:treasure_nft_project/constant/theme/app_style.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';
import 'package:treasure_nft_project/models/http/parameter/random_collect_info.dart';
import 'package:treasure_nft_project/utils/app_text_style.dart';
import 'package:treasure_nft_project/utils/observer_pattern/home/home_observer.dart';
import 'package:treasure_nft_project/view_models/home/home_main_viewmodel.dart';
import 'package:treasure_nft_project/views/login/circle_network_icon.dart';
import 'package:treasure_nft_project/widgets/button/login_button_widget.dart';
import 'package:treasure_nft_project/widgets/label/gradually_network_image.dart';

/// 隨機收藏集
class HomeSubRandomView extends StatefulWidget {
  const HomeSubRandomView({Key? key, required this.viewModel})
      : super(key: key);
  final HomeMainViewModel viewModel;

  @override
  State<HomeSubRandomView> createState() => _HomeSubRandomViewState();
}

class _HomeSubRandomViewState extends State<HomeSubRandomView> {
  HomeMainViewModel get viewModel {
    return widget.viewModel;
  }

  late HomeObserver observer;

  @override
  void initState() {
    String key = SubjectKey.keyHomeRandomCollect;
    observer = HomeObserver(key, onNotify: (notification) {
      if (notification.key == key) {
        if (mounted) {
          setState(() {});
        }
      }
    });
    viewModel.homeSubject.registerObserver(observer);
    super.initState();
  }

  @override
  void dispose() {
    viewModel.homeSubject.unregisterObserver(observer);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: UIDefine.getWidth(),
        decoration: AppStyle().buildGradient(
            radius: 0, colors: AppColors.gradientBackgroundColorBg),
        padding: viewModel.getMainPadding(height: 30),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Text(tr('collection-fetured'),
              textAlign: TextAlign.center,
              style: viewModel.getMainTitleStyle()),
          SizedBox(height: UIDefine.getPixelWidth(30)),
          ListView.builder(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) => _buildSubView(
                  context, viewModel.homeRandomCollectList[index]),
              itemCount: viewModel.homeRandomCollectList.length)
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
        Text(' by ${info.creator}', style: viewModel.getContextStyle()),
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
