import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:format/format.dart';
import 'package:treasure_nft_project/utils/language_util.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
import '../../constant/enum/setting_enum.dart';
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
    _videoController = VideoPlayerController.network(_getVideoPath())
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
        height: _videoController.value.isInitialized ? (UIDefine.getWidth() / _videoController.value.aspectRatio) : UIDefine.getPixelHeight(200),
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
                            Transform.scale(scaleX: 1.1, child: Image.asset(_getImagePath())),
                            Opacity(
                                opacity: 0.87,
                                child: CircleAvatar(
                                    radius: UIDefine.getScreenWidth(8),
                                    backgroundColor: Colors.white,
                                    child: Icon(Icons.play_arrow, color: Colors.black, size: UIDefine.getScreenWidth(8))))
                          ])))
              : Container(),
        ));
  }

  void _onStop() {
    _videoController.pause().then((value) => setState(() {}));
  }

  void _onStart() {
    _videoController.seekTo(const Duration(seconds: 0)).then((value) => _videoController.play().then((value) => setState(() {})));
  }

  String _getImagePath() {
    String lang;
    switch (LanguageUtil.getSettingLanguageType()) {
      case LanguageType.Arabic:
        lang = "ar";
        break;
      case LanguageType.Vietnamese:
        lang = "vi";
        break;
      case LanguageType.Turkish:
        lang = "tr";
        break;
      default:
        lang = "en";
        break;
    }

    return format(AppImagePath.videoPoster, {"lang": lang});
  }

  String _getVideoPath() {
    String lang;
    switch (LanguageUtil.getSettingLanguageType()) {
      case LanguageType.Arabic:
        lang = "ar";
        break;
      case LanguageType.Vietnamese:
        lang = "vn";
        break;
      case LanguageType.Turkish:
        lang = "tr";
        break;
      default:
        lang = "en";
        break;
    }
    return format(HttpSetting.homeAdUrl, {"lang": lang});
  }
}
