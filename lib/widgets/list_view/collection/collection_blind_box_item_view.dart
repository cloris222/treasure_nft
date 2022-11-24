import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:format/format.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';
import 'package:treasure_nft_project/view_models/base_view_model.dart';
import 'package:treasure_nft_project/widgets/button/action_button_widget.dart';
import 'package:treasure_nft_project/widgets/label/custom_linear_progress.dart';

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
      margin: EdgeInsets.fromLTRB(UIDefine.getScreenWidth(5), 0, UIDefine.getScreenWidth(5), 0),
      decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: AppColors.searchBar, width: 1))),
      child:
                /// 空投獎勵             /// 盲盒
        bOpen ? _getAirDropBonusView() : _getBlindBoxView()

    );
  }

  Widget _getBlindBoxView() {
    return Column(
      children: [
        Image.asset('assets/icon/img/img_box_01.png'),
        SizedBox(height: UIDefine.getScreenWidth(2.77)),
        ActionButtonWidget(
            btnText: tr('openoBlindBox'),
            setHeight: UIDefine.getScreenWidth(10),
            onPressed: () { // 開啟盲盒
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
            }
        ),
        SizedBox(height: UIDefine.getScreenWidth(3)),
      ],
    );
  }

  Widget _getAirDropBonusView() {
    return Column(
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
              style: TextStyle(color: AppColors.dialogGrey, fontSize: UIDefine.fontSize16, fontWeight: FontWeight.w500),
            )
          ],
        ),

        SizedBox(height: UIDefine.getScreenWidth(4)),

        /// 中間圖文
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _getItemImage(data.imgUrl), // 商品圖
            SizedBox(width: UIDefine.getScreenWidth(2.7)),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                    width: UIDefine.getScreenWidth(67),
                    child: Text( // 商品名
                      data.name,
                      style: TextStyle(color: AppColors.dialogGrey, fontSize: UIDefine.fontSize20, fontWeight: FontWeight.w500),
                    )
                ),

                SizedBox(height: UIDefine.getScreenWidth(3.5)),

                Row(
                  children: [
                    Image.asset('assets/icon/coins/icon_tether_01.png',
                        opacity: const AlwaysStoppedAnimation(0.5),
                        width: UIDefine.getScreenWidth(3.7), height: UIDefine.getScreenWidth(3.7)),
                    const SizedBox(width: 4),
                    Text( // 商品價格
                      data.price.toString(),
                      style: TextStyle(color: AppColors.dialogGrey, fontSize: UIDefine.fontSize14, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ],
            )
          ]
        ),

        SizedBox(height: UIDefine.getScreenWidth(2.77)),

        /// 進度條
        Container(
          padding: EdgeInsets.all(UIDefine.getScreenWidth(5)),
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.bolderGrey, width: 2.5),
            borderRadius: const BorderRadius.all(Radius.circular(8)),
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
                        format(tr('reach'), {'level': data.rewardNft.unlockLevel}) ,
                        style: TextStyle(color: _getLvTextColor(),
                            fontSize: UIDefine.fontSize14, fontWeight: FontWeight.w500),
                      ),
                      Text( // 目前進度 ex:1/3
                        data.rewardNft.currentLevel.toString() + '/' + data.rewardNft.unlockLevel.toString(),
                        style: TextStyle(color: _getLvTextColor(),
                            fontSize: UIDefine.fontSize14, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  CustomLinearProgress(
                    needShowFinishIcon: false,
                    needShowPercentage: false,
                    height: UIDefine.getScreenWidth(2),
                    percentage: _getPercentage(data.rewardNft.currentLevel.toString(),
                        data.rewardNft.unlockLevel.toString()),
                  )
                ],
              ),

              SizedBox(height: UIDefine.getScreenWidth(5)),

              /// 購買次數要求
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          _showLockIcon(data.rewardNft.currentLevel.toString(), data.rewardNft.unlockLevel.toString()),
                          const SizedBox(width: 4),
                          Text( // 購買次數幾
                            format(tr('buyCount'), {'count': data.rewardNft.unlockBuyCount}) ,
                            style: TextStyle(color: _getBuyCountTextColor(),
                                fontSize: UIDefine.fontSize14, fontWeight: FontWeight.w500),
                          )
                        ],
                      ),
                      Text( // 目前進度 ex:1/3
                        data.rewardNft.currentBuyCount.toString() + '/' + data.rewardNft.unlockBuyCount.toString(),
                        style: TextStyle(color: _getBuyCountTextColor(),
                            fontSize: UIDefine.fontSize14, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),

                  const SizedBox(height: 4),
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

        const SizedBox(height: 6),
        /// 按鈕
        Visibility(
          visible: _showOpenButton(),
            child: ActionButtonWidget(
                btnText: tr('open'),
                onPressed: () {
                  // 開啟btn -> 解鎖
                  widget.unlock(widget.index);
                }
            )
        ),
        const SizedBox(height: 6)
      ],
    );
  }

  Widget _getItemImage(String imgUrl) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Image.network(imgUrl,
            opacity: const AlwaysStoppedAnimation(0.3),
            width: UIDefine.getScreenWidth(19.5),
            height: UIDefine.getScreenWidth(19.5)),
        Image.asset('assets/icon/icon/icon_lock_01.png')
      ],
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

}