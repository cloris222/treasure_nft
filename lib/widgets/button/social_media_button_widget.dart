import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:treasure_nft_project/constant/enum/setting_enum.dart';
import 'package:treasure_nft_project/constant/global_data.dart';
import 'package:treasure_nft_project/constant/theme/app_image_path.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';
import 'package:treasure_nft_project/view_models/base_view_model.dart';

import 'package:url_launcher/url_launcher.dart';

import '../../view_models/home/provider/home_contact_info_provider.dart';

class SocialMediaButtonWidget extends ConsumerWidget {
  const SocialMediaButtonWidget(
      {Key? key, required this.footer, this.size, this.padding})
      : super(key: key);
  final HomeFooter footer;
  final double? size;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Map<String, String> footers = ref.watch(homeContactInfoProvider);
    return Visibility(
      visible: footers[footer.name]?.isNotEmpty ?? false,
      child: GestureDetector(
          onTap: () {
            String link = footers[footer.name] ?? '';
            BaseViewModel().launchInBrowser(getFooterLinkPath(footer, link));
          },
          child: Container(
              width: size ?? UIDefine.getPixelWidth(30),
              height: size ?? UIDefine.getPixelWidth(30),
              margin: padding ??
                  EdgeInsets.symmetric(
                      horizontal: UIDefine.getPixelWidth(5),
                      vertical: UIDefine.getPixelWidth(10)),
              child: Image.asset(
                getFooterImgPath(footer),
                fit: BoxFit.contain,
              ))),
    );
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

  String getFooterLinkPath(HomeFooter footer, String link) {
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
