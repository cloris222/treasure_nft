import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:treasure_nft_project/constant/theme/app_style.dart';
import 'package:treasure_nft_project/widgets/dialog/base_dialog.dart';

import '../../constant/theme/app_image_path.dart';

abstract class BaseCloseDialog extends BaseDialog {
  BaseCloseDialog(super.context, {super.backgroundColor = Colors.transparent});

  @override
  Widget initContent(BuildContext context, StateSetter setState,WidgetRef ref) {
     return Container(
      padding: const EdgeInsets.all(15),
      decoration: AppStyle().styleColorBorderBackground(color: Colors.white,radius: 15),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Image.asset(AppImagePath.dialogCloseBtn),
          ),
          buildBody()
        ],
      ),
    );
  }

  @override
  Widget initTitle() {
    return Container();
  }

  @override
  Future<void> initValue() async {
    // TODO: implement initValue
  }
  Widget buildBody();
}
