import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:treasure_nft_project/constant/theme/app_image_path.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../constant/theme/app_colors.dart';
import '../../constant/theme/app_style.dart';
import '../../constant/ui_define.dart';
import '../../models/http/api/announce_api.dart';
import '../../models/http/parameter/announce_data.dart';
import '../../utils/language_util.dart';
import '../../view_models/announcement/announce_tag_provider.dart';
import '../../view_models/announcement/announcement_view_model.dart';
import '../custom_appbar_view.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:html/parser.dart';



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
      needBottom: true,
      onLanguageChange: () async {
        await ref.read(announceTagProvider.notifier).init(needFocusUpdate: true);
        await _updateData();
        if (mounted) {
          setState(() {
          });
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: UIDefine.getPixelHeight(4), right: UIDefine.getPixelHeight(6)),
                    child:Text(getTime(data.startAt),
                        style: TextStyle(fontSize: UIDefine.fontSize12))),

                    /// 工單842_改為不顯示內文標籤
                    // Expanded(child:Wrap(
                    //     spacing: UIDefine.getPixelWidth(8),
                    //     runSpacing: UIDefine.getPixelHeight(6),
                    //     children:buildTagItem(data.tagId))),
                  ]),

              SizedBox(height: UIDefine.getPixelHeight(26)),
              ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                  child:CachedNetworkImage(
                    imageUrl: data.bannerMbUrl,
                    width: UIDefine.getPixelWidth(355),
                    height: UIDefine.getPixelHeight(207),
                    fit: BoxFit.fitWidth,
                    memCacheWidth: 480,
                    errorWidget: (BuildContext context,
                        String url,
                        dynamic error)=>const SizedBox(),
                    cacheManager: CacheManager(
                      Config("flutterCampus", stalePeriod: const Duration(minutes: 5)),
                    ),
                  )),
              SizedBox(height: UIDefine.getPixelHeight(26)),

              data.content.toString().contains("p>")
                  ? Html(
                  data: data.content,
                  onLinkTap: (String? url, RenderContext context, Map<String, String> attributes, element) {
                   viewModel.launchInBrowser(url!);
                  })
                  :  Text(data.content,
                  style: TextStyle(fontSize: UIDefine.fontSize14)),
              SizedBox(height: UIDefine.getPixelHeight(75)),
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
      widgets.add(
          Row(mainAxisSize: MainAxisSize.min,
              children: [
          ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(6)),
          child:Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.fromLTRB(6, 1, 6, 1),
            height: UIDefine.getPixelHeight(24),
            color: HexColor(viewModel.getTagColor(id)),
            child: Text(viewModel.getTagText(id),
                style: TextStyle(
                  fontSize: UIDefine.fontSize12,
                  color: AppColors.dialogBlack,
                )),
          ))
    ]));
    }
    return widgets;
  }

  Widget _backArrow() {
    return GestureDetector(
      onTap: () => Navigator.pop(context),
      child: Image.asset(AppImagePath.arrowLeftBlack,color: AppColors.textBlack),
    );
  }

  Future<List> updateData() async {
    // String getLang = await AppSharedPreferences.getLanguage();
    String lang = LanguageUtil.getAnnouncementLanguage();
    List<AnnounceData> itemList = [];
    itemList.addAll(await AnnounceAPI().getAnnounceAll(lang: lang));
    return itemList;
  }

  Future<void> _updateData() async {
    try {
      // Fetch the new data based on the current data's ID
      String lang = LanguageUtil.getAnnouncementLanguage();
      List<AnnounceData> newDataList =
      await AnnounceAPI().getAnnounceAll(lang: lang);

      // Find the new data that matches the ID of the current data
      AnnounceData newData = newDataList.firstWhere(
            (data) => data.id == widget.data.id,
        orElse: () => widget.data,
      );
      setState(() {
        widget.data.title = newData.title;
        widget.data.content = newData.content;
        widget.data.content = newData.content;
        widget.data.tagId = newData.tagId;
        widget.data.bannerMbUrl = newData.bannerMbUrl;
        widget.data.bannerPcUrl = newData.bannerPcUrl;
        widget.data.startAt = newData.startAt;
        widget.data.endAt = newData.endAt;
        widget.data.sort = newData.sort;
      });
    } catch (e) {
      print('Error updating data: $e');
    }
  }
}