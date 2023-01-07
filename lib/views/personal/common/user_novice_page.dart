import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:format/format.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';
import 'package:treasure_nft_project/utils/custom_text_style.dart';
import 'package:treasure_nft_project/view_models/base_view_model.dart';
import 'package:treasure_nft_project/views/personal/common/user_course_video_page.dart';
import 'package:treasure_nft_project/widgets/appbar/title_app_bar.dart';
import 'package:treasure_nft_project/widgets/label/flex_two_text_widget.dart';
import '../../../constant/enum/setting_enum.dart';
import '../../../constant/theme/app_colors.dart';
import '../../../constant/theme/app_image_path.dart';
import '../../../constant/theme/app_style.dart';
import '../../../widgets/app_bottom_navigation_bar.dart';
import '../../custom_appbar_view.dart';

///MARK: 新手教程
class UserNovicePage extends StatefulWidget {
  const UserNovicePage({
    Key? key,
  }) : super(key: key);

  @override
  State<UserNovicePage> createState() => _UserNovicePageState();
}

class _UserNovicePageState extends State<UserNovicePage> {
  @override
  Widget build(BuildContext context) {
    return CustomAppbarView(
      needScrollView: false,
      type: AppNavigationBarType.typePersonal,
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(
              horizontal: UIDefine.getWidth() / 20,
              vertical: UIDefine.getHeight() / 30),
          child: Column(
            children: [
              TitleAppBar(title: tr('uc_novice')),
              _buildTitle(context),
              Container(
                  margin:
                      EdgeInsets.symmetric(vertical: UIDefine.getHeight() / 40),
                  child: _buildVideoGrid(context)),
              SizedBox(height: UIDefine.navigationBarPadding)
            ],
          ),
        ),
      ),
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
          style: AppTextStyle.getBaseStyle(
              fontWeight: FontWeight.w500, fontSize: UIDefine.fontSize20),
        )
      ],
    );
  }

  Widget _buildVideoGrid(BuildContext context) {
    return GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200,
            childAspectRatio: 0.8,
            crossAxisSpacing: 15,
            mainAxisSpacing: 15),
        itemCount: VideoStrEnum.values.length,
        itemBuilder: (BuildContext context, index) {
          return Container(
              alignment: Alignment.center,
              decoration: AppStyle().styleColorBorderBackground(
                  radius: 10, color: AppColors.searchBar, borderLine: 2),
              child: Stack(children: [
                SizedBox(
                  height: UIDefine.getHeight(),
                  width: UIDefine.getWidth(),
                ),
                Positioned(
                    top: 10,
                    bottom: 5,
                    left: 10,
                    right: 10,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              BaseViewModel().pushOpacityPage(
                                  context,
                                  CourseVideoPage(
                                      videoStr: VideoStrEnum.values[index]));
                            },
                            child: Image.asset(
                              format(AppImagePath.videoCover,
                                  {'index': index + 1}),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        FlexTwoTextWidget(
                            text: tr(VideoStrEnum.values[index].name),
                            textAlign: TextAlign.center,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            alignment: Alignment.center),
                      ],
                    )),
              ]));
        });
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
