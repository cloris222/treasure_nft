import 'package:flutter/material.dart';
import 'package:treasure_nft_project/widgets/bottom_sheet/base_bottom_sheet.dart';

class PageBottomSheet extends BaseBottomSheet {
  PageBottomSheet(super.context,
      {required this.page,
      super.needPercentage = true,
      super.percentage = 0.87 + 0.03});

  final Widget page;

  @override
  Widget buildSheetWidget(BuildContext context, StateSetter setState) {
    return _buildBody();
  }

  Widget _buildBody() {
    return Container(
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15), topRight: Radius.circular(15)),
            color: Colors.white),
        padding: const EdgeInsets.only(top: 15),
        child: page);
  }

  @override
  void dispose() {}

  @override
  void init() {}
}
