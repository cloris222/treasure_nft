import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../constant/theme/app_colors.dart';
import '../../constant/theme/app_style.dart';
import '../../constant/ui_define.dart';
import '../../utils/app_text_style.dart';
import '../../view_models/announcement/announce_tag_provider.dart';
import '../../view_models/announcement/announcement_view_model.dart';
import '../custom_appbar_view.dart';
import 'announcement_list_view.dart';


///公告欄主頁
class AnnouncementMainPage extends ConsumerStatefulWidget {
  const AnnouncementMainPage({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _AnnouncementListPageState();
}

class _AnnouncementListPageState extends ConsumerState<AnnouncementMainPage> {
  late AnnouncementViewModel viewModel;

  @override
  void initState() {
    ref.read(announceTagProvider.notifier).init(needFocusUpdate: false);
    viewModel = AnnouncementViewModel(onViewChange:()=> setState, ref: ref);
    viewModel.initState();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomAppbarView(
      isAirDrop: true,
      needScrollView: false,
      needBottom: true,
      onLanguageChange: () async {
        await ref.read(announceTagProvider.notifier).init(needFocusUpdate: true);
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
            padding: EdgeInsets.only(top: UIDefine.getPixelWidth(25), bottom: UIDefine.getPixelWidth(15)),
            child: Row(
              children: [
                SizedBox(width: UIDefine.getPixelWidth(20)),
                Text(tr('announcement'),
                    style: AppTextStyle.getBaseStyle(
                        fontSize: UIDefine.fontSize28,
                        fontWeight: FontWeight.w700)),
              ],
            ),
          ),
          Expanded(child: _buildPage())
        ],
      ),
    );
  }

  Widget _buildPage() {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      child: Container(
        color: AppColors.textWhite,
        padding: EdgeInsets.symmetric(horizontal: UIDefine.getPixelWidth(10)),
        child: AnnouncementListView(viewModel,key: UniqueKey(),),
        ),
    );
  }

}