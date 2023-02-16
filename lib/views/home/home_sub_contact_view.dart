import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:treasure_nft_project/constant/enum/setting_enum.dart';
import 'package:treasure_nft_project/constant/global_data.dart';
import 'package:treasure_nft_project/constant/subject_key.dart';
import 'package:treasure_nft_project/constant/theme/app_colors.dart';
import 'package:treasure_nft_project/utils/observer_pattern/home/home_observer.dart';
import 'package:treasure_nft_project/view_models/home/home_main_viewmodel.dart';
import 'package:treasure_nft_project/views/home/home_main_style.dart';
import 'package:treasure_nft_project/widgets/button/social_media_button_widget.dart';
import '../../constant/theme/app_image_path.dart';
import '../../constant/ui_define.dart';
import '../../view_models/home/provider/home_contact_info_provider.dart';

class HomeSubContactView extends ConsumerWidget with HomeMainStyle {
  const HomeSubContactView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Map<String, String> footers = ref.watch(homeContactInfoProvider);
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
            style: getContextStyle(
                fontSize: UIDefine.fontSize12, color: AppColors.textSixBlack),
          ),
          getPadding(2),
          Wrap(children: _buildFooterButtonList(footers))
        ]));
  }

  List<Widget> _buildFooterButtonList(Map<String, String> footers) {
    List<Widget> list = [];
    for (var footer in HomeFooter.values) {
      if (footers[footer.name]?.isNotEmpty ?? false) {
        list.add(SocialMediaButtonWidget(footer: footer));
      }
    }

    return list;
  }
}
