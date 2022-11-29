import 'package:chewie/chewie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:format/format.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';
import 'package:treasure_nft_project/view_models/course_view_model.dart';
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
  late ChewieController _playerController;

  @override
  void initState() {
    videoController =
        VideoPlayerController.network(getVideoPath(widget.videoStr));
    _playerController = ChewieController(
        videoPlayerController: videoController,
        autoInitialize: true,
        autoPlay: true,
        looping: true,
        allowFullScreen: false,
        aspectRatio: UIDefine.getWidth() / UIDefine.getHeight(),
        customControls: const CupertinoControls(
          backgroundColor: Color.fromRGBO(41, 41, 41, 0.7),
          iconColor: Color.fromARGB(255, 200, 200, 200),
        ),
        placeholder: SizedBox(
          height: UIDefine.getHeight(),
          width: UIDefine.getWidth(),
          child: Image.asset(
            format(AppImagePath.videoCover,
                {'index': VideoStrEnum.values.indexOf(widget.videoStr) + 1}),
            fit: BoxFit.cover,
          ),
        ));
    super.initState();
  }

  @override
  void dispose() {
    videoController.dispose();
    _playerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Chewie(controller: _playerController),
          Positioned(
              top: UIDefine.getHeight() / 17,
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
        ],
      ),
    );
  }

  Widget _buildVideo() {
    return SizedBox.expand(
      child: FittedBox(
        fit: BoxFit.cover,
        child: videoController.value.isInitialized
            ? AspectRatio(
                aspectRatio: videoController.value.aspectRatio,
                child: VideoPlayer(
                  videoController,
                ))
            : Image.asset(
                format(AppImagePath.videoCover, {
                  'index': VideoStrEnum.values.indexOf(widget.videoStr) + 1
                }),
                fit: BoxFit.cover,
              ),
      ),
    );
  }

  double getVideoHeight() {
    return videoController.value.isInitialized
        ? (videoController.value.size.height * 1.2)
        : UIDefine.getHeight();
  }

  double getVideoWidth() {
    return videoController.value.isInitialized
        ? (videoController.value.size.width * 1.2)
        : UIDefine.getWidth();
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
