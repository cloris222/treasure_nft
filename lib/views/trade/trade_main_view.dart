import 'package:flutter/material.dart';

import '../../widgets/dialog/custom_amount_dialog.dart';
import '../../widgets/dialog/edit_avatar_dialog.dart';

class TradeMainView extends StatelessWidget {
  const TradeMainView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: TextButton(onPressed: () {
          CustomAmountDialog(context, isJumpKeyBoard: () {
            return true;
          }, confirmBtnAction: (){Navigator.pop(context);}).show();
        }, child: Text('tap me')));
  }
}
