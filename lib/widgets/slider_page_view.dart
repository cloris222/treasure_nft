import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import 'package:treasure_nft_project/utils/app_text_style.dart';

import '../constant/call_back_function.dart';
import '../constant/theme/app_colors.dart';
import '../constant/theme/app_style.dart';
import '../constant/ui_define.dart';

class SliderPageView extends StatefulWidget {
  const SliderPageView(
      {Key? key,
      required this.topView,
      required this.titles,
      required this.initialPage,
      required this.children,
      this.onPageListener,
      this.backgroundColor,
      this.needMargin = false,
      this.marginValue = 4.5,
      this.buttonDecoration})
      : super(key: key);

  /// button title
  final List<String> titles;
  final int initialPage;
  final List<Widget> children;
  final Widget topView;
  final onGetIntFunction? onPageListener;
  final Color? backgroundColor;
  final Decoration? buttonDecoration;
  final bool needMargin;
  final double marginValue;

  @override
  State<SliderPageView> createState() => _SliderPageViewState();
}

class _SliderPageViewState extends State<SliderPageView> {
  /// pageView
  late PageController pageController;
  ItemScrollController listController = ItemScrollController();

  /// 判斷當前頁面
  late String currentType;
  late int currentIndex;

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: widget.initialPage);
    currentType = widget.titles[widget.initialPage];
    currentIndex = widget.initialPage;
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery.removePadding(
        context: context,
        removeBottom: true,
        child: SizedBox(
            height: UIDefine.getHeight(),
            child: SafeArea(
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(child: widget.topView),
                  SliverFillRemaining(
                    child: Container(
                      color: widget.backgroundColor,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(mainAxisSize: MainAxisSize.min, children: [
                        _buildButtonList(),
                        Expanded(child: _buildPageView()),
                      ])))
            ]))));
  }

  Widget _buildButtonList() {
    return Stack(
      children: [
        Container(
          height: UIDefine.getPixelWidth(50) +
              (widget.needMargin
                  ? UIDefine.getScreenWidth(widget.marginValue)
                  : 0),
          width: UIDefine.getWidth(),
          decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(color: AppColors.lineBarGrey))),
        ),
        Positioned(
          top: 0,
          bottom: 1,
          left: 0,
          right: 0,
          child: Container(
              margin: widget.needMargin
                  ? EdgeInsets.only(
                      top: UIDefine.getScreenWidth(widget.marginValue))
                  : EdgeInsets.only(top: UIDefine.getScreenWidth(0)),
              decoration: widget.buttonDecoration,
              height: UIDefine.getPixelWidth(50),
              child: ScrollablePositionedList.builder(
                  initialScrollIndex: widget.initialPage,
                  scrollDirection: Axis.horizontal,
                  itemScrollController: listController,
                  itemCount: widget.titles.length,
                  itemBuilder: (context, index) {
                    return _buildButton(index, widget.titles[index]);
                  })),
        ),
      ],
    );
  }

  Widget _buildButton(int index, String type) {
    bool isCurrent = (currentIndex == index);
    return InkWell(
        onTap: () {
          setState(() {
            currentIndex = index;
            currentType = type;
            pageController.jumpToPage(widget.titles.indexOf(type));
          });
        },
        child: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
          SizedBox(height: UIDefine.getPixelWidth(10)),
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                  height: UIDefine.getPixelWidth(38),
                  padding: EdgeInsets.symmetric(
                      vertical: UIDefine.getPixelWidth(5),
                      horizontal: UIDefine.getPixelWidth(23)),
                  child: Text(
                    type,
                    style: AppTextStyle.getBaseStyle(
                        color: isCurrent
                            ? AppColors.textBlack
                            : AppColors.textThreeBlack,
                        fontSize: UIDefine.fontSize16,
                        fontWeight: isCurrent ? FontWeight.w600 : null),
                  )),
              // Positioned(
              //     bottom: 0,
              //     left: 0,
              //     right: 0,
              //     child: Container(
              //       height: 1,
              //       color: AppColors.lineBarGrey,
              //     )),
              Positioned(
                  bottom: 0,
                  child: Visibility(
                    visible: isCurrent,
                    child: Container(
                      height: 4,
                      width: UIDefine.getPixelWidth(20),
                      decoration: AppStyle().baseGradient(radius: 3),
                    ),
                  ))
            ],
          ),
          // SizedBox(height: UIDefine.getPixelWidth(5)),
        ]));
  }

  Widget _buildPageView() {
    return PageView(
      controller: pageController,
      onPageChanged: _onPageChange,
      children: widget.children,
    );
  }

  void _onPageChange(int pageIndex) {
    setState(() {
      currentType = widget.titles[pageIndex];
      currentIndex = pageIndex;

      ///MARK: 判斷是否有需要監聽換頁
      if (widget.onPageListener != null) {
        widget.onPageListener!(pageIndex);
      }

      listController.scrollTo(
          index: pageIndex, duration: const Duration(milliseconds: 300));
    });
  }
}
