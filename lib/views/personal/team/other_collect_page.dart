import 'package:flutter/material.dart';

import '../../../view_models/personal/team/other_collect_viewmodel.dart';

///MARK: 其他買/賣家的收藏
class OtherCollectPage extends StatefulWidget {
  const OtherCollectPage(
      {Key? key, required this.orderNo, required this.isSeller})
      : super(key: key);
  final String orderNo;
  final bool isSeller;

  @override
  State<OtherCollectPage> createState() => _OtherCollectPageState();
}

class _OtherCollectPageState extends State<OtherCollectPage> {
  late OtherCollectViewModel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = OtherCollectViewModel(onViewUpdate: () {
      if (mounted) {
        setState(() {});
      }
    });
    viewModel.initState(widget.orderNo, widget.isSeller);
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
