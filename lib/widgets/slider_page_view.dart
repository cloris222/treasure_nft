import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../constant/call_back_function.dart';
import '../constant/theme/app_colors.dart';
import '../constant/theme/app_style.dart';
import '../constant/ui_define.dart';
import 'label/flex_two_text_widget.dart';

class SliderPageView extends StatefulWidget {
  const SliderPageView({
    Key? key,
    required this.topView,
    required this.titles,
    required this.initialPage,
    required this.children,
    this.getPageIndex,
  }) : super(key: key);

  /// button title
  final List<String> titles;
  final int initialPage;
  final List<Widget> children;
  final Widget topView;
  final onGetIntFunction? getPageIndex;

  @override
  State<SliderPageView> createState() => _SliderPageViewState();
}

class _SliderPageViewState extends State<SliderPageView> {
  /// pageView
  late PageController pageController;

  /// 判斷當前頁面
  late String currentType;

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: widget.initialPage);
    currentType = widget.titles[widget.initialPage];
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery.removePadding(
        context: context,
        removeBottom: true,
        child: SizedBox(
            height: UIDefine.getHeight(),
            child: SafeArea(
                child: CustomScrollView(slivers: [
              SliverToBoxAdapter(child: widget.topView),
              SliverFillRemaining(
                  child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(children: [
                        _buildButtonList(),
                        Flexible(child: _buildPageView()),
                        SizedBox(height: UIDefine.getScreenHeight(10))
                      ])))
            ]))));
  }

  Widget _buildButtonList() {
    return Container(
      height: UIDefine.fontSize16 + 50,
      alignment: Alignment.bottomLeft,
      child: ListView(
          scrollDirection: Axis.horizontal,
          children:
              List<Widget>.from(widget.titles.map((e) => _buildButton(e)))),
    );
  }

  Widget _buildButton(String type) {
    bool isCurrent = (currentType == type);

    return InkWell(
        onTap: () {
          setState(() {
            currentType = type;
            pageController.jumpToPage(widget.titles.indexOf(type));
          });
        },
        child: Column(children: [
          const SizedBox(height: 15),
          Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
              decoration: AppStyle().styleColorBorderBottomLine(
                  borderLine: isCurrent ? 2 : 1,
                  color: isCurrent
                      ? AppColors.mainThemeButton
                      : AppColors.barFont01),
              child: Text(
                type,
                style: TextStyle(
                    color:
                        isCurrent ? AppColors.textBlack : AppColors.dialogGrey,
                    fontSize: UIDefine.fontSize16,
                    fontWeight: FontWeight.w500),
              )),
          const SizedBox(height: 5),
        ]));
  }

  Widget _buildPageView() {
    return PageView(
      controller: pageController,
      scrollDirection: Axis.horizontal,
      pageSnapping: true,
      onPageChanged: _onPageChange,
      children: widget.children,
    );
  }

  void _onPageChange(int pageIndex) {
    setState(() {
      currentType = widget.titles[pageIndex];
      if (widget.getPageIndex != null) {
        widget.getPageIndex!(pageIndex);
      }
    });
  }
}
