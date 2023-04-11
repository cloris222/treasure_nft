import 'package:flutter/material.dart';
import 'package:format/format.dart';
import 'package:gif/gif.dart';
import 'package:treasure_nft_project/constant/extension/num_extension.dart';
import 'package:treasure_nft_project/constant/theme/app_animation_path.dart';
import 'package:treasure_nft_project/constant/theme/app_image_path.dart';
import 'package:treasure_nft_project/constant/theme/app_style.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';
import 'package:treasure_nft_project/utils/app_text_style.dart';
import 'package:treasure_nft_project/widgets/label/gradually_network_image.dart';

import '../../constant/enum/airdrop_enum.dart';
import '../../models/http/parameter/airdrop_box_reward.dart';
import 'airdrop_common_view.dart';

class AirdropOpenPage extends StatefulWidget {
  const AirdropOpenPage({Key? key, required this.level, required this.reward})
      : super(key: key);
  final int level;
  final AirdropBoxReward reward;

  @override
  State<AirdropOpenPage> createState() => _AirdropOpenPageState();
}

class _AirdropOpenPageState extends State<AirdropOpenPage>
    with TickerProviderStateMixin, AirdropCommonView {
  late GifController _controller;
  bool showOpen = true;
  bool showReward = false;

  /// 獎勵清單
  AirdropBoxReward get reward => widget.reward;
  late AirdropRewardType rewardType;

  List<AirdropRewardType> types = [];

  AirdropRewardType? currentType;

  @override
  void initState() {
    initReward();
    _controller = GifController(vsync: this);
    _controller.value = 0;
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void initReward() {
    rewardType = getRewardType(reward.rewardType);
    switch (rewardType) {
      case AirdropRewardType.EMPTY:
      case AirdropRewardType.MONEY:
      case AirdropRewardType.ITEM:
      case AirdropRewardType.MEDAL:
        types.add(rewardType);
        break;
      case AirdropRewardType.ALL:
        types.add(AirdropRewardType.MONEY);
        types.add(AirdropRewardType.ITEM);
        types.add(AirdropRewardType.MEDAL);
        break;
    }
    currentType = types.removeLast();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(AppImagePath.airdropAnimateBg),
              fit: BoxFit.fill)),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Opacity(opacity: showReward ? 1 : 0, child: buildCurrentReward()),
            showOpen ? buildOpenAnimate() : buildWaitAnimate(),
          ],
        ),
      ),
    ));
  }

  Widget buildOpenAnimate() {
    return Gif(
      image: AssetImage(
          format(AppAnimationPath.airdropOpen, {"level": widget.level})),
      autostart: Autostart.once,
      controller: _controller,
      onFetchCompleted: () {
        Future.delayed(const Duration(milliseconds: 1000)).then((value) {
          _showItem();
        });
      },
    );
  }

  Widget buildWaitAnimate() {
    return Gif(
      image: AssetImage(
          format(AppAnimationPath.airdropWait, {"level": widget.level})),
      autostart: Autostart.loop,
      controller: _controller,
      onFetchCompleted: () {},
    );
  }

  /// 顯示抽中的東西
  void _showItem() {
    if (mounted) {
      setState(() {
        showReward = true;
        // currentType = types.removeLast();
      });
    }
  }

  Widget buildCurrentReward() {
    bool showUSDT = false;
    bool showTitle = false;
    bool assetUSDT = false;
    num usdt = 0;
    String title = "";
    String context = "";
    String imageUrl = "";

    switch (currentType) {
      case AirdropRewardType.EMPTY:
        return Text("empty", style: AppTextStyle.getBaseStyle());
      case AirdropRewardType.MONEY:
        showUSDT = true;
        assetUSDT = true;
        usdt = reward.reward;
        break;
      case AirdropRewardType.ITEM:
        showUSDT = true;
        showTitle = true;
        usdt = reward.itemPrice;
        title = "NFT";
        context = reward.itemName;
        imageUrl = reward.imgUrl;
        break;
      case AirdropRewardType.MEDAL:
        showTitle = true;
        title = "勳章";
        context = reward.medalName;
        imageUrl = reward.medal;
        break;
      case AirdropRewardType.ALL:
      default:
        return const SizedBox();
    }
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Container(
        height: UIDefine.getPixelWidth(80),
        width: UIDefine.getPixelWidth(80),
        decoration: AppStyle().baseFlipGradient(radius: 10),
        padding: EdgeInsets.all(UIDefine.getPixelWidth(1)),
        child: Center(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: assetUSDT
                ? Image.asset(
                    AppImagePath.airdropUSDT,
                    fit: BoxFit.cover,
                  )
                : GraduallyNetworkImage(
                    imageUrl: imageUrl,
                    fit: BoxFit.cover,
                  ),
          ),
        ),
      ),
      SizedBox(width: UIDefine.getPixelWidth(5)),
      Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Opacity(
              opacity: showTitle ? 1 : 0,
              child: Text(title, style: AppTextStyle.getBaseStyle())),
          Opacity(
              opacity: showTitle ? 1 : 0,
              child: Text(context, style: AppTextStyle.getBaseStyle())),
          Opacity(
              opacity: showUSDT ? 1 : 0,
              child: Text("價值", style: AppTextStyle.getBaseStyle())),
          Opacity(
              opacity: showUSDT ? 1 : 0,
              child: Text(usdt.removeTwoPointFormat(),
                  style: AppTextStyle.getBaseStyle())),
        ],
      )
    ]);
  }
}
