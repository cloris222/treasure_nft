import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:treasure_nft_project/constant/theme/app_colors.dart';
import 'package:treasure_nft_project/constant/theme/app_style.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';
import 'package:treasure_nft_project/utils/app_text_style.dart';
import 'package:treasure_nft_project/utils/number_format_util.dart';
import 'package:treasure_nft_project/view_models/gobal_provider/user_level_info_provider.dart';
import 'package:treasure_nft_project/view_models/trade/trade_new_main_view_model.dart';

import '../../models/http/parameter/check_reservation_info.dart';
import '../../view_models/trade/provider/trade_reserve_info_provider.dart';

class TradeMainUserInfoView extends ConsumerWidget {
  const TradeMainUserInfoView({Key? key, required this.viewModel})
      : super(key: key);
  final TradeNewMainViewModel viewModel;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return _buildTradeInfo(ref);
  }

  Widget _buildTradeInfo(WidgetRef ref) {
    CheckReservationInfo? reserveInfo = ref.watch(tradeReserveInfoProvider);
    num income = reserveInfo?.income??0;
    num todayIncome = reserveInfo?.todayIncome??0;
    num teamIncome = reserveInfo?.teamIncome??0;
    num balance = reserveInfo?.getBalance() ?? 0;
    num reserveBalance = reserveInfo?.getReserveBalance() ?? 0;
    return Column(
      children: [
        IntrinsicHeight(
          child: Row(
            children: [
              _buildInfoItem(
                title: 'todayEarnings',
                content: NumberFormatUtil().removeTwoPointFormat(todayIncome),
              ),
              SizedBox(width: UIDefine.getPixelWidth(8)),
              _buildInfoItem(
                title: "cumulativeIncome",
                content: NumberFormatUtil().removeTwoPointFormat(income),
              ),
              SizedBox(width: UIDefine.getPixelWidth(8)),
              _buildInfoItem(
                title: "teamBenefits",
                content: NumberFormatUtil().removeTwoPointFormat(teamIncome),
              ),
            ],
          ),
        ),
        SizedBox(height: UIDefine.getPixelWidth(10),),
        IntrinsicHeight(
          child: Row(
            children: [
              _buildInfoItem(
                title: 'amountRangeNFT',
                content: viewModel.getRange(ref.watch(userLevelInfoProvider)),
              ),
              SizedBox(width: UIDefine.getPixelWidth(8)),
              _buildInfoItem(
                title: "wallet-balance'",
                content: NumberFormatUtil().removeTwoPointFormat(balance),
              ),
              SizedBox(width: UIDefine.getPixelWidth(8)),
              _buildInfoItem(
                title: "availableBalance",
                content: NumberFormatUtil().removeTwoPointFormat(reserveBalance),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildInfoItem({required String title, required String content}) {
    Color getColorFromTitle(String title){
      switch (title){
        case "todayEarnings":
          return AppColors.cardDeepBlue;
        case "cumulativeIncome":
          return AppColors.cardGreen;
        case "teamBenefits":
          return AppColors.tradeGrey;
        case "amountRangeNFT":
          return AppColors.cardOrg;
        case "wallet-balance'":
          return AppColors.cardLightBlue;
        case "availableBalance":
          return AppColors.cardDeepGrey;
        default:
          return AppColors.tradeGrey;
      }
    }
    return Expanded(
      child: Container(
        padding: EdgeInsets.only(left: UIDefine.getPixelWidth(7)),
        // height: UIDefine.getPixelHeight(theHeight),
        // width: UIDefine.getPixelWidth(107),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [getColorFromTitle(title), Colors.transparent],
            stops: [0.1,0.1]
          ),
          borderRadius: BorderRadius.all(Radius.circular(12)),
          border: Border.all(width: UIDefine.getPixelWidth(2),color: AppColors.borderGrey),
        ),
        child: Container(
          margin: EdgeInsets.symmetric(vertical: UIDefine.getPixelWidth(5)),
          padding: EdgeInsets.only(left: UIDefine.getPixelWidth(10), bottom: UIDefine.getPixelWidth(6), top: UIDefine.getPixelWidth(6)),
          decoration: AppStyle().styleColorsRadiusBackground(radius: 10, hasTopLeft: false, hasBottomLef: false, color: Colors.transparent),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(tr(title),
                  // overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: AppTextStyle.getBaseStyle(
                      color: AppColors.tradeGrey,
                      fontSize: UIDefine.fontSize12,
                      fontWeight: FontWeight.w500)),
              Text(content,
                  style: AppTextStyle.getBaseStyle(
                      color: AppColors.textBlack,
                      fontSize: UIDefine.fontSize18,
                      fontWeight: FontWeight.w600)),
            ],
          ),
        ),
      ),
    );
  }
}
