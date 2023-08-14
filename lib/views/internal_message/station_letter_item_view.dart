import 'package:flutter/material.dart';
import 'package:treasure_nft_project/constant/theme/app_image_path.dart';
import 'package:treasure_nft_project/utils/app_text_style.dart';
import '../../constant/theme/app_colors.dart';
import '../../constant/ui_define.dart';
import '../../models/data/station_letter_data.dart';

class StationLetterItemView extends StatelessWidget {
  const StationLetterItemView({Key? key, this.isSystemType = false, required this.data}) : super(key: key);
  final StationLetterData data;
  final bool isSystemType;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: UIDefine.getWidth(),
      padding: EdgeInsets.all(UIDefine.getPixelWidth(15)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            isSystemType ? AppImagePath.mailReserve : AppImagePath.mailService,
            height: UIDefine.getPixelWidth(45),
            width: UIDefine.getPixelWidth(45),
            fit: BoxFit.contain,
          ),
          SizedBox(width: UIDefine.getPixelWidth(16)),
          Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Visibility(
                    visible: !data.isRead,
                    child: Padding(
                      padding: EdgeInsets.only(right: UIDefine.getPixelWidth(6)),
                      child: const CircleAvatar(backgroundColor: AppColors.textRed, radius: 4),
                    ),
                  ),
                  Text(
                    data.title,
                    style: AppTextStyle.getBaseStyle(color: Colors.black, fontSize: UIDefine.fontSize14, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              SizedBox(height: UIDefine.getPixelWidth(4)),
              Text(data.content,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyle.getBaseStyle(color: AppColors.textNineBlack, fontSize: UIDefine.fontSize12, fontWeight: FontWeight.w400)),
            ]),
          ),
        ],
      ),
    );
  }
}
