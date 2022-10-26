import 'dart:async';

import 'package:treasure_nft_project/view_models/base_view_model.dart';
import 'package:video_player/video_player.dart';

import '../constant/call_back_function.dart';
import '../constant/enum/setting_enum.dart';

class CourseVideoViewModel extends BaseViewModel{
  CourseVideoViewModel({this.initController,required this.onViewChange,});

  final onClickFunction onViewChange;
  VideoPlayerController? initController;
  late VideoPlayerController videoController;
  /// timer
  Timer? _videoTimer;
  
  Future<void> initState(VideoStrEnum videoStrPath) async{
    if (initController != null) {
      videoController = initController!;
      if (videoController.value.isInitialized) {
        videoController.play();
        videoController.setLooping(true);
      } else {
        _videoTimer =
            Timer.periodic(const Duration(milliseconds: 500), (timer) {
              if (videoController.value.isInitialized) {
                _videoTimer?.cancel();
                videoController.play();
                videoController.setLooping(true);
                onViewChange();
              }
            });
      }
    } else {
      videoController =
          VideoPlayerController.network(getVideoPath(videoStrPath));
      videoController.initialize().then((value) {
        videoController.play();
        videoController.setLooping(true);
        onViewChange();
      });
    }
  }

  void dispose() {
    if (_videoTimer != null) {
      _videoTimer?.cancel();
    }
    if (initController != null) {
      videoController.pause();
      videoController.setLooping(false);
    } else {
      videoController.pause();
      videoController.dispose();
    }
  }

  String getVideoPath(VideoStrEnum videoStrPath) {
    switch (videoStrPath) {
      case VideoStrEnum.howSignUp:
        return 'https://image.treasurenft.xyz/video/mb_tutorial_01.mp4';

      case VideoStrEnum.howToDeposit:
        return 'https://image.treasurenft.xyz/video/mb_tutorial_02.mp4';

      case VideoStrEnum.howToBuy:
        return 'https://image.treasurenft.xyz/video/mb_tutorial_03.mp4';

      case VideoStrEnum.howToWithdraw:
        return 'https://image.treasurenft.xyz/video/mb_tutorial_04.mp4';

      case VideoStrEnum.howToViewInvitations:
        return 'https://image.treasurenft.xyz/video/mb_tutorial_05.mp4';

      case VideoStrEnum.howToViewEarnings:
        return 'https://image.treasurenft.xyz/video/mb_tutorial_06.mp4';
    }
  }
}