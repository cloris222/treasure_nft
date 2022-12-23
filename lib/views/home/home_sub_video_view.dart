import 'package:flutter/material.dart';
import 'package:treasure_nft_project/constant/subject_key.dart';
import 'package:treasure_nft_project/constant/theme/app_image_path.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';
import 'package:treasure_nft_project/utils/observer_pattern/home/home_observer.dart';
import 'package:treasure_nft_project/view_models/home/home_main_viewmodel.dart';
import 'package:chewie/chewie.dart';

class HomeSubVideoView extends StatefulWidget {
  const HomeSubVideoView({Key? key, required this.viewModel}) : super(key: key);
  final HomeMainViewModel viewModel;

  @override
  State<HomeSubVideoView> createState() => _HomeSubVideoViewState();
}

class _HomeSubVideoViewState extends State<HomeSubVideoView> {
  HomeMainViewModel get viewModel {
    return widget.viewModel;
  }

  late HomeObserver observer;

  @override
  void initState() {
    String key = SubjectKey.keyHomeVideo;
    observer = HomeObserver(key, onNotify: (notificationKey) {
      if (notificationKey == key) {
        if (mounted) {
          setState(() {});
        }
      }
    });
    viewModel.homeSubject.registerObserver(observer);
    super.initState();
  }

  @override
  void dispose() {
    viewModel.homeSubject.unregisterObserver(observer);
    _onStop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: UIDefine.getWidth(),
        height: viewModel.videoController.value.isInitialized
            ? (UIDefine.getWidth() /
                viewModel.videoController.value.aspectRatio)
            : UIDefine.getPixelHeight(200),
        child: Container(
          child: viewModel.videoController.value.isInitialized
              ? viewModel.videoController.value.isPlaying
                  ? Chewie(
                      controller: viewModel.playerController!,
                    )
                  : Container(
                      color: Colors.white,
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(UIDefine.getScreenWidth(2)),
                      child: InkWell(
                          onTap: _onStart,
                          child: Stack(alignment: Alignment.center, children: [
                            Image.asset(AppImagePath.videoImg,
                                height: UIDefine.getScreenHeight(15)),
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
    viewModel.videoController.pause().then((value) => onViewChange());
  }

  void _onStart() {
    viewModel.videoController.seekTo(const Duration(seconds: 0)).then((value) =>
        viewModel.videoController.play().then((value) => onViewChange()));
  }

  void onViewChange() {
    if (mounted) {
      setState(() {});
    }
  }
}
