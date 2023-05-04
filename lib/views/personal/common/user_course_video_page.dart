import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:format/format.dart';
import 'package:treasure_nft_project/constant/theme/app_colors.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';
import 'package:treasure_nft_project/utils/language_util.dart';
import 'package:treasure_nft_project/view_models/base_view_model.dart';
import 'package:video_player/video_player.dart';

import '../../../constant/enum/setting_enum.dart';
import '../../../constant/theme/app_image_path.dart';

class CourseVideoPage extends StatefulWidget {
  const CourseVideoPage({Key? key, required this.videoStr}) : super(key: key);

  final VideoStrEnum videoStr;

  @override
  State<CourseVideoPage> createState() => _CourseVideoPageState();
}

class _CourseVideoPageState extends State<CourseVideoPage> {
  late VideoPlayerController videoController;
  ChewieController? _playerController;

  @override
  void initState() {
    videoController =
        VideoPlayerController.network(getVideoPath(widget.videoStr));
    videoController.initialize().then((value) {
      setState(() {
        if (mounted) {
          _playerController = ChewieController(
              videoPlayerController: videoController,
              autoPlay: true,
              looping: true,
              allowFullScreen: false,
              aspectRatio: UIDefine.getWidth() /
                  (UIDefine.getHeight() - MediaQuery
                      .of(context)
                      .padding
                      .top),
              customControls: const CupertinoControls(
                backgroundColor: Color.fromRGBO(41, 41, 41, 0.7),
                iconColor: Color.fromARGB(255, 200, 200, 200),
              ));
        }
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    videoController.dispose();
    _playerController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.opacityBackground,
        body: Stack(children: [
          Padding(
            padding: EdgeInsets.only(top: MediaQuery
                .of(context)
                .padding
                .top),
            child: videoController.value.isInitialized
                ? Chewie(controller: _playerController!)
                : SizedBox(
                width: getVideoWidth(),
                height: getVideoHeight(),
                child: Image.asset(
                  LanguageUtil.getAppStrLanguage() == "vi"
                      ? format(AppImagePath.videoCoverVi, {
                    'index': VideoStrEnum.values.indexOf(widget.videoStr) + 1
                  })
                      : format(AppImagePath.videoCover, {
                    'index': VideoStrEnum.values.indexOf(widget.videoStr) + 1
                  }),
                  fit: BoxFit.cover,
                )),
          ),
          Positioned(
              top: MediaQuery
                  .of(context)
                  .padding
                  .top,
              left: 5,
              child: IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios_new,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ))
        ]));
  }


  double getVideoHeight() {
    return videoController.value.isInitialized
        ? (videoController.value.size.height)
        : UIDefine.getHeight();
  }

  double getVideoWidth() {
    return videoController.value.isInitialized
        ? (videoController.value.size.width)
        : UIDefine.getWidth();
  }

  String getVideoPath(VideoStrEnum videoStrPath) {
    String path = "";
    if (LanguageUtil.getAppStrLanguage() == "vi") {
      path =
        "https://image.treasurenft.xyz/PC/video/vn_mb_tutorial_{number}.mp4";
    } else {
      path =
        "https://image.treasurenft.xyz/PC/video/mb_tutorial_{number}.mp4";
    }
    switch (videoStrPath) {
      case VideoStrEnum.howSignUp:
        return format(path, {"number": "01"});

      case VideoStrEnum.howToDeposit:
        return format(path, {"number": "02"});

      case VideoStrEnum.howToBuy:
        return format(path, {"number": "03"});

      case VideoStrEnum.howToWithdraw:
        return format(path, {"number": "04"});

      case VideoStrEnum.howToViewInvitations:
        return format(path, {"number": "05"});

      case VideoStrEnum.howToViewEarnings:
        return format(path, {"number": "06"});
    }
  }
}
