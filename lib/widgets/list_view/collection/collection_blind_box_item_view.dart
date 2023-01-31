import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:format/format.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';
import 'package:treasure_nft_project/view_models/base_view_model.dart';
import 'package:treasure_nft_project/widgets/label/custom_linear_progress.dart';
import 'package:treasure_nft_project/widgets/label/gradually_network_image.dart';
import 'package:treasure_nft_project/utils/app_text_style.dart';

import '../../../constant/call_back_function.dart';
import '../../../constant/theme/app_animation_path.dart';
import '../../../constant/theme/app_colors.dart';
import '../../../views/collection/data/collection_nft_item_response_data.dart';
import '../../../views/wallet/open_box_animation_page.dart';


/// 盲盒 / 空投獎勵 View
class CollectionBlindBoxItemView extends StatefulWidget {
  const CollectionBlindBoxItemView({super.key,
  required this.data,
  required this.index,
  required this.openBlind,
  required this.unlock
  });

  final CollectionNftItemResponseData data;
  final int index;
  final onClickFunction openBlind;
  final onGetIntFunction unlock;

  @override
  State<StatefulWidget> createState() => _CollectionBlindBoxItemView();
}

class _CollectionBlindBoxItemView extends State<CollectionBlindBoxItemView> {
  CollectionNftItemResponseData get data {
    return widget.data;
  }

  bool bOpen = false;
  late num currentLv, unlockLv, currentBuyCount, unlockBuyCount;

