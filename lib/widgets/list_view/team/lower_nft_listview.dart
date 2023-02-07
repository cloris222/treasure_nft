import 'package:flutter/material.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';
import 'package:treasure_nft_project/models/http/parameter/lower_nft_data.dart';
import 'lower_nft_item.dart';

class LowerNFTListView extends StatefulWidget {
  const LowerNFTListView({
    super.key,
    required this.list,
  });

  final List<LowerNftData> list;

  @override
  State<StatefulWidget> createState() => _LowerNFTListView();
}

class _LowerNFTListView extends State<LowerNFTListView> {
  Widget createItemBuilder(BuildContext context, int index) {
    return LowerNFTItemView(
      itemData: widget.list[index],
    );
  }

  Widget createSeparatorBuilder(BuildContext context, int index) {
    return SizedBox(height: UIDefine.getPixelWidth(10));
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return createItemBuilder(context, index);
        },
        itemCount: widget.list.length,
        separatorBuilder: (BuildContext context, int index) {
          return createSeparatorBuilder(context, index);
        });
  }
}
