import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:treasure_nft_project/constant/theme/app_colors.dart';

import '../../../constant/ui_define.dart';
import '../../../view_models/base_view_model.dart';
import '../../../widgets/app_bottom_navigation_bar.dart';
import '../../../widgets/appbar/custom_app_bar.dart';
import 'deposit_nft_result_view.dart';

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
    return Scaffold(
      /// AppBar
      appBar: CustomAppBar.getCornerAppBar(
            () {
          BaseViewModel().popPage(context);
        },
        'Deposit NFT',
        fontSize: UIDefine.fontSize24,
        arrowFontSize: UIDefine.fontSize34,
        circular: 40,
        appBarHeight: UIDefine.getScreenWidth(20),
      ),

      body: Padding(
        padding: EdgeInsets.all(UIDefine.getScreenWidth(5)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '選擇網路',
              style: TextStyle(color: AppColors.textBlack, fontSize: UIDefine.fontSize16, fontWeight: FontWeight.w600),
            ),

            const SizedBox(height: 4),

            Text(
              '目前支援Polygon、BSC',
              style: TextStyle(color: AppColors.textBlack, fontSize: UIDefine.fontSize14, fontWeight: FontWeight.w600),
            ),

            const SizedBox(height: 20),

            GestureDetector(
              onTap: () => {bPolygon = true, bBSC = false, setState(() {})},
              child: Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: bPolygon? [AppColors.mainThemeButton, AppColors.subThemePurple]
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
                            children: [
                              Image.asset('assets/icon/coins/icon_polygon_01.png', width: UIDefine.getScreenWidth(8.3), height: UIDefine.getScreenWidth(8.3)),
                              SizedBox(width: UIDefine.getScreenWidth(3)),
                              Text(
                                'Polygon',
                                style: TextStyle(color: AppColors.textBlack, fontSize: UIDefine.fontSize16, fontWeight: FontWeight.w600),
                              )
                            ],
                          )
                        )
                      )
                  )
              ),
            ),

            const SizedBox(height: 20),

            GestureDetector(
              onTap: () => {bBSC = true, bPolygon = false, setState(() {})},
              child: Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: bBSC? [AppColors.mainThemeButton, AppColors.subThemePurple]
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
                            children: [
                              Image.asset('assets/icon/coins/icon_binance_01.png', width: UIDefine.getScreenWidth(8.3), height: UIDefine.getScreenWidth(8.3)),
                              SizedBox(width: UIDefine.getScreenWidth(3)),
                              Text(
                                'BSC',
                                style: TextStyle(color: AppColors.textBlack, fontSize: UIDefine.fontSize16, fontWeight: FontWeight.w600),
                              )
                            ],
                          )
                        )
                      )
                  )
              ),
            ),

            SizedBox(height: UIDefine.getScreenWidth(57)),

            Container(
              width: UIDefine.getScreenWidth(90),
              height: UIDefine.getScreenWidth(14),
              decoration: BoxDecoration(
                  color: AppColors.mainThemeButton,
                  borderRadius: BorderRadius.circular(10)
              ),
              child: TextButton(
                  onPressed: () {
                    _pressNext();
                  },
                  child: Text(
                    tr('next'), // 完成付款
                    style: TextStyle(
                        color: AppColors.textWhite, fontSize: UIDefine.fontSize16, fontWeight: FontWeight.w500),
                  )
              ),
            ),

            const SizedBox(height: 10),
          ],
        )
      ),


      bottomNavigationBar: const AppBottomNavigationBar(initType: AppNavigationBarType.typeCollection),
    );
  }

  void _pressNext() {
    String netWork = 'BSC';
    if (bPolygon) {
      netWork = 'Polygon';
    }
    BaseViewModel().pushPage(context, DepositNftResultView(netWork: netWork));
  }

}