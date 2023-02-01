import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:treasure_nft_project/constant/global_data.dart';
import 'package:treasure_nft_project/constant/theme/app_colors.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';
import 'package:treasure_nft_project/utils/app_text_style.dart';
import 'package:treasure_nft_project/view_models/home/home_main_viewmodel.dart';
import 'package:treasure_nft_project/views/home/home_pdf_viewer.dart';

class HomeSubInfoView extends StatelessWidget {
  const HomeSubInfoView({Key? key, required this.viewModel}) : super(key: key);
  final HomeMainViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    TextStyle titleStyle = AppTextStyle.getBaseStyle(
        fontSize: UIDefine.fontSize16,
        color: AppColors.textBlack,
        fontWeight: FontWeight.w600);
    TextStyle contentStyle = AppTextStyle.getBaseStyle(
        fontSize: UIDefine.fontSize12,
        color: AppColors.textSixBlack,
        fontWeight: FontWeight.w400);
    double padding = 2;
    return Container(
        padding: EdgeInsets.only(
            top: UIDefine.getPixelWidth(20),
            left: UIDefine.getPixelWidth(20),
            right: UIDefine.getPixelWidth(20)),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          /// Resources
          Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(tr('footer_resource'), style: titleStyle),
                viewModel.buildSpace(height: padding),
                GestureDetector(
                    onTap: () {
                      viewModel.launchInBrowser(
                          'https://treasurenft.gitbook.io/treasurenft-1/');
                    },
                    child: Text(tr('footer_docs'), style: contentStyle)),
                viewModel.buildSpace(height: padding),
                GestureDetector(
                    onTap: () {
                      viewModel.launchInBrowser(
                          'https://treasurenft-metaverse.gitbook.io/how-to-use/earn/how-to-share-invitations');
                    },
                    child: Text(tr('footer_friends'), style: contentStyle)),
                viewModel.buildSpace(height: padding),
                GestureDetector(
                    onTap: () {
                      viewModel.launchInBrowser(
                          'https://treasurenft-metaverse.gitbook.io/how-to-use/earn/how-to-trade');
                    },
                    child: Text(tr('footer_howtoBuy'), style: contentStyle))
              ]),
          viewModel.buildSpace(height: padding),
          /// News
          Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  tr('footer_news'),
                  style: titleStyle,
                ),
                viewModel.buildSpace(height: padding),
                GestureDetector(
                    onTap: () {
                      viewModel.launchInBrowser(
                          'https://medium.com/@Treasurenft_xyz');
                    },
                    child: Text(tr('footer_blog'), style: contentStyle))
              ]),
          viewModel.buildSpace(height: padding),
          /// Company
          Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  tr('footer_company'),
                  style: titleStyle,
                ),
                viewModel.buildSpace(height: padding),
                GestureDetector(
                    onTap: () {
                      viewModel.pushPage(
                          GlobalData.globalKey.currentContext!,
                          PDFViewerPage(
                            viewModel: viewModel,
                            title: tr('footer_privacy'),
                            assetPath: 'assets/pdf/PrivacyPolicy.pdf',
                          ));
                    },
                    child: Text(tr('footer_privacy'), style: contentStyle)),
                viewModel.buildSpace(height: padding),
                GestureDetector(
                    onTap: () {
                      viewModel.pushPage(
                          GlobalData.globalKey.currentContext!,
                          PDFViewerPage(
                            viewModel: viewModel,
                            title: tr('footer_agreement'),
                            assetPath: 'assets/pdf/TermsOfUse.pdf',
                          ));
                    },
                    child: Text(tr('footer_agreement'), style: contentStyle))
              ])
        ]));
  }
}
