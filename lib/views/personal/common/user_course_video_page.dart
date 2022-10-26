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
  late CourseVideoViewModel viewModel;

  @override
  void initState() {
    viewModel = CourseVideoViewModel(onViewChange: () {
      setState(() {});
    });
    viewModel.initState(widget.videoStr);
    super.initState();
  }

  @override
  void dispose() {
    viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Stack(
      children: [
        _buildVideo(),
        Positioned(top: UIDefine.getHeight()/17,
            left: 5,
            child: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new,color: Colors.white,),
              onPressed: () {
                Navigator.pop(context);
              },
            ))
      ],
    ),);
  }

  Widget _buildVideo() {
    return SizedBox.expand(
      child: FittedBox(
        fit: BoxFit.cover,
        child: SizedBox(
          width: getVideoWidth(),
          height: getVideoHeight(),
          child: viewModel.videoController.value.isInitialized
              ? AspectRatio(
                  aspectRatio: viewModel.videoController.value.aspectRatio,
                  child: VideoPlayer(
                    viewModel.videoController,
                  ))
              : Image.asset(
                  format(AppImagePath.videoCover, {
                    'index': VideoStrEnum.values.indexOf(widget.videoStr) + 1
                  }),
                  fit: BoxFit.cover,
                ),
        ),
      ),
    );
  }

  double getVideoHeight() {
    return viewModel.videoController.value.isInitialized
        ? (viewModel.videoController.value.size.height * 1.2)
        : UIDefine.getHeight();
  }

  double getVideoWidth() {
    return viewModel.videoController.value.isInitialized
        ? (viewModel.videoController.value.size.width * 1.2)
        : UIDefine.getWidth();
  }
}
