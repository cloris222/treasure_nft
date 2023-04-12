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
import 'package:treasure_nft_project/widgets/label/coin/tether_coin_widget.dart';
import 'package:treasure_nft_project/widgets/label/icon/base_icon_widget.dart';

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
    types = getRewardList(rewardType, false);
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
                      margin: EdgeInsets.symmetric(
                          vertical: UIDefine.getPixelWidth(5)),
                      padding: EdgeInsets.symmetric(
                          horizontal: UIDefine.getPixelWidth(20),
                          vertical: UIDefine.getPixelWidth(5)),
                      radius: 22,
                      isFillWidth: false,
                      btnText: status == BoxAnimateStatus.finish
                          ? tr("finish")
                          : tr("Next"),
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
        title = tr("nft");
        context = reward.itemName;
        break;
      case AirdropRewardType.MEDAL:
        showTitle = true;
        title = tr("appMedal");
        context = reward.medalName;
        break;
      case AirdropRewardType.ALL:
      default:
        return const SizedBox();
    }
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      buildRewardIcon(reward, currentType),
      SizedBox(width: UIDefine.getPixelWidth(5)),
      Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Opacity(
              opacity: showTitle ? 1 : 0,
              child: Text(title,
                  style: AppTextStyle.getBaseStyle(
                      color: const Color(0xFFF5F5F5),
                      fontWeight: FontWeight.w700,
                      fontSize: UIDefine.fontSize20))),
          Opacity(
              opacity: showTitle ? 1 : 0,
              child: Text("#$context",
                  style: AppTextStyle.getBaseStyle(
                      color: const Color(0xFFE4DC6F),
                      fontWeight: FontWeight.w400,
                      fontSize: UIDefine.fontSize10))),
          Opacity(
              opacity: showUSDT ? 1 : 0,
              child: Padding(
                padding:
                    EdgeInsets.symmetric(vertical: UIDefine.getPixelWidth(2.5)),
                child: Text(tr("itemValue"),
                    style: AppTextStyle.getBaseStyle(
                        fontSize: UIDefine.fontSize8,
                        color: Colors.white.withOpacity(0.38),
                        fontWeight: FontWeight.w400)),
              )),
          Opacity(
              opacity: showUSDT ? 1 : 0,
              child: Container(
                decoration: AppStyle().baseBolderGradient(radius: 3),
                padding: EdgeInsets.all(UIDefine.getPixelWidth(5)),
                margin:
                    EdgeInsets.symmetric(vertical: UIDefine.getPixelWidth(2.5)),
                child: Row(
                  children: [
                    TetherCoinWidget(size: UIDefine.getPixelWidth(15)),
                    Text("  ${usdt.removeTwoPointFormat()} USDT",
                        style: AppTextStyle.getBaseStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: UIDefine.fontSize10,
                            color: Colors.white)),
                  ],
                ),
              )),
        ],
      )
    ]);
  }

  Widget _buildFinishReward() {
    List<AirdropRewardType> list = getRewardList(rewardType, true);
    return Column(
      children: [
        GradientThirdText("${tr("youGet")}:",
            size: UIDefine.fontSize20, weight: FontWeight.w700),
        Container(
          margin: EdgeInsets.symmetric(vertical: UIDefine.getPixelWidth(10)),
          alignment: Alignment.center,
          child: Row(
              mainAxisSize: MainAxisSize.min,
              children: List<Widget>.generate(list.length,
                  (index) => buildStackRewardIcon(reward, list[index]))),
        ),
      ],
    );
  }

  Widget _buildShareIcon() {
    return GestureDetector(
      onTap: _onShare,
      child: Container(
          padding: EdgeInsets.symmetric(
              vertical: UIDefine.getPixelWidth(5),
              horizontal: UIDefine.getPixelWidth(10)),
          color: Colors.transparent,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(tr("share"),
                  style: AppTextStyle.getBaseStyle(
                      color: const Color(0xFF00FBFB),
                      fontSize: UIDefine.fontSize18,
                      fontWeight: FontWeight.w700)),
              BaseIconWidget(
                  imageAssetPath: AppImagePath.airdropShare,
                  size: UIDefine.getPixelWidth(20))
            ],
          )),
    );
  }

  Widget _buildEmptyReward() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(tr("noPrize"),
            style: AppTextStyle.getBaseStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: UIDefine.fontSize40)),
        GradientThirdText(
          tr("noPrizeText"),
          size: UIDefine.fontSize24,
          weight: FontWeight.w500,
        )
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
    BaseViewModel().pushOpacityPage(
        context, AirdropSharePage(level: widget.level, reward: reward));
  }
}
