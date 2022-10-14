import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';
import 'package:treasure_nft_project/view_models/home/home_main_viewmodel.dart';
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
    print('createItemBuilder');
    return ArtistRecordItemView(
      itemData: list[index],
    );
  }

  Widget createSeparatorBuilder(BuildContext context, int index) {
    return Divider(height: UIDefine.getScreenWidth(4.16));
  }



  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return createItemBuilder(context, index);
        },
        itemCount: list.length,
        separatorBuilder: (BuildContext context, int index) {
          return createSeparatorBuilder(context, index);
        });
  }

}