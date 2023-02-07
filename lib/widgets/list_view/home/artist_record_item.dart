import 'package:flutter/material.dart';
import 'package:treasure_nft_project/constant/enum/style_enum.dart';
import 'package:treasure_nft_project/constant/subject_key.dart';
import 'package:treasure_nft_project/constant/theme/app_colors.dart';
import 'package:treasure_nft_project/constant/theme/app_image_path.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';
import 'package:treasure_nft_project/models/http/parameter/collect_top_info.dart';
import 'package:treasure_nft_project/utils/number_format_util.dart';
import 'package:treasure_nft_project/utils/observer_pattern/home/home_observer.dart';
import 'package:treasure_nft_project/view_models/home/home_main_viewmodel.dart';
import 'package:treasure_nft_project/widgets/label/gradually_network_image.dart';
import 'package:treasure_nft_project/utils/app_text_style.dart';

import '../../../views/explore/data/explore_main_response_data.dart';
import '../../../views/explore/homepage/explore_artist_home_page_view.dart';

class ArtistRecordItemView extends StatefulWidget {
  const ArtistRecordItemView(
      {super.key,
      required this.itemData,
      required this.index,
      required this.viewModel,
      required this.subjectKey});

  final CollectTopInfo itemData;
  final int index;
  final HomeMainViewModel viewModel;
  final String subjectKey;

  @override
  State<StatefulWidget> createState() => _ArtistRecordItem();
}

class _ArtistRecordItem extends State<ArtistRecordItemView>
    with SingleTickerProviderStateMixin {
  HomeMainViewModel get viewModel {
    return widget.viewModel;
  }

  late AnimationController controller;
  late HomeObserver observer;

  @override
  void initState() {
    controller = AnimationController(
      lowerBound: 0,
      upperBound: 360,
      duration: const Duration(milliseconds: 1200),
      reverseDuration: const Duration(microseconds: 1),
      vsync: this,
    )..addListener(() => setState(() {})); // 监听动画变更，更新页面

    observer = HomeObserver(widget.subjectKey, onNotify: (notification) {
      if (mounted) {
        if (notification.key == widget.subjectKey) {
          controller.forward(from: 270);
        } else if (notification.key == SubjectKey.keyHomeAnimationReset) {
          controller.reset();
        } else if (notification.key == SubjectKey.keyHomeAnimationWait) {
          controller.value = 270;
        }
      }
    });
    viewModel.homeSubject.registerObserver(observer);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    viewModel.homeSubject.unregisterObserver(observer);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return viewModel.needRecordAnimation
        ? AnimatedBuilder(
            builder: (BuildContext context, Widget? child) {
              return Transform(
                transform: Matrix4.identity()
                  ..setEntry(3, 2, 0.0001) // 第三参数定义视图距离，值越小物体就离你越远，看着就有立体感
                  // 旋转Y轴角度，pi为圆半径，animation.value为动态获取的动画值
                  ..rotateX(3.14 * controller.value / 180),
                alignment: FractionalOffset.center, // 以轴中心开始动画
                child: child,
              );
            },
            animation: controller,
            child: _buildItem(),
          )
        : _buildItem();
  }

  Widget _buildItem() {
    return Column(
      children: [
        GestureDetector(
          onTap: _onShowArt,
          child: Container(
              padding: EdgeInsets.all(UIDefine.getPixelHeight(10)),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('${widget.index + 1}',
                        style: AppTextStyle.getBaseStyle(
                            fontSize: UIDefine.fontSize16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                            fontFamily: AppTextFamily.Posterama1927)),
                    viewModel.buildSpace(width: 1),

                    /// Avatar
                    SizedBox(
                      height: UIDefine.getPixelHeight(50),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: GraduallyNetworkImage(
                          imageUrl: widget.itemData.avatarUrl,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    viewModel.buildSpace(width: 1.5),

                    Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          /// NAME
                          Text(widget.itemData.artistName,
                              overflow: TextOverflow.ellipsis,
                              style: AppTextStyle.getBaseStyle(
                                  fontSize: UIDefine.fontSize14,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400)),

                          viewModel.buildSpace(height: 1),

                          _buildVolView('${widget.itemData.volume}'),
                        ]),
                    const Spacer(),
                    Text(
                        '${widget.itemData.growthRate >= 0 ? '+' : ''} ${NumberFormatUtil().removeTwoPointFormat(widget.itemData.growthRate)}%',
                        style: AppTextStyle.getBaseStyle(
                            color: widget.itemData.growthRate >= 0
                                ? AppColors.rateGreen
                                : AppColors.rateRed,
                            fontSize: UIDefine.fontSize16,
                            fontWeight: FontWeight.w600,
                            fontFamily: AppTextFamily.Posterama1927)),
                    viewModel.buildSpace(width: 1.5),
                  ])),
        ),
      ],
    );
  }

  Widget _buildVolView(String count) {
    return Row(children: [
      SizedBox(
          height: UIDefine.getScreenWidth(4),
          child: Image.asset(AppImagePath.tetherImg)),
      const SizedBox(width: 5),
      Text(viewModel.numberCompatFormat(count),
          style: AppTextStyle.getBaseStyle(
              fontSize: UIDefine.fontSize12,
              fontWeight: FontWeight.w600,
              color: AppColors.textSixBlack,
              fontFamily: AppTextFamily.Posterama1927)),
    ]);
  }

  void _onShowArt() {
    ExploreMainResponseData data = ExploreMainResponseData(
        artistName: widget.itemData.artistName,
        artistId: widget.itemData.artistId,
        avatarUrl: widget.itemData.avatarUrl,
        introPhoneUrl: widget.itemData.introPhoneUrl,
        introPcUrl: widget.itemData.introPcUrl);
    viewModel.pushPage(context, ExploreArtistHomePageView(artistData: data));
  }
}
