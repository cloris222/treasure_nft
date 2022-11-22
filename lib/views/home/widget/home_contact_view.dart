import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

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
                        children: [
                          GestureDetector(
                            onTap: () {
                              viewModel.launchInBrowser(
                                  'mailto:treasurenft.metaverse@gmail.com');
                            },
                            child: Image.asset(AppImagePath.mail),
                          ),

                          GestureDetector(
                              onTap: () {
                                viewModel.launchInBrowser(
                                    'https://www.tiktok.com/@treasurenft_xyz');
                              },
                              child: Image.asset(AppImagePath.tiktok)),

                          GestureDetector(
                              onTap: () {
                                viewModel.launchInBrowser(
                                    'https://twitter.com/Treasurenft_xyz');
                              },
                              child: Image.asset(AppImagePath.twitter)),

                          // GestureDetector(
                          //   onTap: () {
                          //      viewModel.launchInBrowser('');
                          //   },
                          //   child: Image.asset(AppImagePath.yt),
                          // ),

                          GestureDetector(
                              onTap: () {
                                viewModel.launchInBrowser(
                                    'https://t.me/TreasureNFTchat');
                              },
                              child: Image.asset(AppImagePath.tg)),

                          GestureDetector(
                              onTap: () {
                                viewModel.launchInBrowser(
                                    'https://www.facebook.com/Treasurenft-101676776000520');
                              },
                              child: Image.asset(AppImagePath.fb)),

                          GestureDetector(
                              onTap: () {
                                viewModel.launchInBrowser(
                                    'https://www.instagram.com/treasurenft_xyz/');
                              },
                              child: Image.asset(AppImagePath.ig)),

                          GestureDetector(
                              onTap: () {
                                viewModel.launchInBrowser(
                                    'https://discord.gg/H54mUVeQRQ');
                              },
                              child: Image.asset(AppImagePath.dc))
                        ]),
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
}
