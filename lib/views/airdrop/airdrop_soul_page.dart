import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../constant/theme/app_style.dart';
import '../../constant/ui_define.dart';

class AirdropSoulPage extends ConsumerStatefulWidget {
  const AirdropSoulPage({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _AirdropDailyPageState();
}

class _AirdropDailyPageState extends ConsumerState<AirdropSoulPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: AppStyle().buildAirdropBackground(),
      padding: EdgeInsets.all(UIDefine.getPixelWidth(5)),
      child: SingleChildScrollView(
        child: Column(),
      ),
    );
  }
}
