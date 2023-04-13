import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:treasure_nft_project/constant/theme/app_image_path.dart';
import 'package:treasure_nft_project/constant/theme/app_style.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';
import 'package:treasure_nft_project/utils/app_text_style.dart';
import 'package:treasure_nft_project/view_models/gobal_provider/user_info_provider.dart';
import 'package:treasure_nft_project/widgets/button/login_bolder_button_widget.dart';
import 'package:treasure_nft_project/widgets/label/gradually_network_image.dart';

import '../../../models/http/parameter/treasure_box_record.dart';
import '../../../view_models/base_view_model.dart';
import '../../../views/collection/collection_medal_share_page.dart';
import '../../label/icon/base_icon_widget.dart';

class CollectionMedalItemView extends ConsumerWidget {
  const CollectionMedalItemView({Key? key, required this.record})
      : super(key: key);
  final TreasureBoxRecord record;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
        decoration: AppStyle().styleColorsRadiusBackground(radius: 12),
        padding: EdgeInsets.all(UIDefine.getPixelWidth(8)),
        child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                child: GraduallyNetworkImage(
                  imageUrl: record.medal,
                  height: UIDefine.getPixelWidth(150),
                  width: UIDefine.getPixelWidth(150),
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding:
                    EdgeInsets.symmetric(vertical: UIDefine.getPixelWidth(5)),
                child: Text(record.medalName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyle.getBaseStyle(
                        fontSize: UIDefine.fontSize14,
                        fontWeight: FontWeight.w600)),
              ),
              Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: UIDefine.getPixelWidth(5)),
                  child: Row(children: [
                    Expanded(
                        child: LoginBolderButtonWidget(
                      height: UIDefine.getPixelWidth(30),
                      fontSize: UIDefine.fontSize12,
                      fontWeight: FontWeight.w400,
                      radius: 14,
                      btnText: tr("appSetAvatar"),
                      onPressed: () => _onSetAvatar(context, ref),
                    )),
                    Expanded(
                        child: GestureDetector(
                      onTap: () => _onShare(context),
                      child: Container(
                          height: UIDefine.getPixelWidth(30),
                          padding: EdgeInsets.symmetric(
                              horizontal: UIDefine.getPixelWidth(10),
                              vertical: UIDefine.getPixelWidth(5)),
                          decoration: AppStyle().baseGradient(radius: 14),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(tr("share"),
                                  style: AppTextStyle.getBaseStyle(
                                      fontSize: UIDefine.fontSize12,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w400)),
                              BaseIconWidget(
                                  imageAssetPath: AppImagePath.airdropShare,
                                  color: Colors.white,
                                  size: UIDefine.getPixelWidth(15)),
                            ],
                          )),
                    ))
                  ]))
            ]));
  }

  void _onShare(BuildContext context) {
    BaseViewModel().pushOpacityPage(
        context,
        CollectionMedalSharePage(
          medal: record.medal,
          medalName: record.medalName,
        ));
  }

  void _onSetAvatar(BuildContext context, WidgetRef ref) {
    ref.read(userInfoProvider.notifier).setAvatarMedal(context, record.medal);
  }
}
