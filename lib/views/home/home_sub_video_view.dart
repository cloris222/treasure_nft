import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import '../../constant/theme/app_image_path.dart';
import '../../constant/ui_define.dart';
import '../../models/http/http_setting.dart';

class HomeSubVideoView extends StatefulWidget {
  const HomeSubVideoView({Key? key}) : super(key: key);

  @override
  State<HomeSubVideoView> createState() => _HomeSubVideoViewState();
}

class _HomeSubVideoViewState extends State<HomeSubVideoView> {
  late VideoPlayerController _videoController;
  ChewieController? _playerController;

  @override
  void initState() {
    _videoController = VideoPlayerController.network(HttpSetting.homeAdUrl)
      ..initialize().then((value) {
        setState(() {
          _playerController = ChewieController(
              videoPlayerController: _videoController,
              looping: true,
              customControls: const CupertinoControls(
                backgroundColor: Color.fromRGBO(41, 41, 41, 0.7),
                iconColor: Color.fromARGB(255, 200, 200, 200),
              ),
              deviceOrientationsOnEnterFullScreen: [
                DeviceOrientation.landscapeLeft,
                DeviceOrientation.landscapeRight,
              ]);
        });
      });

    super.initState();
  }

  @override
  void dispose() {
    _videoController.dispose();
    _playerController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: UIDefine.getWidth(),
        height: _videoController.value.isInitialized
            ? (UIDefine.getWidth() / _videoController.value.aspectRatio)
            : UIDefine.getPixelHeight(200),
        child: Container(
          child: _videoController.value.isInitialized
              ? _videoController.value.isPlaying
                  ? Chewie(
                      controller: _playerController!,
                    )
                  : Container(
                      color: Colors.white,
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(UIDefine.getScreenWidth(2)),
                      child: InkWell(
                          onTap: _onStart,
                          child: Stack(alignment: Alignment.center, children: [
                            Image.asset(AppImagePath.walletConnectCheckIcon,
                                height: UIDefine.getScreenHeight(15),
                            ),

                            Opacity(
                                opacity: 0.87,
                                child: CircleAvatar(
                                    radius: UIDefine.getScreenWidth(8),
                                    backgroundColor: Colors.white,
                                    child: Icon(Icons.play_arrow,
                                        color: Colors.black,
                                        size: UIDefine.getScreenWidth(8))))
                          ])))
              : Container(),
        ));
  }

  void _onStop() {
    _videoController.pause().then((value) => setState(() {}));
  }

  void _onStart() {
    _videoController.seekTo(const Duration(seconds: 0)).then(
        (value) => _videoController.play().then((value) => setState(() {})));
  }

  Future<File> genThumbnailFile(String path) async {
    final fileName = await VideoThumbnail.thumbnailFile(
      video: path,
      thumbnailPath: (await getTemporaryDirectory()).path,
      imageFormat: ImageFormat.PNG,
      maxHeight: 100, // specify the height of the thumbnail, let the width auto-scaled to keep the source aspect ratio
      quality: 75,
    );
    File file = File(fileName!);
    return file;
  }
}
