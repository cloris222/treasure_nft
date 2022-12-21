import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:treasure_nft_project/constant/global_data.dart';
import 'package:treasure_nft_project/constant/theme/app_colors.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';
import 'package:treasure_nft_project/view_models/home/home_main_viewmodel.dart';
import 'package:treasure_nft_project/views/home/home_pdf_viewer.dart';

class HomeSubInfoView extends StatelessWidget {
  const HomeSubInfoView({Key? key,required this.viewModel}) : super(key: key);
  final HomeMainViewModel viewModel;
  @override
  Widget build(BuildContext context) {
    double padding = 2;
    return Container(
        color: AppColors.mainBottomBg,
        padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Resources
              Flexible(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(tr('footer_resource'),
                            style: TextStyle(
                                fontSize: UIDefine.fontSize16,
                                color: AppColors.textBlack)),
                        viewModel.buildSpace(height: padding),
                        GestureDetector(
                            onTap: () {
                              viewModel.launchInBrowser(
                                  'https://treasurenft.gitbook.io/treasurenft-1/');
                            },
                            child: Text(tr('footer_docs'),
                                style: TextStyle(
                                    fontSize: UIDefine.fontSize14,
                                    color: AppColors.font02))),
                        viewModel.buildSpace(height: padding),
                        GestureDetector(
                            onTap: () {
                              viewModel.launchInBrowser(
                                  'https://treasurenft-metaverse.gitbook.io/how-to-use/earn/how-to-share-invitations');
                            },
                            child: Text(tr('footer_friends'),
                                style: TextStyle(
                                    fontSize: UIDefine.fontSize14,
                                    color: AppColors.font02))),
                        viewModel.buildSpace(height: padding),
                        GestureDetector(
                            onTap: () {
                              viewModel.launchInBrowser(
                                  'https://treasurenft-metaverse.gitbook.io/how-to-use/earn/how-to-trade');
                            },
                            child: Text(tr('footer_howtoBuy'),
                                style: TextStyle(
                                    fontSize: UIDefine.fontSize14,
                                    color: AppColors.font02)))
                      ])),

              /// News
              Flexible(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          tr('footer_news'),
                          style: TextStyle(
                            fontSize: UIDefine.fontSize16,
                            color: AppColors.textBlack,
                          ),
                        ),
                        viewModel.buildSpace(height: padding),
                        GestureDetector(
                            onTap: () {
                              viewModel.launchInBrowser(
                                  'https://medium.com/@Treasurenft_xyz');
                            },
                            child: Text(tr('footer_blog'),
                                style: TextStyle(
                                    fontSize: UIDefine.fontSize14,
                                    color: AppColors.font02)))
                      ])),

              /// Company
              Flexible(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          tr('footer_company'),
                          style: TextStyle(
                            fontSize: UIDefine.fontSize16,
                            color: AppColors.textBlack,
                          ),
                        ),
                        viewModel.buildSpace(height: padding),
                        GestureDetector(
                            onTap: () {
                              viewModel.pushPage(
                                  GlobalData.globalKey.currentContext!,
                                  PDFViewerPage(
                                    title: tr('footer_privacy'),
                                    assetPath: 'assets/pdf/PrivacyPolicy.pdf',
                                  ));
                            },
                            child: Text(tr('footer_privacy'),
                                style: TextStyle(
                                    fontSize: UIDefine.fontSize14,
                                    color: AppColors.font02))),
                        viewModel.buildSpace(height: padding),
                        GestureDetector(
                            onTap: () {
                              viewModel.pushPage(
                                  GlobalData.globalKey.currentContext!,
                                  PDFViewerPage(
                                    title: tr('footer_agreement'),
                                    assetPath: 'assets/pdf/TermsOfUse.pdf',
                                  ));
                            },
                            child: Text(tr('footer_agreement'),
                                style: TextStyle(
                                    fontSize: UIDefine.fontSize14,
                                    color: AppColors.font02)))
                      ]))
            ]));
  }
}