  @override
  void initState() {
    super.initState();
    bOpen = data.boxOpen == 'TRUE';
    // currentLv = int.parse(data.rewardNft.currentLevel);
    currentLv = data.rewardNft.currentLevel;
    // unlockLv = int.parse(data.rewardNft.unlockLevel);
    unlockLv = data.rewardNft.unlockLevel;
    // currentBuyCount = int.parse(data.rewardNft.currentBuyCount);
    currentBuyCount = data.rewardNft.currentBuyCount;
    // unlockBuyCount = int.parse(data.rewardNft.unlockBuyCount);
    unlockBuyCount = data.rewardNft.unlockBuyCount;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child:
                /// 空投獎勵             /// 盲盒
        bOpen ? _getAirDropBonusView() : _getBlindBoxView()

    );
  }

  Widget _getBlindBoxView() {
    return Container(
        width: UIDefine.getScreenWidth(44),
        padding: EdgeInsets.all(UIDefine.getScreenWidth(2.5)),
        decoration: const BoxDecoration(
          color: AppColors.textWhite,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              child: Image.asset('assets/icon/img/img_box_01.png',
                width: UIDefine.getScreenWidth(40),
                height: UIDefine.getScreenWidth(30),
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: UIDefine.getScreenWidth(2.77)),

            _gradientButton(tr('openBlindBox')),

            SizedBox(height: UIDefine.getScreenWidth(3)),
          ],
        )
    );
  }

  Widget _getAirDropBonusView() {
    return Container(
        width: UIDefine.getScreenWidth(44),
        padding: EdgeInsets.all(UIDefine.getScreenWidth(2.5)),
        decoration: const BoxDecoration(
          color: AppColors.textWhite,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// 狀態標題 + icon
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset('assets/icon/icon/icon_lock_01.png'),
                const SizedBox(width: 6),
                Text(
                  tr('status_GIVE'),
                  style: AppTextStyle.getBaseStyle(color: AppColors.dialogGrey, fontSize: UIDefine.fontSize16, fontWeight: FontWeight.w500),
                )
              ],
            ),

            SizedBox(height: UIDefine.getScreenWidth(4)),

            /// 中間圖
            Stack(
              alignment: Alignment.center,
              children: [
                _getItemImage(data.imgUrl), // 商品圖

                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      width: UIDefine.getScreenWidth(10),
                      height: UIDefine.getScreenWidth(10),
                      decoration: BoxDecoration(
                        color: AppColors.dialogBlack.withOpacity(0.6),
                        borderRadius: const BorderRadius.all(Radius.circular(100)),
                      ),
                      child: Image.asset('assets/icon/icon/icon_lock_01.png'),
                    ),

                    SizedBox(height: UIDefine.getScreenWidth(2)),

                    /// 進度條
                    Container(
                      width: UIDefine.getScreenWidth(32),
                      padding: EdgeInsets.all(UIDefine.getScreenWidth(2)),
                      decoration: BoxDecoration(
                        color: AppColors.dialogBlack.withOpacity(0.6),
                        borderRadius: const BorderRadius.all(Radius.circular(10)),
                      ),
                      child: Column(
                        children: [
                          /// 等級要求
                          Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text( // 達到Lv幾
                                    format(tr('reach'), {'level': data.rewardNft.unlockLevel.toString()}) ,
                                    style: AppTextStyle.getBaseStyle(color: AppColors.textWhite,
                                        fontSize: UIDefine.fontSize12, fontWeight: FontWeight.w500),
                                  ),
                                  Text( // 目前進度 ex:1/3
                                    data.rewardNft.currentLevel.toString() + '/' + data.rewardNft.unlockLevel.toString(),
                                    style: AppTextStyle.getBaseStyle(color: AppColors.textWhite,
                                        fontSize: UIDefine.fontSize12, fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 1),
                              CustomLinearProgress(
                                needShowFinishIcon: false,
                                needShowPercentage: false,
                                height: UIDefine.getScreenWidth(2),
                                percentage: _getPercentage(data.rewardNft.currentLevel.toString(),
                                    data.rewardNft.unlockLevel.toString()),
                              )
                            ],
                          ),

                          SizedBox(height: UIDefine.getScreenWidth(2)),

                          /// 購買次數要求
                          Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      // _showLockIcon(data.rewardNft.currentLevel.toString(), data.rewardNft.unlockLevel.toString()),
                                      // const SizedBox(width: 4),
                                      Text( // 購買次數幾
                                        format(tr('buyCount'), {'count': data.rewardNft.unlockBuyCount}) ,
                                        style: AppTextStyle.getBaseStyle(color: AppColors.textWhite,
                                            fontSize: UIDefine.fontSize12, fontWeight: FontWeight.w500),
                                      )
                                    ],
                                  ),
                                  Text( // 目前進度 ex:1/3
                                    data.rewardNft.currentBuyCount.toString() + '/' + data.rewardNft.unlockBuyCount.toString(),
                                    style: AppTextStyle.getBaseStyle(color: AppColors.textWhite,
                                        fontSize: UIDefine.fontSize12, fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 1),
                              CustomLinearProgress(
                                needShowFinishIcon: false,
                                needShowPercentage: false,
                                valueColor: _progressValueColor(),
                                backgroundColor: _progressBackgroundColor(),
                                height: UIDefine.getScreenWidth(2),
                                percentage: _getPercentage(data.rewardNft.currentBuyCount.toString(),
                                    data.rewardNft.unlockBuyCount.toString()),
                              )
                            ],
                          ),
                        ],

                      ),
                    ),
                  ],
                )
              ],
            ),

            Text( // 商品名
              data.name,
              style: AppTextStyle.getBaseStyle(
                  color: AppColors.textBlack, fontSize: UIDefine.fontSize18, fontWeight: FontWeight.w500),
            ),

            SizedBox(height: UIDefine.getScreenWidth(3.5)),

            Row(
              children: [
                Image.asset('assets/icon/coins/icon_tether_01.png',
                    // opacity: const AlwaysStoppedAnimation(0.5),
                    width: UIDefine.getScreenWidth(3.7), height: UIDefine.getScreenWidth(3.7)),
                const SizedBox(width: 4),
                Text( // 商品價格
                  data.price.toString(),
                  style: AppTextStyle.getBaseStyle(
                      color: AppColors.textBlack, fontSize: UIDefine.fontSize14, fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ],
        )
    );
  }

  Widget _getItemImage(String imgUrl) {
    return Opacity(
      opacity: 0.3,
      child: GraduallyNetworkImage(
        imageUrl: imgUrl,
        width: UIDefine.getScreenWidth(40),
        height: UIDefine.getScreenWidth(36),
      ),
    );
  }

  Widget _showLockIcon(String currentLv, String requiredLv) {
    if (int.parse(currentLv) < int.parse(requiredLv)) {
      return Image.asset('assets/icon/icon/icon_lock_01.png');
    }
    return const SizedBox();
  }

  Color _getLvTextColor() {
    if (currentLv >= unlockLv) {
      return AppColors.dialogGrey;
    }
    return AppColors.textBlack;
  }

  Color _getBuyCountTextColor() {
    if (currentLv >= unlockLv && currentBuyCount < unlockBuyCount) {
      return AppColors.textBlack;
    }
    return AppColors.dialogGrey;
  }

  double _getPercentage(String current, String required) {
    return int.parse(current) / int.parse(required);
  }

  Color _progressValueColor() {
    if (currentLv < unlockLv) {
      return AppColors.mainThemeButton.withOpacity(0.3);
    }
    return AppColors.mainThemeButton;
  }

  Color _progressBackgroundColor() {
    if (currentLv < unlockLv) {
      return AppColors.transParentHalf.withOpacity(0.3);
    }
    return AppColors.transParentHalf;
  }

  bool _showOpenButton() {
    if (currentLv >= unlockLv && currentBuyCount > unlockBuyCount) {
      return true;
    }
    return false;
  }

  Widget _gradientButton(String sValue) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        widget.openBlind();
        BaseViewModel().pushOpacityPage(
            context,
            OpenBoxAnimationPage(
                imgUrl: data.imgUrl,
                animationPath: AppAnimationPath.showOpenWinsBox,
                backgroundColor: AppColors.opacityBackground.withOpacity(0.65),
                callBack: () {
                  setState(() {
                    bOpen = true;
                  });
                })
        );
      },
      child: Container(
          alignment: Alignment.center,
          height: UIDefine.getScreenWidth(11),
          padding: const EdgeInsets.all(2),
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: AppColors.gradientBaseColorBg),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
              sValue,
            style: AppTextStyle.getBaseStyle(color: AppColors.textWhite,
                fontSize: UIDefine.fontSize14, fontWeight: FontWeight.w500),
          )
      )
    );
  }

}