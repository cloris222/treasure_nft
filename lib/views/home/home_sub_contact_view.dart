import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:treasure_nft_project/constant/enum/setting_enum.dart';
import 'package:treasure_nft_project/constant/subject_key.dart';
import 'package:treasure_nft_project/utils/observer_pattern/home/home_observer.dart';
import 'package:treasure_nft_project/view_models/home/home_main_viewmodel.dart';
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
          Image.asset(AppImagePath.mainAppBarLogo),
          getPadding(2),
          Text(
            tr('footer_intro1'),
            style: viewModel.getContextStyle(),
          ),
          getPadding(2),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: _buildFooterButtonList()),
            ],
          )
        ]));
  }

  Widget getPadding(double val) {
    return Padding(padding: EdgeInsets.all(UIDefine.getScreenWidth(val)));
  }

  List<Widget> _buildFooterButtonList() {
    List<Widget> list = [];
    for (var footer in HomeFooter.values) {
      if (viewModel.status[footer.name]?.isNotEmpty ?? true) {
        list.add(GestureDetector(
            onTap: () {
              viewModel.launchInBrowser(getFooterLinkPath(footer));
            },
            child: Image.asset(getFooterImgPath(footer))));
      }
    }

    return list;
  }

  String getFooterImgPath(HomeFooter footer) {
    switch (footer) {
      case HomeFooter.Email:
        return AppImagePath.mail;
      case HomeFooter.Tiktok:
        return AppImagePath.tiktok;
      case HomeFooter.Twitter:
        return AppImagePath.twitter;
      case HomeFooter.Youtube:
        return AppImagePath.yt;
      case HomeFooter.Telegram:
        return AppImagePath.tg;
      case HomeFooter.Facebook:
        return AppImagePath.fb;
      case HomeFooter.Instagram:
        return AppImagePath.ig;
      case HomeFooter.Discord:
        return AppImagePath.dc;
    }
  }

  String getFooterLinkPath(HomeFooter footer) {
    String link = viewModel.status[footer.name] ?? '';
    switch (footer) {
      case HomeFooter.Email:
        return 'mailto:$link';
      case HomeFooter.Tiktok:
      case HomeFooter.Twitter:
      case HomeFooter.Youtube:
      case HomeFooter.Telegram:
      case HomeFooter.Facebook:
      case HomeFooter.Instagram:
      case HomeFooter.Discord:
        return link;
    }
  }
}
