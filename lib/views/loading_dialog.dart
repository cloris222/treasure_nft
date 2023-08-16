import 'package:flutter/material.dart';
import 'package:treasure_nft_project/utils/app_text_style.dart';
import 'package:treasure_nft_project/utils/observer_pattern/custom/custom_observer.dart';

import '../constant/global_data.dart';
import '../constant/subject_key.dart';
import '../constant/theme/app_colors.dart';
import '../constant/theme/app_style.dart';
import '../constant/ui_define.dart';

class LoadingDialog extends StatefulWidget {
  const LoadingDialog({Key? key}) : super(key: key);

  @override
  State<LoadingDialog> createState() => _LoadingDialogState();
}

class _LoadingDialogState extends State<LoadingDialog> {
  late CustomObserver observer;

  @override
  void initState() {
    observer = CustomObserver(SubjectKey.keyCloseLoadingDialog, onNotify: (notification) {
      _closeSelf();
    });
    GlobalData.loadingSubject.registerObserver(observer);
    super.initState();
  }

  @override
  void dispose() {
    GlobalData.loadingSubject.unregisterObserver(observer);
    super.dispose();
  }

  void _closeSelf() {
    Navigator.of(context).removeRoute(ModalRoute.of(context) as Route);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Scaffold(
        backgroundColor: AppColors.opacityBackground,
        body: WillPopScope(
          onWillPop: () async {
            return false;
          },
          child: GestureDetector(
            onTap: () {},
            child: Center(
              child: Container(
                  margin: EdgeInsets.symmetric(horizontal: UIDefine.getPixelWidth(40)),
                  padding: EdgeInsets.all(UIDefine.getPixelWidth(40)),
                  decoration: AppStyle().styleColorsRadiusBackground(radius: 8, color: AppColors.textBlack),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                          height: UIDefine.getPixelWidth(32),
                          width: UIDefine.getPixelWidth(32),
                          margin: EdgeInsets.only(bottom: UIDefine.getPixelWidth(16)),
                          child: const CircularProgressIndicator(
                            strokeWidth: 2,
                            color: AppColors.textWhite,
                          )),
                      Text("loading...", style: AppTextStyle.getBaseStyle(color: AppColors.textWhite,fontSize: UIDefine.fontSize16,fontWeight: FontWeight.w400)),
                    ],
                  )),
            ),
          ),
        ),
      ),
    );
  }
}
