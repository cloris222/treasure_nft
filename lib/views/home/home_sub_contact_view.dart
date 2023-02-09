import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:treasure_nft_project/constant/enum/setting_enum.dart';
import 'package:treasure_nft_project/constant/global_data.dart';
import 'package:treasure_nft_project/constant/subject_key.dart';
import 'package:treasure_nft_project/constant/theme/app_colors.dart';
import 'package:treasure_nft_project/utils/observer_pattern/home/home_observer.dart';
import 'package:treasure_nft_project/view_models/home/home_main_viewmodel.dart';
import 'package:treasure_nft_project/widgets/button/social_media_button_widget.dart';
import '../../constant/theme/app_image_path.dart';
import '../../constant/ui_define.dart';

class HomeSubContactView extends StatefulWidget {
  const HomeSubContactView({Key? key, required this.viewModel})
      : super(key: key);
  final HomeMainViewModel viewModel;

  @override
  State<HomeSubContactView> createState() => _HomeSubContactViewState();
}

class _HomeSubContactViewState extends State<HomeSubContactView> {
  HomeMainViewModel get viewModel {
    return widget.viewModel;
  }

  late HomeObserver observer;

  @override
  void initState() {
    String key = SubjectKey.keyHomeContact;
    observer = HomeObserver(key, onNotify: (notification) {
      if (notification.key == key) {
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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(
            top: UIDefine.getPixelWidth(20),
            left: UIDefine.getPixelWidth(20),
            right: UIDefine.getPixelWidth(20)),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Image.asset(AppImagePath.mainAppBarLogo,
              height: UIDefine.getPixelWidth(30), fit: BoxFit.fitHeight),
          getPadding(2),
          Text(
            tr('footer_intro1'),
            style: viewModel.getContextStyle(
                fontSize: UIDefine.fontSize12, color: AppColors.textSixBlack),
          ),
          getPadding(2),
          Wrap(children: _buildFooterButtonList())
        ]));
  }

  Widget getPadding(double val) {
    return Padding(padding: EdgeInsets.all(UIDefine.getScreenWidth(val)));
  }

  List<Widget> _buildFooterButtonList() {
    List<Widget> list = [];
    for (var footer in HomeFooter.values) {
      if (GlobalData.appContactInfo[footer.name]?.isNotEmpty ?? false) {
        list.add(SocialMediaButtonWidget(footer: footer));
      }
    }

    return list;
  }
}
