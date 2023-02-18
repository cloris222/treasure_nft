import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:video_player/video_player.dart';

import '../constant/ui_define.dart';
import '../view_models/splash_screen_view_model.dart';

class SplashScreenPage extends ConsumerStatefulWidget {
  const SplashScreenPage({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends ConsumerState<SplashScreenPage> {
  late SplashScreenViewModel viewModel;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    UIDefine.initial(MediaQuery.of(context));
  }

  @override
  void initState() {
    viewModel = SplashScreenViewModel(
        context: context,
        onViewChange: () {
          if (mounted) {
            setState(() {});
          }
        });
    viewModel.initState(ref);
    super.initState();
  }

  @override
  void dispose() {
    viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: SizedBox.expand(
        child: FittedBox(
          fit: BoxFit.cover,
          child: SizedBox(
            width: getVideoWidth(),
            height: getVideoHeight(),
            child: viewModel.controller.value.isInitialized
                ? AspectRatio(
                    aspectRatio: viewModel.controller.value.aspectRatio,
                    child: VideoPlayer(viewModel.controller),
                  )
                : Container(),
          ),
        ),
      ),
    ));
  }

  double getVideoHeight() {
    return viewModel.controller.value.isInitialized
        ? (viewModel.controller.value.size.height * 2)
        : UIDefine.getHeight();
  }

  double getVideoWidth() {
    return viewModel.controller.value.isInitialized
        ? (viewModel.controller.value.size.width * 2)
        : UIDefine.getWidth();
  }
}
