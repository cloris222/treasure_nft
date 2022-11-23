import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:format/format.dart';
import 'package:treasure_nft_project/constant/enum/setting_enum.dart';

import '../../../constant/theme/app_colors.dart';
import '../../../constant/theme/app_image_path.dart';
import '../../../constant/ui_define.dart';
import '../../../view_models/home/home_contact_view_model.dart';

class HomeContactView extends StatefulWidget {
  const HomeContactView({Key? key}) : super(key: key);

  @override
  State<HomeContactView> createState() => _HomeContactViewState();
}

class _HomeContactViewState extends State<HomeContactView> {
  late HomeContactViewModel viewModel;

  @override
  void initState() {
    viewModel = HomeContactViewModel();
    viewModel.initState().then((value) {
      if (mounted) {
        setState(() {});
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: AppColors.mainBottomBg,
        child: Column(children: [
          Padding(
              padding: EdgeInsets.only(
                  top: UIDefine.getScreenWidth(2),
                  left: UIDefine.getScreenWidth(6),
                  right: UIDefine.getScreenWidth(6)),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    getPadding(5),

                    Text(tr('footer_contactUs'),
                        style: TextStyle(
                            fontSize: UIDefine.fontSize16,
                            color: AppColors.textBlack)),
                    getPadding(2),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: _buildFooterButtonList()),
                    // viewModel.getPadding(4),
                    // Text(
                    //   tr('document-title-2'),
                    //   style: TextStyle(
                    //       fontSize: UIDefine.fontSize16,
                    //       color: AppColors.textBlack,
                    //       height: 1.3),
                    // ),
                    // viewModel.getPadding(2),
                    // Text(
                    //   tr('document-text-1'),
                    //   style: TextStyle(
                    //       fontSize: UIDefine.fontSize14,
                    //       color: AppColors.textGrey,
                    //       height: 1.3),
                    // ),
                    // viewModel.getPadding(10),
                    // Center(
                    //     child: Text('Copyright 2022',
                    //         style: TextStyle(
                    //           fontSize: UIDefine.fontSize14,
                    //           color: AppColors.textBlack,
                    //         ))),
                    getPadding(5),
                    Center(
                        child: Text('TreasureMeta Technology',
                            style: TextStyle(
                                fontSize: UIDefine.fontSize14,
                                color: AppColors.textBlack))),
                    getPadding(5),
                  ]))
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
