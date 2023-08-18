import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:treasure_nft_project/views/main_page.dart';
import 'package:treasure_nft_project/views/setting_language_page.dart';

import '../../constant/app_routes.dart';
import '../../constant/enum/setting_enum.dart';
import '../../constant/theme/app_image_path.dart';
import '../../constant/ui_define.dart';
import '../../utils/app_text_style.dart';
import '../../view_models/base_view_model.dart';
import '../../view_models/home/provider/home_contact_info_provider.dart';
import '../app_bottom_navigation_bar.dart';

class MenuButtonWidget extends ConsumerWidget {
  const MenuButtonWidget({
    Key? key,
    required this.iconSize,
    required this.isMainPage,
    required this.serverAction,
    required this.globalAction,
    required this.mainAction,
  }) : super(key: key);
  final double iconSize;
  final bool isMainPage;
  final VoidCallback serverAction;
  final VoidCallback globalAction;
  final VoidCallback mainAction;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Map<String, dynamic> footers = ref.watch(homeContactInfoProvider);
    return Center(
      child: DropdownButtonHideUnderline(
        child: DropdownButton2(
          customButton: Image.asset(AppImagePath.menuIcon,
              width: iconSize, height: iconSize, fit: BoxFit.contain),
          items: [
            ...MenuIcon.values
                .map((MenuIcon type) => DropdownMenuItem<MenuIcon>(
                      value: type,
                      child: _buildCell(type),
                    ))
          ],
          onChanged: (type) {
            if (type != null) {
              _onTapType(context, type, footers);
            }
          },
          barrierColor: const Color(0x78000000),
          itemHeight: UIDefine.getPixelWidth(50),
          itemPadding: const EdgeInsets.only(left: 16, right: 16),
          dropdownWidth: UIDefine.getPixelWidth(200),
          dropdownPadding: const EdgeInsets.symmetric(vertical: 6),
          dropdownDecoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: Colors.white,
          ),
          dropdownElevation: 8,
          offset: const Offset(40, -4),
        ),
      ),
    );
  }

  Widget _buildCell(MenuIcon type) {
    String imgPath;
    String cellTitle;
    Color? color;
    switch (type) {
      case MenuIcon.home:
        imgPath = AppImagePath.homeImage;
        cellTitle = tr("Home");
        break;
      case MenuIcon.language:
        imgPath = AppImagePath.globalImage;
        cellTitle = tr("language");
        break;
      case MenuIcon.service:
        imgPath = AppImagePath.serverImage;
        cellTitle = tr("uc_contact");
        break;
      case MenuIcon.telegram:
        imgPath = AppImagePath.tg;
        cellTitle = tr("Telegram");
        break;
      case MenuIcon.internalMessage:
        imgPath = AppImagePath.internalMessageBtn;
        cellTitle = tr("stationMessage");
        break;
    }
    Widget item = Row(
      children: [
        Image.asset(
          imgPath,
          width: UIDefine.getPixelWidth(25),
          height: UIDefine.getPixelWidth(25),
          color: color,
          fit: BoxFit.contain,
        ),
        SizedBox(width: UIDefine.getPixelWidth(5)),
        Expanded(
          child: Text(cellTitle,
              textAlign: TextAlign.start,
              style: AppTextStyle.getBaseStyle(
                  fontSize: UIDefine.fontSize16, fontWeight: FontWeight.w500)),
        ),
      ],
    );

    // if (type == MenuIcon.language) {
    //   return LanguageButtonWidget(
    //       iconSize: iconSize, isMainPage: isMainPage, customButton: item);
    // }
    return item;
  }

  void _onTapType(
      BuildContext context, MenuIcon type, Map<String, dynamic> footers) {
    var viewModel = BaseViewModel();
    switch (type) {
      case MenuIcon.home:
        mainAction();
        break;
      case MenuIcon.language:
        BaseViewModel().pushOpacityPage(
            context, SettingLanguagePage(isMainPage: isMainPage));
        break;
      case MenuIcon.service:
        serverAction();
        break;
      case MenuIcon.telegram:
        _showTelegram(footers);
        break;
      case MenuIcon.internalMessage:
        {
          if (viewModel.isLogin()) {
            AppRoutes.pushInternalMessage(context);
          } else {
            viewModel.pushAndRemoveUntil(
                context, const MainPage(type: AppNavigationBarType.typeLogin));
          }
        }
        break;
    }
  }

  void _showTelegram(Map<String, dynamic> footers) {
    String link = footers[HomeFooter.Telegram.name] ?? '';
    BaseViewModel().launchInBrowser(link);
  }
}
