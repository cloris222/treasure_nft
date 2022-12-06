import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';
import 'package:treasure_nft_project/view_models/home/home_main_viewmodel.dart';
import '../../../constant/theme/app_colors.dart';
import 'artist_record_item.dart';

class ArtistRecordListView extends StatefulWidget {
  const ArtistRecordListView({super.key});

  @override
  State<StatefulWidget> createState() => _ArtistRecordListView();
}

class _ArtistRecordListView extends State<ArtistRecordListView> {
  HomeMainViewModel viewModel = HomeMainViewModel();
  late List list = [];

  @override
  void initState() {
    super.initState();
    viewModel.getArtistRecord().then((value) => {
          list = value,
          setState(() {}),
        });
  }

  Widget createItemBuilder(BuildContext context, int index) {
    return ArtistRecordItemView(
      itemData: list[index],
    );
  }

  Widget createSeparatorBuilder(BuildContext context, int index) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Divider(height: 5, color: AppColors.bolderGrey, thickness: 1),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      ListView.separated(
          padding: EdgeInsets.zero,
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return createItemBuilder(context, index);
          },
          itemCount: list.length,
          separatorBuilder: (BuildContext context, int index) {
            return createSeparatorBuilder(context, index);
          }),
      createSeparatorBuilder(context, 1)
    ]);
  }
}
