import 'dart:async';

import 'package:flutter/material.dart';
import 'package:treasure_nft_project/constant/enum/route_setting_enum.dart';
import 'package:treasure_nft_project/constant/global_data.dart';
import 'package:treasure_nft_project/constant/theme/app_image_path.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';
import 'package:treasure_nft_project/utils/app_text_style.dart';
import 'package:treasure_nft_project/utils/number_format_util.dart';
import 'package:treasure_nft_project/widgets/label/icon/base_icon_widget.dart';

import '../../../constant/theme/app_colors.dart';
import '../../../constant/theme/app_style.dart';
import '../../../models/http/api/test_route_api.dart';

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
  final RouteSetting server;

  /// 是否被選擇
  final bool enable;

  @override
  State<LineServerItem> createState() => _LineServerItemState();
}

class _LineServerItemState extends State<LineServerItem> {
  final String _tag = "LineConnect";
  List<num> pinResultList = [];
  bool isTimeOut = false;
  num? label;
  bool stop = false;
  bool isRun = false;

  @override
  void initState() {
    _initServer();
    super.initState();
  }

  @override
  void dispose() {
    _disconnectServer();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant LineServerItem oldWidget) {
    setState(() {
      /// 非同一個Server就要重新判讀
      if (oldWidget.server != widget.server) {
        _initServer();
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

  Future<void> _initServer({int successCount = 3, int runCount = 10}) async {
    _disconnectServer();
    if (!isRun) {
      isRun = true;
      _initSetting();

      /// 測試10次 都沒成功就當作Time out
      for (int i = 0; i < runCount; i++) {
        /// 強制停止用
        if (stop) {
          break;
        }
        DateTime startTime = DateTime.now();
        try {
          await TestRouteAPI(replaceRoute: widget.server.getDomain()).testConnectRoute();
          DateTime endTime = DateTime.now();
          int pingMs = endTime.difference(startTime).inMilliseconds;
          GlobalData.printLog("$_tag : startTime (${startTime.toIso8601String()})");
          GlobalData.printLog("$_tag : endTime (${endTime.toIso8601String()})");
          GlobalData.printLog("$_tag : Connect (${widget.server.name}) $pingMs ms");

          pinResultList.add(endTime.difference(startTime).inMilliseconds);

          /// 檢查是否連接滿成功的次數
          if (pinResultList.length == successCount) {
            break;
          }
        } catch (e) {
          GlobalData.printLog("$_tag : Connect (${widget.server.name}) Error");
        }
        await Future.delayed(const Duration(milliseconds: 500));
      }
      if (mounted) {
        setState(() {
          if (pinResultList.length == successCount) {
            num total = 0;
            for (var i in pinResultList) {
              total += i;
            }
            label = total / successCount;
          } else {
            isTimeOut = true;
          }
        });
      }
      isRun = false;
    }
  }

  void _disconnectServer() {
    stop = true;
  }

  void _initSetting() {
    label = null;
    isTimeOut = false;
    stop = false;
    pinResultList.clear();
  }

  Widget _buildPinText() {
    if (isTimeOut) {
      return Text(
        "9999 ms",
        style: AppTextStyle.getBaseStyle(fontSize: UIDefine.fontSize14, fontWeight: FontWeight.w700, color: AppColors.linePingBad),
      );
    }
    if (label == null) {
      return Text(
        "- ms",
        style: AppTextStyle.getBaseStyle(fontSize: UIDefine.fontSize14, fontWeight: FontWeight.w700, color: AppColors.textNineBlack),
      );
    }
    return Text(
      "${NumberFormatUtil().removeTwoPointFormat(label)} ms",
      style: AppTextStyle.getBaseStyle(fontSize: UIDefine.fontSize14, fontWeight: FontWeight.w700, color: (label! >= 100 ? AppColors.linePingBad : AppColors.linePingGreat)),
    );
  }
}
