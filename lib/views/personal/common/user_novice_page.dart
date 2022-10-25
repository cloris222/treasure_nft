import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';
import 'package:treasure_nft_project/view_models/base_view_model.dart';
import 'package:treasure_nft_project/widgets/appbar/custom_app_bar.dart';
import 'package:video_player/video_player.dart';
import '../../../constant/enum/setting_enum.dart';
import '../../../constant/theme/app_colors.dart';
import '../../../constant/theme/app_image_path.dart';
import '../../../constant/theme/app_style.dart';
import '../../../widgets/app_bottom_navigation_bar.dart';

///MARK: 新手教程
class UserNovicePage extends StatefulWidget {
  const UserNovicePage({Key? key}) : super(key: key);

  @override
  State<UserNovicePage> createState() => _UserNovicePageState();
}

class _UserNovicePageState extends State<UserNovicePage> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    _controller = VideoPlayerController.network(
        'https://image.treasurenft.xyz/video/mb_tutorial_01.mp4')
      ..initialize().then((_) {
        setState(() {});
      })
      ..play();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  String getVideoPath(VideoStrEnum videoStrPath) {
    switch (videoStrPath) {
      case VideoStrEnum.SignUp:
        return 'https://image.treasurenft.xyz/video/mb_tutorial_01.mp4';

      case VideoStrEnum.Deposit:
        return 'https://image.treasurenft.xyz/video/mb_tutorial_02.mp4';

      case VideoStrEnum.Buy:
        return 'https://image.treasurenft.xyz/video/mb_tutorial_03.mp4';

      case VideoStrEnum.Withdraw:
        return 'https://image.treasurenft.xyz/video/mb_tutorial_04.mp4';

      case VideoStrEnum.Invite:
        return 'https://image.treasurenft.xyz/video/mb_tutorial_05.mp4';

      case VideoStrEnum.Earings:
        return 'https://image.treasurenft.xyz/video/mb_tutorial_06.mp4';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.getCommonAppBar(() {
        BaseViewModel().popPage(context);
      }, tr('uc_novice')),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(
              horizontal: UIDefine.getWidth() / 20,
              vertical: UIDefine.getHeight() / 30),
          child: Column(
            children: [_buildTitle(context), _buildVideoGrid(context)],
          ),
        ),
      ),
      bottomNavigationBar: const AppBottomNavigationBar(
          initType: AppNavigationBarType.typePersonal),
    );
  }

  Widget _buildTitle(BuildContext context) {
    return Row(
      children: [
        Image.asset(AppImagePath.userGradient),
        const SizedBox(
          width: 5,
        ),
        Text(
          tr("instructionalVideo"),
          style: TextStyle(
              fontWeight: FontWeight.w600, fontSize: UIDefine.fontSize20),
        )
      ],
    );
  }

  Widget _buildVideoGrid(BuildContext context) {
    return Center(
      child: GridView.count(
          primary: false,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,

          /// 顯示格子寬高比
          childAspectRatio: 0.8,
          padding: const EdgeInsets.only(top: 20),
          children: <Widget>[
            Container(
              decoration: AppStyle().styleColorBorderBackground(
                  radius: 10, color: AppColors.searchBar, borderLine: 2),
              child: Stack(
                children: [
                  Positioned(
                      bottom: 5,
                      left: UIDefine.getWidth() / 25,
                      right: 0,
                      child: Text(
                        tr("howSignUp"),
                        style: TextStyle(
                            fontSize: UIDefine.fontSize16,
                            fontWeight: FontWeight.w600),
                      )),
                  Container(
                    child: _controller.value.isInitialized
                        ? AspectRatio(
                            aspectRatio: _controller.value.aspectRatio,
                            child: VideoPlayer(_controller),
                          )
                        : Container(),
                  )
                ],
              ),
            ),
            Container(
              decoration: AppStyle().styleColorBorderBackground(
                  radius: 10, color: AppColors.searchBar, borderLine: 2),
              child: Stack(
                children: [
                  Positioned(
                      bottom: 5,
                      left: UIDefine.getWidth() / 25,
                      right: 0,
                      child: Text(
                        tr("howToDeposit"),
                        style: TextStyle(
                            fontSize: UIDefine.fontSize16,
                            fontWeight: FontWeight.w600),
                      )),
                  Image.asset(AppImagePath.polyImg),
                ],
              ),
            ),
            Container(
              decoration: AppStyle().styleColorBorderBackground(
                  radius: 10, color: AppColors.searchBar, borderLine: 2),
              child: Stack(
                children: [
                  Positioned(
                      bottom: 5,
                      left: UIDefine.getWidth() / 25,
                      right: 0,
                      child: Text(
                        tr("howToBuy"),
                        style: TextStyle(
                            fontSize: UIDefine.fontSize16,
                            fontWeight: FontWeight.w600),
                      )),
                  Image.asset(AppImagePath.polyImg),
                ],
              ),
            ),
            Container(
              decoration: AppStyle().styleColorBorderBackground(
                  radius: 10, color: AppColors.searchBar, borderLine: 2),
              child: Stack(
                children: [
                  Positioned(
                      bottom: 5,
                      left: UIDefine.getWidth() / 25,
                      right: 0,
                      child: Text(
                        tr("howToWithdraw"),
                        style: TextStyle(
                            fontSize: UIDefine.fontSize16,
                            fontWeight: FontWeight.w600),
                      )),
                  Image.asset(AppImagePath.polyImg),
                ],
              ),
            ),
            Container(
              decoration: AppStyle().styleColorBorderBackground(
                  radius: 10, color: AppColors.searchBar, borderLine: 2),
              child: Stack(
                children: [
                  Positioned(
                      bottom: 5,
                      left: UIDefine.getWidth() / 25,
                      right: 0,
                      child: Text(
                        tr("howToViewInvitations"),
                        style: TextStyle(
                            fontSize: UIDefine.fontSize16,
                            fontWeight: FontWeight.w600),
                      )),
                  Image.asset(AppImagePath.polyImg),
                ],
              ),
            ),
            Container(
              decoration: AppStyle().styleColorBorderBackground(
                  radius: 10, color: AppColors.searchBar, borderLine: 2),
              child: Stack(
                children: [
                  Positioned(
                      bottom: 5,
                      left: UIDefine.getWidth() / 25,
                      right: 0,
                      child: Text(
                        tr("howToViewEarnings"),
                        style: TextStyle(
                            fontSize: UIDefine.fontSize16,
                            fontWeight: FontWeight.w600),
                      )),
                  Image.asset(AppImagePath.polyImg),
                ],
              ),
            ),
          ]),
    );
  }
}
