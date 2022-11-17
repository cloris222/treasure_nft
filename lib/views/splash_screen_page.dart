import 'package:flutter/material.dart';
import 'package:treasure_nft_project/constant/theme/app_animation_path.dart';
import 'package:video_player/video_player.dart';

import '../constant/ui_define.dart';

class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({Key? key}) : super(key: key);

  @override
  State<SplashScreenPage> createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    _controller = VideoPlayerController.asset(AppAnimationPath.splashScreen)
      ..initialize().then((value) {
        setState(() {});
        _controller.play();
        _controller.setLooping(true);
      });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SizedBox(
      width: UIDefine.getWidth(),
      height: UIDefine.getHeight(),
      child: _controller.value.isInitialized
          ? AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              child: VideoPlayer(_controller),
            )
          : Container(),
    ));
  }
}
