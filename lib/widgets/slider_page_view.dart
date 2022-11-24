import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import '../constant/call_back_function.dart';
import '../constant/theme/app_colors.dart';
import '../constant/theme/app_style.dart';
import '../constant/ui_define.dart';

class SliderPageView extends StatefulWidget {
  const SliderPageView({
    Key? key,
    required this.topView,
    required this.titles,
    required this.initialPage,
    required this.children,
    this.onPageListener,
  }) : super(key: key);

  /// button title
  final List<String> titles;
  final int initialPage;
  final List<Widget> children;
  final Widget topView;
  final onGetIntFunction? onPageListener;

  @override
  State<SliderPageView> createState() => _SliderPageViewState();
}

class _SliderPageViewState extends State<SliderPageView> {
  /// pageView
  late PageController pageController;
  ItemScrollController listController = ItemScrollController();

  /// 判斷當前頁面
  late String currentType;

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: widget.initialPage);
    currentType = widget.titles[widget.initialPage];
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
                child: CustomScrollView(slivers: [
              SliverToBoxAdapter(child: widget.topView),
              SliverFillRemaining(
                  child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(children: [
                        _buildButtonList(),
                        Expanded(child: _buildPageView()),
                        SizedBox(height: UIDefine.getScreenHeight(10))
                      ])))
            ]))));
  }

  Widget _buildButtonList() {
    return SizedBox(
        height: UIDefine.getPixelHeight(70),
        child: ScrollablePositionedList.builder(
            initialScrollIndex: widget.initialPage,
            scrollDirection: Axis.horizontal,
            itemScrollController: listController,
            itemCount: widget.titles.length,
            itemBuilder: (context, index) {
              return _buildButton(widget.titles[index]);
            }));
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
          SizedBox(height: UIDefine.getPixelHeight(15)),
          Container(
              padding: EdgeInsets.symmetric(
                  vertical: UIDefine.getPixelHeight(10),
                  horizontal: UIDefine.getPixelWidth(10)),
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
          SizedBox(height: UIDefine.getPixelHeight(5)),
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

      ///MARK: 判斷是否有需要監聽換頁
      if (widget.onPageListener != null) {
        widget.onPageListener!(pageIndex);
      }

      listController.scrollTo(
          index: pageIndex, duration: const Duration(milliseconds: 300));
    });
  }
}
