import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:format/format.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';
import 'package:treasure_nft_project/models/data/course_model_data.dart';
import 'package:treasure_nft_project/view_models/base_view_model.dart';
import 'package:treasure_nft_project/views/personal/common/user_course_video_page.dart';
import 'package:treasure_nft_project/widgets/appbar/custom_app_bar.dart';
import 'package:video_player/video_player.dart';
import '../../../constant/enum/setting_enum.dart';
import '../../../constant/theme/app_colors.dart';
import '../../../constant/theme/app_image_path.dart';
import '../../../constant/theme/app_style.dart';
import '../../../widgets/app_bottom_navigation_bar.dart';

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
            children: [
              _buildTitle(context),
              Container(
                  margin:
                      EdgeInsets.symmetric(vertical: UIDefine.getHeight() / 40),
                  child: _buildVideoGrid(context))
            ],
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
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => CourseVideoPage(
                                            videoStr:
                                                VideoStrEnum.values[index],
                                          )));
                            },
                            child: Image.asset(
                              format(AppImagePath.videoCover,
                                  {'index': index + 1}),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          tr(VideoStrEnum.values[index].name),
                          style: TextStyle(
                              fontSize: UIDefine.fontSize14,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    )),
              ]));
        });
  }
}
