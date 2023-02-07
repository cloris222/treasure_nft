import 'package:flutter/material.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';
import 'package:treasure_nft_project/models/http/parameter/lower_invite_data.dart';
import 'lower_invite_item.dart';

class LowerInviteListView extends StatefulWidget {
  const LowerInviteListView({
    super.key,
    required this.list,
  });

  final List<LowerInviteData> list;

  @override
  State<StatefulWidget> createState() => _LowerInviteListView();
}

class _LowerInviteListView extends State<LowerInviteListView> {
  Widget createItemBuilder(BuildContext context, int index) {
    return LowerInviteItemView(
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
