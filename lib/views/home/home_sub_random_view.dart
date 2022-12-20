import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:treasure_nft_project/constant/theme/app_colors.dart';
import 'package:treasure_nft_project/constant/theme/app_style.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';
import 'package:treasure_nft_project/models/http/parameter/random_collect_info.dart';
import 'package:treasure_nft_project/view_models/home/home_main_viewmodel.dart';
import 'package:treasure_nft_project/widgets/label/gradually_network_image.dart';

/// 隨機收藏集
class HomeSubRandomView extends StatefulWidget {
  const HomeSubRandomView({Key? key}) : super(key: key);

  @override
  State<HomeSubRandomView> createState() => _HomeSubRandomViewState();
}

class _HomeSubRandomViewState extends State<HomeSubRandomView> {
  HomeMainViewModel viewModel = HomeMainViewModel();
  List<RandomCollectInfo> list = [];

  @override
  void initState() {
    viewModel.getRandomCollect().then((value) => setState(() => list = value));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: UIDefine.getWidth(),
        decoration: AppStyle().buildGradient(
            radius: 0, colors: AppColors.gradientBackgroundColorBg),
        padding: EdgeInsets.symmetric(
            horizontal: UIDefine.getPixelWidth(30),
            vertical: UIDefine.getPixelHeight(30)),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Container(
            padding:
                EdgeInsets.symmetric(horizontal: UIDefine.getWidth() * 0.15),
            child: Text(tr('collection-fetured').toUpperCase(),
                style: TextStyle(
                    color: AppColors.textBlack,
                    fontSize: UIDefine.fontSize24,
                    fontWeight: FontWeight.w500)),
          ),
          ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) =>
                  _buildSubView(context, list[index]),
              itemCount: list.length)
        ]));
  }

  Widget _buildSubView(BuildContext context, RandomCollectInfo info) {
    return SizedBox(
      height: UIDefine.getPixelHeight(300),
      child: Row(
        children: [
          Expanded(child: _buildImage(info, 0)),
          SizedBox(
            width: UIDefine.getPixelWidth(100),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(child: _buildImage(info, 1)),
                Expanded(child: _buildImage(info, 2)),
                Expanded(child: _buildImage(info, 3))
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildImage(RandomCollectInfo info, int index) {
    return info.nftItemInfo.length > index
        ? GraduallyNetworkImage(imageUrl: info.nftItemInfo[index].imgUrl)
        : const SizedBox();
  }
}
