import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:treasure_nft_project/constant/theme/app_colors.dart';
import 'package:treasure_nft_project/utils/app_text_style.dart';
import 'package:treasure_nft_project/widgets/appbar/title_app_bar.dart';
import 'package:treasure_nft_project/widgets/dialog/common_custom_dialog.dart';

import '../../../constant/ui_define.dart';
import '../../../view_models/base_view_model.dart';
import '../../../widgets/app_bottom_navigation_bar.dart';
import '../../../widgets/button/login_button_widget.dart';
import '../../custom_appbar_view.dart';
import 'deposit_nft_result_view.dart';

/// 充值NFT
class DepositNftMainView extends StatefulWidget {
  const DepositNftMainView({super.key});

  @override
  State<StatefulWidget> createState() => _DepositNftMainView();

}

class _DepositNftMainView extends State<DepositNftMainView> {

  bool bPolygon = false;
  bool bBSC = false;

  @override
  Widget build(BuildContext context) {
    return CustomAppbarView(
      needScrollView: false,
      type: AppNavigationBarType.typeCollection,
      body: Padding(
        padding: EdgeInsets.all(UIDefine.getScreenWidth(5)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  alignment: Alignment.centerRight,
                  width: double.infinity,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Image.asset('assets/icon/btn/btn_cross_01.png'),
                  )
                ),
                Text(
                  tr("chooseNetwork"),
                  style: AppTextStyle.getBaseStyle(color: AppColors.textBlack, fontSize: UIDefine.fontSize20, fontWeight: FontWeight.w600),
                ),

                const SizedBox(height: 4),

                Text(
                  tr("supportNetwork"),
                  style: AppTextStyle.getBaseStyle(color: AppColors.textGrey, fontSize: UIDefine.fontSize14, fontWeight: FontWeight.w500),
                ),

                const SizedBox(height: 20),

                GestureDetector(
                  onTap: () => {bPolygon = true, bBSC = false, setState(() {})},
                  child: Container(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: bPolygon? AppColors.gradientBaseColorBg
                                :
                            [AppColors.bolderGrey, AppColors.bolderGrey],
                          ),
                          borderRadius: const BorderRadius.all(Radius.circular(10))
                      ),
                      child: Padding(
                          padding: const EdgeInsets.all(2),
                          child: Container(
                              alignment: Alignment.centerLeft,
                              padding: EdgeInsets.all(UIDefine.getScreenWidth(2)),
                              decoration: (
                                  const BoxDecoration(
                                    color: AppColors.textWhite,
                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                  )),
                              child: Padding(
                                  padding: EdgeInsets.all(UIDefine.getScreenWidth(2.77)),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Image.asset('assets/icon/coins/icon_polygon_01.png', width: UIDefine.getScreenWidth(8.3), height: UIDefine.getScreenWidth(8.3)),
                                          SizedBox(width: UIDefine.getScreenWidth(3)),
                                          Text(
                                            'Polygon',
                                            style: AppTextStyle.getBaseStyle(color: AppColors.textBlack, fontSize: UIDefine.fontSize16, fontWeight: FontWeight.w500),
                                          )
                                        ],
                                      ),

                                      bPolygon ? Image.asset('assets/icon/icon/icon_checked_02.png') : SizedBox()
                                    ],
                                  )
                              )
                          )
                      )
                  ),
                ),

                SizedBox(height: UIDefine.getScreenWidth(5.5)),

                GestureDetector(
                  onTap: () => {bBSC = true, bPolygon = false, setState(() {})},
                  child: Container(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: bBSC? AppColors.gradientBaseColorBg
                                :
                            [AppColors.bolderGrey, AppColors.bolderGrey] ,
                          ),
                          borderRadius: const BorderRadius.all(Radius.circular(10))
                      ),
                      child: Padding(
                          padding: const EdgeInsets.all(2),
                          child: Container(
                              alignment: Alignment.centerLeft,
                              padding: EdgeInsets.all(UIDefine.getScreenWidth(2)),
                              decoration: (
                                  const BoxDecoration(
                                    color: AppColors.textWhite,
                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                  )),
                              child: Padding(
                                  padding: EdgeInsets.all(UIDefine.getScreenWidth(2.77)),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Image.asset('assets/icon/coins/icon_binance_01.png', width: UIDefine.getScreenWidth(8.3), height: UIDefine.getScreenWidth(8.3)),
                                          SizedBox(width: UIDefine.getScreenWidth(3)),
                                          Text(
                                            'BSC',
                                            style: AppTextStyle.getBaseStyle(color: AppColors.textBlack, fontSize: UIDefine.fontSize16, fontWeight: FontWeight.w500),
                                          )
                                        ],
                                      ),

                                      bBSC ? Image.asset('assets/icon/icon/icon_checked_02.png') : SizedBox(),
                                    ],
                                  )
                              )
                          )
                      )
                  ),
                ),
              ],
            ),

            Container(
              margin: EdgeInsets.only(bottom: UIDefine.getScreenWidth(5.5)),
              width: UIDefine.getScreenWidth(90),
              height: UIDefine.getScreenWidth(16),
              child: LoginButtonWidget(
                  onPressed: () {
                    _pressNext();
                  },
                  btnText: tr('Next'), // 下一步
              ),
            ),
            SizedBox(height: UIDefine.navigationBarPadding)
          ],
        )
      ),
    );
  }

  void _pressNext() {
    if (bPolygon) {
      String netWork = 'Polygon';
      BaseViewModel().pushPage(context, DepositNftResultView(netWork: netWork));

    } else {
      CommonCustomDialog(
          context,
          type: DialogImageType.warning,
          title: tr("temp-cant-use'"),
          content: tr("mint-cant-info'"),
          rightBtnText: tr('confirm'),
          onLeftPress: (){},
          onRightPress: () {
            Navigator.pop(context);
          }
      ).show();
    }
  }

}