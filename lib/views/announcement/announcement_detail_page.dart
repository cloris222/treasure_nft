import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:treasure_nft_project/constant/theme/app_image_path.dart';
import '../../constant/theme/app_colors.dart';
import '../../constant/theme/app_style.dart';
import '../../constant/ui_define.dart';
import '../../models/http/parameter/announce_data.dart';
import '../../view_models/announcement/announcement_view_model.dart';
import '../custom_appbar_view.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';


///公告詳細資訊
class AnnouncementDetailPage extends ConsumerStatefulWidget {
  const AnnouncementDetailPage({
    Key? key,
    required this.data,
    required this.viewModel,
  }) : super(key: key);

  final AnnounceData data;
  final AnnouncementViewModel viewModel;

  @override
  ConsumerState createState() => _AnnouncementDetailPageState();
}

class _AnnouncementDetailPageState extends ConsumerState<AnnouncementDetailPage> {
  AnnouncementViewModel get viewModel{
    return widget.viewModel;
  }
  AnnounceData get data {
    return widget.data;
  }

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return CustomAppbarView(
      needScrollView: true,
      needBottom: false,
      onLanguageChange: () {
        if (mounted) {
          setState(() {});
        }
      },
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Container(
      decoration: AppStyle()
          .buildGradient(colors: AppColors.gradientBackgroundColorNoFloatBg),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: UIDefine.getPixelHeight(20),
              horizontal: UIDefine.getPixelWidth(8),
            ),
            child: Row(children: [_backArrow()]),
          ),
          _buildPage()
        ],
      ),
    );
  }

  Widget _buildPage() {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      child: Container(
        color: AppColors.textWhite,
        padding: EdgeInsets.symmetric(horizontal: UIDefine.getPixelWidth(20)),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: UIDefine.getPixelHeight(16)),

              Text(data.title,
                  style: TextStyle(fontSize: UIDefine.fontSize16)),

              SizedBox(height: UIDefine.getPixelHeight(11)),

              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                Text(getTime(data.startAt),
                    style: TextStyle(fontSize: UIDefine.fontSize12)),

                Row(children: buildTagItem(data.tagId)),
              ]),

              SizedBox(height: UIDefine.getPixelHeight(26)),
              CachedNetworkImage(
                imageUrl: data.bannerMbUrl,
                fit: BoxFit.cover,
                memCacheWidth: 480,
                cacheManager: CacheManager(
                  Config("flutterCampus", stalePeriod: const Duration(minutes: 5)),
                ),
                width: UIDefine.getWidth(),
              ),
              SizedBox(height: UIDefine.getPixelHeight(26)),

              Text(data.content,
                  style: TextStyle(fontSize: UIDefine.fontSize14)),
              SizedBox(height: UIDefine.getPixelHeight(26)),
            ]),
      ),
    );
  }

  String getTime(String strTime) {
    var dateFormat = DateFormat('yyyy-MM-dd');
    DateTime time = dateFormat.parse(strTime);
    return "${time.year}-${time.month}-${time.day}";
  }

  List<Widget> buildTagItem(List<String> tagId) {
    List<Widget> widgets = [];
    for (String id in tagId) {
      widgets.add(Container(
        alignment: Alignment.bottomCenter,
        margin: EdgeInsets.only(left: UIDefine.getPixelWidth(10)),
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

  Widget _backArrow() {
    return GestureDetector(
      onTap: () => Navigator.pop(context),
      child: Image.asset(AppImagePath.arrowLeftBlack,color: AppColors.textBlack),
    );
  }
}