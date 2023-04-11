import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:format/format.dart';
import 'package:gif/gif.dart';
import 'package:treasure_nft_project/constant/extension/num_extension.dart';
import 'package:treasure_nft_project/constant/theme/app_animation_path.dart';
import 'package:treasure_nft_project/constant/theme/app_image_path.dart';
import 'package:treasure_nft_project/constant/theme/app_style.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';
import 'package:treasure_nft_project/utils/app_text_style.dart';
import 'package:treasure_nft_project/view_models/base_view_model.dart';
import 'package:treasure_nft_project/views/airdrop/airdrop_share_page.dart';
import 'package:treasure_nft_project/widgets/button/login_button_widget.dart';
import 'package:treasure_nft_project/widgets/gradient_third_text.dart';
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
  BoxAnimateStatus status = BoxAnimateStatus.opening;
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
        types.add(AirdropRewardType.MEDAL);
        types.add(AirdropRewardType.ITEM);
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
            ///開箱的獎勵結果
            Opacity(opacity: showReward ? 1 : 0, child: buildCurrentReward()),

            ///判斷動畫
            status != BoxAnimateStatus.next
                ? buildOpenAnimate()
                : buildWaitAnimate(),

            ///顯示最後獎勵用
            Visibility(
                visible: status == BoxAnimateStatus.finish &&
                    rewardType != AirdropRewardType.EMPTY,
                child: _buildFinishReward()),

            ///按鈕顯示
            Opacity(
                opacity: status == BoxAnimateStatus.opening ? 0 : 1,
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  LoginButtonWidget(
                      isFillWidth: false,
                      btnText: status == BoxAnimateStatus.finish
                          ? tr("finish")
                          : tr("next"),
                      onPressed: () {
                        switch (status) {
                          case BoxAnimateStatus.opening:
                            break;
                          case BoxAnimateStatus.next:
                            _onOpenNext();
                            break;
                          case BoxAnimateStatus.finish:
                            _onFinish();
                            break;
                          case BoxAnimateStatus.noNext:
                            _onAllNext();
                            break;
                        }
                      })
                ])),

            ///顯示最後獎勵用
            Visibility(
                visible: status == BoxAnimateStatus.finish &&
                    rewardType != AirdropRewardType.EMPTY,
                child: _buildShareIcon()),
          ],
        ),
      ),
    ));
  }

  Widget buildOpenAnimate() {
    return Gif(
      height: UIDefine.getPixelWidth(300),
      fit: BoxFit.fitHeight,
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
      height: UIDefine.getPixelWidth(300),
      fit: BoxFit.fitHeight,
      image: AssetImage(
          format(AppAnimationPath.airdropWait, {"level": widget.level})),
      autostart: Autostart.loop,
      controller: _controller,
      onFetchCompleted: () {},
    );
  }

  Widget buildCurrentReward() {
    bool showUSDT = false;
    bool showTitle = false;
    num usdt = 0;
    String title = "";
    String context = "";

    switch (currentType) {
      case AirdropRewardType.EMPTY:
        return _buildEmptyReward();
      case AirdropRewardType.MONEY:
        showUSDT = true;
        usdt = reward.reward;
        break;
      case AirdropRewardType.ITEM:
        showUSDT = true;
        showTitle = true;
        usdt = reward.itemPrice;
        title = "NFT";
        context = reward.itemName;
        break;
      case AirdropRewardType.MEDAL:
        showTitle = true;
        title = "勳章";
        context = reward.medalName;
        break;
      case AirdropRewardType.ALL:
      default:
        return const SizedBox();
    }
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      _buildImageIcon(currentType),
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

  Widget _buildImageIcon(AirdropRewardType? type) {
    if (type == null) {
      return const SizedBox();
    }
    bool assetUSDT = type == AirdropRewardType.MONEY;
    String imageUrl;
    switch (type) {
      case AirdropRewardType.ITEM:
        imageUrl = reward.imgUrl;
        break;
      case AirdropRewardType.MEDAL:
        imageUrl = reward.medal;
        break;
      default:
        imageUrl = "";
        break;
    }
    return Container(
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
    );
  }

  Widget _buildFinishReward() {
    List<AirdropRewardType> list = [];
    switch (rewardType) {
      case AirdropRewardType.EMPTY:
      case AirdropRewardType.MONEY:
      case AirdropRewardType.ITEM:
      case AirdropRewardType.MEDAL:
        list.add(rewardType);
        break;
      case AirdropRewardType.ALL:
        list.add(AirdropRewardType.ITEM);
        list.add(AirdropRewardType.MEDAL);
        list.add(AirdropRewardType.MONEY);
        break;
    }
    return Column(
      children: [
        GradientThirdText("您获得了:"),
        Container(
          margin: EdgeInsets.symmetric(vertical: UIDefine.getPixelWidth(10)),
          alignment: Alignment.center,
          child: Row(
              mainAxisSize: MainAxisSize.min,
              children: List<Widget>.generate(list.length, (index) {
                AirdropRewardType imgType = list[index];
                String text = "x1";
                if (imgType == AirdropRewardType.MONEY) {
                  text = "+${reward.reward.removeTwoPointFormat()}";
                }
                return Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: UIDefine.getPixelWidth(5)),
                  child: Stack(children: [
                    _buildImageIcon(imgType),
                    Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Text(text,
                            textAlign: TextAlign.center,
                            style: AppTextStyle.getBaseStyle(
                                color: Colors.white))),
                  ]),
                );
              })),
        ),
      ],
    );
  }

  Widget _buildShareIcon() {
    return Container(
        padding: EdgeInsets.symmetric(
            vertical: UIDefine.getPixelWidth(5),
            horizontal: UIDefine.getPixelWidth(10)),
        color: Colors.transparent,
        child: GestureDetector(
            onTap: _onShare,
            child: Text("share", style: AppTextStyle.getBaseStyle())));
  }

  Widget _buildEmptyReward() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text("No prize...", style: AppTextStyle.getBaseStyle()),
        GradientThirdText("Better luck next time!")
      ],
    );
  }

  /// 顯示抽中的東西
  void _showItem() {
    if (mounted) {
      setState(() {
        showReward = true;
        if (types.isNotEmpty) {
          status = BoxAnimateStatus.next;
        } else {
          if (rewardType == AirdropRewardType.EMPTY) {
            status = BoxAnimateStatus.finish;
          } else {
            status = BoxAnimateStatus.noNext;
          }
        }
      });
    }
  }

  void _onOpenNext() {
    if (mounted) {
      setState(() {
        showReward = false;
        status = BoxAnimateStatus.opening;
        _controller.value = 0;
        _controller.reset();
      });

      setState(() {
        currentType = types.removeLast();
      });
    }
  }

  void _onFinish() {
    Navigator.pop(context);
  }

  void _onAllNext() {
    if (mounted) {
      setState(() {
        showReward = false;
        status = BoxAnimateStatus.finish;
      });
    }
  }

  void _onShare() {
    BaseViewModel().pushOpacityPage(context, AirdropSharePage(level: widget.level,reward: reward));
  }
}
