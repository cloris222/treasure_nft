import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:format/format.dart';
import 'package:treasure_nft_project/models/http/api/home_api.dart';
import 'package:treasure_nft_project/models/http/parameter/home_film_data.dart';
import 'package:treasure_nft_project/utils/language_util.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../../constant/enum/setting_enum.dart';
import '../../constant/theme/app_colors.dart';
import '../../constant/theme/app_image_path.dart';
import '../../constant/ui_define.dart';
import '../../models/http/http_setting.dart';

class HomeSubVideoView extends StatefulWidget {
  const HomeSubVideoView({Key? key, required this.data}) : super(key: key);

  final List<HomeFilmData> data;

  @override
  State<HomeSubVideoView> createState() => _HomeSubVideoViewState();
}

class _HomeSubVideoViewState extends State<HomeSubVideoView> {
  late YoutubePlayerController _controller;
  late TextEditingController _idController;
  late TextEditingController _seekToController;
  late PlayerState _playerState;
  late YoutubeMetaData _videoMetaData;
  double _volume = 100;
  bool _muted = false;
  bool _isPlayerReady = false;

  String link = "";
  String videoName = "";

  late VideoPlayerController _videoController;
  ChewieController? _playerController;
  String youtubeId = "";

  @override
  void initState() {
    link = widget.data[0].link;
    videoName = widget.data[0].name;
    // print("name1: ${widget.data[0].name}");
    // print("name2: ${widget.data[1].name}");
    print("link1: ${link}");
    if(videoName == "Youtube"){
      if(link.isNotEmpty){
        String? videoId = YoutubePlayer.convertUrlToId(link);
        if(videoId != null){
          youtubeId = videoId;
        }
      }
      _controller = YoutubePlayerController(
        initialVideoId: youtubeId,
        flags: const YoutubePlayerFlags(
          mute: false,
          autoPlay: false,
          disableDragSeek: false,
          loop: false,
          isLive: false,
          forceHD: false,
          enableCaption: true,
        ),
      )..addListener(listener);
      _idController = TextEditingController();
      _seekToController = TextEditingController();
      _videoMetaData = const YoutubeMetaData();
      _playerState = PlayerState.unknown;
    }else{
      ///MARK: 本機影片
      _videoController = VideoPlayerController.network(
          // _getVideoPath()
       link
      )..initialize().then((value) {
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
    }
    super.initState();
  }

  void listener() {
    if (_isPlayerReady && mounted && !_controller.value.isFullScreen) {
      setState(() {
        _playerState = _controller.value.playerState;
        _videoMetaData = _controller.metadata;
      });
    }
  }

  @override
  void deactivate() {
    // Pauses video while navigating to next page.
    _controller.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    _controller.dispose();
    _idController.dispose();
    _seekToController.dispose();
    _videoController.dispose();
    _playerController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return videoName =="Youtube"?
      YoutubePlayer(
        controller: _controller,
        showVideoProgressIndicator: true,
        progressIndicatorColor: AppColors.mainThemeButton,
        topActions: <Widget>[
          const SizedBox(width: 8.0),
          Expanded(
            child: Text(
              _controller.metadata.title,
              style: const TextStyle(
                color: AppColors.textWhite,
                fontSize: 18.0,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
          IconButton(
            icon: const Icon(
              Icons.settings,
              color: AppColors.textWhite,
              size: 25.0,
            ),
            onPressed: () {
              print('Settings Tapped!');
            },
          ),
        ],
        onReady: () {
          _isPlayerReady = true;
        },
        onEnded: (data) {
        },
      ):
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
                child: Stack(alignment: Alignment.center, children: [
                  Transform.scale(scaleX: 1.1, child: Image.asset(_getImagePath())),
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
        ),
      );
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
