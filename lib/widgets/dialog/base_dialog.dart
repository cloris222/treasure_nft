import 'package:flutter/material.dart';
import '../../constant/theme/app_colors.dart';
import '../../constant/theme/app_image_path.dart';
import '../../constant/theme/app_theme.dart';
abstract class BaseDialog {
  BaseDialog(this.context,
      {this.radius = 35.0,
      this.isDialogCancel = true,
      this.contentSizeHeight = 15.0,
      this.backgroundColor = AppColors.textWhite});

  BuildContext context;
  double radius;
  bool isDialogCancel;
  double contentSizeHeight;
  Color backgroundColor;

  void initValue();

  Widget initTitle();

  Widget initContent(BuildContext context, StateSetter setState);

  List<Widget> initAction() {
    return <Widget>[];
  }

  Future<void> show() async {
    initValue();
    await showDialog<void>(
      context: context,
      barrierDismissible: isDialogCancel,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: backgroundColor,
          elevation: 0,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(radius))),
          title: initTitle(),
          content: StatefulBuilder(builder: initContent),
          actions: initAction(),
        );
      },
    );
  }

  void closeDialog() {
    Navigator.pop(context);
  }

  //測試用用 可從下淡入
  @deprecated
  Future<void> _showGeneral() async {
    showGeneralDialog(
        context: context,
        pageBuilder: (buildContext, _, __) {
          return Container(margin: const EdgeInsets.all(50), color: Colors.red);
        },
        barrierDismissible: false,
        barrierColor: Colors.black87.withOpacity(0.2),
        transitionDuration: const Duration(milliseconds: 1500),
        transitionBuilder: (context, animation, secondaryAnimation, child) {
          return SlideTransition(
              position:
                  Tween<Offset>(begin: const Offset(0.0, 1.0), end: const Offset(0.0, 0.0))
                      .animate(CurvedAnimation(
                          parent: animation, curve: Curves.fastOutSlowIn)),
              child: FadeTransition(
                  opacity: Tween(begin: 0.0, end: 1.0).animate(
                      CurvedAnimation(parent: animation, curve: Curves.linear)),
                  child: child));
        });
  }

  void onCancel() {
    closeDialog();
  }

  Widget createGeneralTitle({String title = ''}) {
    if (title.isNotEmpty) {
      return Stack(
        alignment: Alignment.centerRight,
        children: [
          AppTheme.style.styleFillText(title,
              alignment: Alignment.center,
              style: const TextStyle(fontWeight: FontWeight.bold)),
          createDialogCloseIcon(),
        ],
      );
    } else {
      return Row(
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [createDialogCloseIcon()]);
    }
  }

  Widget createDialogCloseIcon() {
    return IconButton(
        onPressed: onCancel,
        icon: Image.asset(AppImagePath.dialogClose, width: 15, height: 15));
  }

  Widget createImageWidget(
      {required String asset, double width = 100, double height = 100}) {
    return Image.asset(asset,
        width: width, height: height, fit: BoxFit.contain);
  }

  Widget createContentPadding() {
    return SizedBox(height: contentSizeHeight);
  }

  void clearFocus() {
    FocusScope.of(context).unfocus();
  }
}
