import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:treasure_nft_project/constant/theme/app_colors.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';
import 'package:treasure_nft_project/view_models/base_view_model.dart';
import '../../models/http/parameter/announce_data.dart';
import '../../view_models/announcement/announcement_view_model.dart';
import '../../widgets/label/gradually_network_image.dart';
import 'announcement_detail_page.dart';


/// 公告欄 ItemView
class AnnouncementItemView extends StatefulWidget {
  const AnnouncementItemView({
    super.key,
    required this.data,
    required this.viewModel,
  });

  final AnnouncementViewModel viewModel;
  final AnnounceData data;

  @override
  State<StatefulWidget> createState() => _AnnouncementItemViewItemView();
}

class _AnnouncementItemViewItemView extends State<AnnouncementItemView> {

  AnnouncementViewModel get viewModel {
    return widget.viewModel;
  }

  AnnounceData get data {
    return widget.data;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () => BaseViewModel().pushPage(
            context, AnnouncementDetailPage(data: data, viewModel: viewModel)),
        child: Container(
      height: UIDefine.getPixelHeight(120),
      width: UIDefine.getWidth(),
      margin: const EdgeInsets.fromLTRB(8, 3, 8, 3),
      child: Row(children: [
        Expanded(child:
        Column(crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(data.title,
                  style: TextStyle(fontSize: UIDefine.fontSize16)),
              SizedBox(height: UIDefine.getPixelHeight(8)),
              Row(children:buildTagItem(data.tagId)),
              SizedBox(height: UIDefine.getPixelHeight(8)),
              Text(getTime(data.startAt),
                  style: TextStyle(fontSize: UIDefine.fontSize12)),
            ])),

        CachedNetworkImage(
            imageUrl: data.bannerMbUrl),

      ]),
    ));
  }

  List<Widget> buildTagItem(List<String> tagId) {
    List<Widget> widgets = [];
    for (String id in tagId) {
      widgets.add(Container(
        alignment: Alignment.bottomCenter,
        margin: EdgeInsets.only(right: UIDefine.getPixelWidth(10)),
        padding: const EdgeInsets.fromLTRB(6, 1, 6, 2),
        height: UIDefine.getPixelHeight(24),
        color: HexColor(viewModel.getTagColor(id)),
        child: Text(viewModel.getTagText(id),
            style: TextStyle(
                fontSize: UIDefine.fontSize12,
                color: AppColors.dialogBlack,
            )),
      ));
    }
    return widgets;
  }

  String getTime(String strTime) {
    var dateFormat = DateFormat('yyyy-MM-dd');
    DateTime time = dateFormat.parse(strTime);
    return "${time.year}-${time.month}-${time.day}";
  }


}
