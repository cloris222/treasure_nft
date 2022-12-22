import 'dart:io';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:treasure_nft_project/utils/animation_download_util.dart';
import 'package:treasure_nft_project/widgets/label/gradually_network_image.dart';

import '../../constant/call_back_function.dart';
import '../../constant/theme/app_colors.dart';
import '../../constant/ui_define.dart';
import '../../view_models/base_view_model.dart';

/// 開盲盒的動畫 + Show商品圖
class OpenBoxAnimationPage extends StatefulWidget {
  const OpenBoxAnimationPage(
      {super.key,
      required this.animationPath,
      required this.imgUrl,
      this.backgroundColor = AppColors.opacityBackground,
      required this.callBack});

  final String imgUrl; // 解鎖的商品圖
  final String animationPath; // 動畫路徑
  final Color backgroundColor; // 背景覆蓋色
  final onClickFunction callBack;

  @override
  State<StatefulWidget> createState() => _OpenBoxAnimationPage();
}

class _OpenBoxAnimationPage extends State<OpenBoxAnimationPage>
    with SingleTickerProviderStateMixin {
  bool bShowItem = false;
  bool bCompleted = false;
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(vsync: this);
    controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          bShowItem = true;
        });
        bCompleted = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double padding = MediaQuery.of(context).padding.top;
    String? path =
        AnimationDownloadUtil().getAnimationFilePath(widget.animationPath);
    return GestureDetector(
        onTap: () => _onTapPage(context),
        child: Scaffold(
            backgroundColor: widget.backgroundColor,

            ///MARK: 禁止返回前頁
            body: WillPopScope(
              onWillPop: () async {
                return false;
              },
              child: Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.all(padding),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      path != null
                          ? Lottie.file(
                              File(path),
                              fit: BoxFit.contain,
                              controller: controller,
                              repeat: false,
                              onLoaded: (composition) {
                                controller
                                  ..duration = composition.duration
                                  ..forward();
                              },
                            )
                          : SizedBox(
                              width: UIDefine.getScreenWidth(37.33),
                              height: UIDefine.getScreenWidth(37.33)),
                      Visibility(
                        visible: bShowItem,
                        child: GraduallyNetworkImage(
                          imageUrl: widget.imgUrl,
                          width: UIDefine.getScreenWidth(37.33),
                          height: UIDefine.getScreenWidth(37.33),
                        ),
                      )
                    ],
                  )),
            )));
  }

  void _onTapPage(BuildContext context) {
    if (bCompleted) {
      widget.callBack(); // 看完動畫跳出去後才更新外面的View (避免背景露餡抽到啥)
      BaseViewModel().popPage(context);
    }
  }
}
