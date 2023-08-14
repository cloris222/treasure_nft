import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:treasure_nft_project/constant/global_data.dart';
import 'package:treasure_nft_project/utils/number_format_util.dart';
import 'package:treasure_nft_project/widgets/gradient_text.dart';

import '../../constant/theme/app_colors.dart';
import '../../constant/theme/app_style.dart';
import '../../constant/ui_define.dart';
import '../../utils/app_text_style.dart';
import '../../view_models/internal_message/user_letter_count_provider.dart';
import '../custom_appbar_view.dart';
import '../login/login_common_view.dart';
import 'customer_service_list_view.dart';

class InternalMessageMainPage extends ConsumerStatefulWidget {
  const InternalMessageMainPage({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _InternalMessageMainPageState();
}

class _InternalMessageMainPageState extends ConsumerState<InternalMessageMainPage> with TickerProviderStateMixin {
  int currentIndex = 1;
  final PageController _controller = PageController(initialPage: 1);
  final GlobalKey _serviceKey=GlobalKey();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomAppbarView(
      needScrollView: false,
      onLanguageChange: () {
        if (mounted) {
          setState(() {});
        }
      },
      body: LoginCommonView(
          title: tr('internalMessage'),
          pageHeight: UIDefine.getHeight(),
          body: Container(
            margin: EdgeInsets.symmetric(horizontal: UIDefine.getPixelWidth(10)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildButtonList(),
                SizedBox(
                  height: UIDefine.getHeight() - UIDefine.getPixelWidth(150),
                  child: _buildPage(),
                ),
              ],
            ),
          )),
    );
  }

  Widget _buildButtonList() {
    List<String> titles = [tr("系统通知"), tr("客服通知")];
    return Stack(
      children: [
        Container(
          height: UIDefine.getPixelWidth(50),
          width: UIDefine.getWidth(),
          decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: AppColors.lineBarGrey))),
        ),
        Positioned(
          top: 0,
          bottom: 1,
          left: 0,
          right: 0,
          child: Container(
              margin: EdgeInsets.only(top: UIDefine.getScreenWidth(0)),
              height: UIDefine.getPixelWidth(50),
              child: Row(
                children: [
                  Expanded(
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: titles.length,
                        itemBuilder: (context, index) {
                          return _buildButton(index, titles[index]);
                        }),
                  ),
                  GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    child: GradientText(
                      tr("全部已讀"),
                      colors: AppColors.gradientBaseColorBg,
                      size: UIDefine.fontSize12,
                      weight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(width: UIDefine.getPixelWidth(5)),
                ],
              )),
        ),
      ],
    );
  }

  Widget _buildButton(int index, String type) {
    bool isCurrent = (currentIndex == index);
    int count = index == 1 ? ref.watch(userLetterCountProvider).length : 0;
    String labelHint = count > 99 ? "99+" : NumberFormatUtil().numberCompatFormat(count.toString(), decimalDigits: 0);
    return InkWell(
        onTap: () {
          setState(() {
            currentIndex = index;
            _controller.jumpToPage(index);
          });
        },
        child: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
          SizedBox(height: UIDefine.getPixelWidth(10)),
          Stack(
            fit: StackFit.passthrough,
            alignment: Alignment.center,
            children: [
              Container(
                  height: UIDefine.getPixelWidth(38),
                  padding: EdgeInsets.symmetric(vertical: UIDefine.getPixelWidth(5), horizontal: UIDefine.getPixelWidth(23)),
                  child: Text(
                    type,
                    style: AppTextStyle.getBaseStyle(
                        color: isCurrent ? AppColors.textBlack : AppColors.textThreeBlack, fontSize: UIDefine.fontSize16, fontWeight: isCurrent ? FontWeight.w600 : null),
                  )),
              Positioned(
                  bottom: 0,
                  child: Visibility(
                    visible: isCurrent,
                    child: Container(
                      height: 4,
                      width: UIDefine.getPixelWidth(20),
                      decoration: AppStyle().baseGradient(radius: 3),
                    ),
                  )),
              Positioned(
                  right: 0,
                  top: 0,
                  child: Visibility(
                    visible: count > 0,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(15)),
                      child: CircleAvatar(
                        backgroundColor: AppColors.textRed,
                        radius: UIDefine.getPixelWidth(10 + labelHint.length * 0.75),
                        child: Text(
                          labelHint,
                          style: AppTextStyle.getBaseStyle(color: Colors.white, fontSize: UIDefine.fontSize12, fontWeight: FontWeight.w400, height: 1),
                        ),
                      ),
                    ),
                  ))
            ],
          ),
        ]));
  }

  Widget _buildPage() {
    return PageView(
      controller: _controller,
      onPageChanged: (index) => setState(() => currentIndex = index),
      children: const [
        SizedBox(),
        CustomerServiceListView(),
      ],
    );
  }
}
