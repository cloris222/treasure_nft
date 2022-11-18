import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:treasure_nft_project/constant/call_back_function.dart';
import 'package:treasure_nft_project/view_models/base_view_model.dart';
import 'package:video_player/video_player.dart';
import '../constant/global_data.dart';
import '../constant/theme/app_animation_path.dart';
import '../utils/app_shared_Preferences.dart';
import '../views/main_page.dart';

class SplashScreenViewModel extends BaseViewModel {
  SplashScreenViewModel({required this.context, required this.onViewChange});

  final BuildContext context;
  final onClickFunction onViewChange;
  late VideoPlayerController controller;

  bool isVideoFinish = false;
  bool isInitAppFinish = false;

  late Timer _countdownTimer;
  Duration _oldPosition = Duration.zero;

  void initState() async {
    controller = VideoPlayerController.asset(AppAnimationPath.splashScreen);
    await controller.initialize();
    await controller.play();
    onViewChange();
    _countdownTimer = Timer.periodic(
        const Duration(milliseconds: 500), (_) => _setCountDown());
    runInitApp().then((value) {
      isInitAppFinish = true;
      print('isInitAppFinish:true');
    });
  }

  void dispose() {
    controller.dispose();
    _countdownTimer.cancel();
  }

  _setCountDown() {
    if (!isVideoFinish) {
      ///MARK: 計算影片是否撥放完畢
      var newPosition = controller.value.position;
      var newDuration = controller.value.duration;
      if ((_oldPosition.compareTo(newPosition) == 0 &&
              _oldPosition.compareTo(Duration.zero) != 0) ||
          (newDuration.compareTo(newPosition) == 0 ||
              newDuration.compareTo(newPosition) == -1)) {
        print('isVideoFinish:true');
        isVideoFinish = true;
        controller.setLooping(true);
        controller.seekTo(Duration.zero).then((value) => controller.play());
      } else {
        _oldPosition = newPosition;
      }
    }
    if (isVideoFinish && isInitAppFinish) {
      pushReplacement(context, const MainPage());
      _countdownTimer.cancel();
    }
  }

  Future<void> runInitApp() async {
    ///MARK: 等兩秒 讓動畫播
    await Future.delayed(const Duration(seconds: 3));
    print('runInitApp:start');
    await getCountry();

    ///MARK: 自動登入
    try {
      if (await AppSharedPreferences.getLogIn()) {
        GlobalData.userToken = await AppSharedPreferences.getToken();
        GlobalData.userMemberId = await AppSharedPreferences.getMemberID();
        if (GlobalData.userToken.isNotEmpty &&
            GlobalData.userMemberId.isNotEmpty) {
          bool connectFail = false;

          List<bool> checkList = List<bool>.generate(3, (index) => false);
          uploadPersonalInfo().then((value) {
            checkList[0] = true;
            if (value == false) {
              connectFail = true;
            }
          });
          uploadSignInInfo().then((value) {
            checkList[1] = true;
            if (value == false) {
              connectFail = true;
            }
          });
          uploadTemporaryData().then((value) {
            checkList[2] = true;
            if (value == false) {
              connectFail = true;
            }
          });

          await checkFutureTime(
              logKey: 'autoLogin',
              onCheckFinish: () {
                return !checkList.contains(false) || connectFail;
              });
          if (!connectFail) {
            startUserListener();
            GlobalData.showLoginAnimate = true;
          }
        }
      }
    } catch (e) {}
  }
}
