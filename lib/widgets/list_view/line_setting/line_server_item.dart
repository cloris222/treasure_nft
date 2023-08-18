import 'package:flutter/material.dart';
import 'package:treasure_nft_project/constant/enum/server_route_enum.dart';
import 'package:treasure_nft_project/constant/theme/app_image_path.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';
import 'package:treasure_nft_project/utils/app_text_style.dart';
import 'package:treasure_nft_project/utils/number_format_util.dart';
import 'package:treasure_nft_project/widgets/label/icon/base_icon_widget.dart';

import '../../../constant/theme/app_colors.dart';
import '../../../constant/theme/app_style.dart';
import '../../../view_models/personal/common/user_line_setting_item_view_model.dart';

class LineServerItem extends StatefulWidget {
  const LineServerItem({
    Key? key,
    required this.name,
    required this.server,
    required this.enable,
  }) : super(key: key);

  /// 名稱
  final String name;

  /// Server ip
  final ServerRoute server;

  /// 是否被選擇
  final bool enable;

  @override
  State<LineServerItem> createState() => _LineServerItemState();
}

class _LineServerItemState extends State<LineServerItem> {
  late UserLineSettingItemViewModel viewModel;

  @override
  void initState() {
    viewModel = UserLineSettingItemViewModel(onViewChange: () {
      if (mounted) {
        setState(() {});
      }
    });
    viewModel.initServer(server: widget.server);
    super.initState();
  }

  @override
  void dispose() {
    viewModel.disconnectServer();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant LineServerItem oldWidget) {
    setState(() {
      /// 非同一個Server就要重新判讀
      if (oldWidget.server != widget.server) {
        viewModel.restartServer(server: widget.server);
      }
    });
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: UIDefine.getPixelWidth(20), vertical: UIDefine.getPixelWidth(24)),
      margin: EdgeInsets.symmetric(vertical: UIDefine.getPixelWidth(6)),
      decoration: AppStyle().buildGradient(
        colors: [Colors.white, Colors.white, Colors.white, Colors.white, const Color(0xFFE0ECFC)],
        radius: 6,
      ),
      child: Row(
        children: [
          BaseIconWidget(imageAssetPath: AppImagePath.lineSettingServer, size: UIDefine.getPixelWidth(40)),
          SizedBox(width: UIDefine.getPixelWidth(8)),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.name, style: AppTextStyle.getBaseStyle(fontSize: UIDefine.fontSize14, fontWeight: FontWeight.w600, color: Colors.black)),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Pin: ",
                    style: AppTextStyle.getBaseStyle(fontWeight: FontWeight.w400, fontSize: UIDefine.fontSize14, color: AppColors.textNineBlack),
                  ),
                  _buildPinText(),
                ],
              )
            ],
          ),
          const Spacer(),
          BaseIconWidget(imageAssetPath: widget.enable ? AppImagePath.selectedServer : AppImagePath.unselectServer, size: UIDefine.getPixelWidth(24)),
        ],
      ),
    );
  }

  Widget _buildPinText() {
    if (viewModel.isTimeOut) {
      return Text(
        "9999 ms",
        style: AppTextStyle.getBaseStyle(fontSize: UIDefine.fontSize14, fontWeight: FontWeight.w700, color: AppColors.linePingBad),
      );
    }
    if (viewModel.label == null) {
      return Text(
        "- ms",
        style: AppTextStyle.getBaseStyle(fontSize: UIDefine.fontSize14, fontWeight: FontWeight.w700, color: AppColors.textNineBlack),
      );
    }
    return Text(
      "${NumberFormatUtil().removeTwoPointFormat(viewModel.label)} ms",
      style:
          AppTextStyle.getBaseStyle(fontSize: UIDefine.fontSize14, fontWeight: FontWeight.w700, color: (viewModel.label! >= 100 ? AppColors.linePingBad : AppColors.linePingGreat)),
    );
  }
}
