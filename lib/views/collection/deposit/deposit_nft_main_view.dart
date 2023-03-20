import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:treasure_nft_project/constant/theme/app_colors.dart';
import 'package:treasure_nft_project/utils/app_text_style.dart';
import 'package:treasure_nft_project/widgets/dialog/common_custom_dialog.dart';

import '../../../constant/enum/collection_enum.dart';
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
  DepositChain? chooseChain;

  @override
  Widget build(BuildContext context) {
    return CustomAppbarView(
      needScrollView: true,
      onLanguageChange: () {
        if (mounted) {
          setState(() {});
        }
      },
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
                      )),
                  Text(
                    tr("chooseNetwork"),
                    style: AppTextStyle.getBaseStyle(
                        color: AppColors.textBlack,
                        fontSize: UIDefine.fontSize20,
                        fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    tr("supportNetwork"),
                    style: AppTextStyle.getBaseStyle(
                        color: AppColors.textGrey,
                        fontSize: UIDefine.fontSize14,
                        fontWeight: FontWeight.w500),
                  ),
                  ...List<Widget>.generate(DepositChain.values.length,
                      (index) => _buildChainButton(DepositChain.values[index]))
                ],
              ),
              const SizedBox(height: 20),
              Container(
                margin: EdgeInsets.only(bottom: UIDefine.getScreenWidth(5.5)),
                width: UIDefine.getScreenWidth(90),
                height: UIDefine.getScreenWidth(16),
                child: LoginButtonWidget(
                  onPressed: () {
                    if (chooseChain != null) {
                      _pressNext();
                    }
                  },
                  btnText: tr('Next'), // 下一步
                ),
              ),
              SizedBox(height: UIDefine.navigationBarPadding)
            ],
          )),
    );
  }

  Widget _buildChainButton(DepositChain chain) {
    bool isChoose = (chain == chooseChain);
    return GestureDetector(
      onTap: () {
        setState(() {
          chooseChain = chain;
        });
      },
      child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: isChoose
                    ? AppColors.gradientBaseColorBg
                    : [AppColors.bolderGrey, AppColors.bolderGrey],
              ),
              borderRadius: const BorderRadius.all(Radius.circular(10))),
          margin: EdgeInsets.symmetric(vertical: UIDefine.getPixelWidth(10)),
          child: Padding(
              padding: const EdgeInsets.all(2),
              child: Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.all(UIDefine.getScreenWidth(2)),
                  decoration: (const BoxDecoration(
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
                              Image.asset(_getChainImage(chain),
                                  width: UIDefine.getScreenWidth(8.3),
                                  height: UIDefine.getScreenWidth(8.3)),
                              SizedBox(width: UIDefine.getScreenWidth(3)),
                              Text(
                                chain.name,
                                style: AppTextStyle.getBaseStyle(
                                    color: AppColors.textBlack,
                                    fontSize: UIDefine.fontSize16,
                                    fontWeight: FontWeight.w500),
                              )
                            ],
                          ),
                          isChoose
                              ? Image.asset(
                                  'assets/icon/icon/icon_checked_02.png')
                              : const SizedBox()
                        ],
                      ))))),
    );
  }

  String _getChainImage(DepositChain chain) {
    switch (chain) {
      case DepositChain.Polygon:
        return "assets/icon/coins/icon_polygon_01.png";
      case DepositChain.BSC:
        return "assets/icon/coins/icon_binance_01.png";
      case DepositChain.OKC:
        return "assets/icon/icon/icon_okx_01.png";
    }
  }

  void _pressNext() {
    if (DepositChain.Polygon == chooseChain) {
      BaseViewModel().pushPage(
          context, DepositNftResultView(netWork: DepositChain.Polygon.name));
    } else {
      CommonCustomDialog(context,
          type: DialogImageType.warning,
          title: tr("temp-cant-use'"),
          content: _hintText(chooseChain),
          rightBtnText: tr('confirm'),
          onLeftPress: () {}, onRightPress: () {
        Navigator.pop(context);
      }).show();
    }
  }

  String _hintText(DepositChain? chooseChain) {
    switch (chooseChain) {
      case DepositChain.BSC:
        return tr('bscText');
      case DepositChain.OKC:
        return tr('okcText');
      case DepositChain.Polygon:
      default:
        return "";
    }
  }
}
