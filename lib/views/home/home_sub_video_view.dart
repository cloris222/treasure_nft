import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:format/format.dart';
import 'package:treasure_nft_project/models/http/api/home_api.dart';
import 'package:treasure_nft_project/models/http/parameter/home_film_data.dart';
import 'package:treasure_nft_project/utils/language_util.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
import '../../constant/enum/setting_enum.dart';
import '../../constant/theme/app_colors.dart';
import '../../constant/theme/app_image_path.dart';
import '../../constant/ui_define.dart';
import '../../models/http/http_setting.dart';
import '../../view_models/home/home_main_viewmodel.dart';
import '../../view_models/home/provider/home_film_provider.dart';

class HomeSubVideoView extends ConsumerStatefulWidget {
  const HomeSubVideoView({Key? key});

  // final List<HomeFilmData> data;

  @override
  // State<HomeSubVideoView> createState() => _HomeSubVideoViewState();
  ConsumerState createState() => _HomeSubVideoViewState();
}


class _HomeSubVideoViewState extends ConsumerState<HomeSubVideoView> {
  // HomeFilmData filmData = HomeFilmData();

  List<HomeFilmData> get filmData{
    return ref.read(homeFilmProvider);
  }

  late VideoPlayerController _videoController;
  late ChewieController? _playerController;
  String videoUrl = "";
  String coverImg = "";
  bool _videoInitialized = false;

  @override
  void initState() {
    ref.read(homeFilmProvider.notifier).init(needFocusUpdate: true,onFinish: (){
      if(filmData.isNotEmpty){
        videoUrl = filmData[0].link;
        coverImg = filmData[0].cover;
        _videoController = VideoPlayerController.networkUrl(Uri.parse(videoUrl))
          ..initialize().then((value) {
          setState(() {
            _videoInitialized = true;
            _playerController = ChewieController(
                videoPlayerController: _videoController!,
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
      }
    });
    super.initState();
  }

  @override
  void deactivate() {
    super.deactivate();
  }

  @override
  void dispose() {
    _videoController.dispose();
    _playerController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if(filmData.isNotEmpty && _videoInitialized){
      return
        SizedBox(
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
            child: Stack(
                alignment: Alignment.center, children: [
              Transform.scale(scaleX: 1.1, child:  Image.network(coverImg)
              ),
              Opacity(
                opacity: 0.87,
                child: CircleAvatar(
                  radius: UIDefine.getScreenWidth(8),
                  backgroundColor: Colors.white,
                  child: Icon(Icons.play_arrow, color: Colors.black, size: UIDefine.getScreenWidth(8),
                  ),
                ),
              ),
            ]),
          ),
        )
            : Container(),
      ));
    }else{
      return Container();
    }

  }

  void _onStop() {
    _videoController.pause().then((value) => setState(() {}));
  }

  void _onStart() {
    // if(!_videoController.value.isPlaying){
      _videoController.seekTo(const Duration(seconds: 0)).then((value) {
        _videoController.play().then((value) {
          setState(() {});
        });
      });
    // }
    // _videoController.seekTo(const Duration(seconds: 0)).then((value) => _videoController.play().then((value) => setState(() {})));
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
