import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:format/format.dart';
import 'package:treasure_nft_project/constant/theme/app_colors.dart';
import 'package:treasure_nft_project/constant/theme/app_image_path.dart';
import 'package:treasure_nft_project/constant/theme/app_style.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';
import 'package:treasure_nft_project/utils/app_text_style.dart';
import 'package:treasure_nft_project/view_models/gobal_provider/user_info_provider.dart';
import 'package:treasure_nft_project/views/collection/data/collection_financial_management_response_data.dart';
import 'package:treasure_nft_project/widgets/button/login_bolder_button_widget.dart';
import 'package:treasure_nft_project/widgets/label/gradually_network_image.dart';

import '../../../models/http/parameter/treasure_box_record.dart';
import '../../../view_models/base_view_model.dart';
import '../../../views/collection/collection_medal_share_page.dart';
import '../../button/icon_text_button_widget.dart';
import '../../label/icon/base_icon_widget.dart';

class FinancialManagementItemView extends ConsumerWidget {
  FinancialManagementItemView({
    Key? key,
    required this.data
  })
      : super(key: key);

  FinancialManagementResponseData data;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.datePickerBorder, width: 2)
        ),
        margin: EdgeInsets.symmetric(horizontal: UIDefine.getPixelWidth(18)),
        padding: EdgeInsets.all(UIDefine.getPixelWidth(16)),
        child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  data.maxRank == 0?
                  Row(
                    children: [
                      Text('${tr('level')} : ',style: AppTextStyle.getBaseStyle(fontWeight: FontWeight.w700,fontSize: UIDefine.fontSize14,color: AppColors.font02),),
                      Text('LV${data.minRank.toString()}',style: AppTextStyle.getBaseStyle(fontWeight: FontWeight.w700,fontSize: UIDefine.fontSize14,color: AppColors.coinColorGreen),),
                    ],
                  ):
                  Row(
                    children: [
                      Text('${tr('level')} : ',style: AppTextStyle.getBaseStyle(fontWeight: FontWeight.w700,fontSize: UIDefine.fontSize14,color: AppColors.font02),),
                      Text('LV${data.minRank.toString()}',style: AppTextStyle.getBaseStyle(fontWeight: FontWeight.w700,fontSize: UIDefine.fontSize14,color: AppColors.coinColorGreen),),
                      Text('-',style: AppTextStyle.getBaseStyle(fontWeight: FontWeight.w700,fontSize: UIDefine.fontSize14,color: AppColors.coinColorGreen),),
                      Text('LV${data.maxRank.toString()}',style: AppTextStyle.getBaseStyle(fontWeight: FontWeight.w700,fontSize: UIDefine.fontSize14,color: AppColors.coinColorGreen),),
                    ],
                  ),
                  Container(
                    width: UIDefine.getPixelWidth(79),
                    height: UIDefine.getPixelWidth(26),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.coinColorGreen,width: 1)
                    ),
                    child: Text('${data.dayCircle}${tr('day')}',style: AppTextStyle.getBaseStyle(fontWeight: FontWeight.w600,fontSize: UIDefine.fontSize12,color: AppColors.coinColorGreen),),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    child: Image.asset(data.imgUrl,
                      width: UIDefine.getPixelWidth(120),
                      height: UIDefine.getPixelWidth(120),
                      fit: BoxFit.cover,
                    )
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(tr('finance'),style: AppTextStyle.getBaseStyle(fontWeight: FontWeight.w700,fontSize: UIDefine.fontSize20),),
                      data.note.isNotEmpty?SizedBox(
                        width: UIDefine.getPixelWidth(160),
                        child: Text(data.note,style: AppTextStyle.getBaseStyle(fontWeight: FontWeight.w400,fontSize: UIDefine.fontSize14,color: AppColors.font02),),
                      ):Container(),
                      SizedBox(height: UIDefine.getPixelWidth(20),),
                      _buildTextWithTether(tr('fixedInvestment'), '${data.minInMoney} - ${data.maxInMoney}'),
                      _buildTextWithTether(tr('dailyIncome'), '${data.dayIncome.toString()}%')
                    ],
                  )
                ],
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: UIDefine.getPixelWidth(10)),
                height: UIDefine.getPixelWidth(1),
                color: Colors.black.withOpacity(0.1),
              ),
              Container(
                child: IconTextButtonWidget(
                    height: UIDefine.getScreenWidth(10),
                    btnText: tr("checkDetails"),
                    marginHorizon: 0,
                    iconPath: '',
                    onPressed: () {},),
              )
            ]));
  }

  Widget _buildTextWithTether(String title, String text) {
    return SizedBox(
      width: UIDefine.getPixelWidth(167),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: AppTextStyle.getBaseStyle(fontWeight: FontWeight.w500, fontSize: UIDefine.fontSize14,color: AppColors.font02),),
          Row(
            children: [
              Image.asset(AppImagePath.tetherImg,width: UIDefine.getPixelWidth(14),fit: BoxFit.fitWidth,),
              Text(text, style: AppTextStyle.getBaseStyle(fontWeight: FontWeight.w500, fontSize: UIDefine.fontSize14),)
            ],
          ),
        ],
      ),
    );
  }
}
