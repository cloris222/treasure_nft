import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:treasure_nft_project/widgets/dialog/base_dialog.dart';


class ShareDialog extends BaseDialog {
  ShareDialog(super.context);


  @override
  Widget initContent(BuildContext context, StateSetter setState) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [



      ],
    );
  }

  @override
  Widget initTitle() {
    return Container();
  }

  @override
  Future<void> initValue() async{
  }
}
