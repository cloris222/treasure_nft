import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:treasure_nft_project/constant/theme/app_colors.dart';
import 'package:treasure_nft_project/constant/theme/app_style.dart';
import 'package:treasure_nft_project/models/http/parameter/announce_data.dart';
import 'package:treasure_nft_project/view_models/base_view_model.dart';
import 'package:treasure_nft_project/views/announcement/announcement_detail_page.dart';
import 'package:treasure_nft_project/views/announcement/announcement_main_page.dart';
import '../../constant/enum/style_enum.dart';
import '../../constant/theme/app_image_path.dart';
import '../../constant/ui_define.dart';
import '../../utils/app_text_style.dart';
import '../../view_models/announcement/announcement_view_model.dart';
import '../../widgets/button/login_button_widget.dart';


/// 登入公告彈窗
class AnnouncementDialogPage extends ConsumerStatefulWidget {
  const AnnouncementDialogPage(this.data, {
    Key? key,
  }) : super(key: key);

  final AnnounceData data;

  @override
  ConsumerState createState() => _AnnouncementDialogPageState();
}

class _AnnouncementDialogPageState extends ConsumerState<AnnouncementDialogPage> {
  BaseViewModel viewModel = BaseViewModel();
  late AnnouncementViewModel announcementViewModel;

  @override
  void initState() {
    announcementViewModel = AnnouncementViewModel(onViewChange: ()=> setState, ref: ref);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: AppColors.opacityBackground,
        body: GestureDetector(
            // onTap: () => viewModel.popPage(context),
            onTap: () => {},
            child: Container(
                constraints: const BoxConstraints.expand(),
                color: Colors.transparent,
                child: GestureDetector(
                  onTap: () {},
                  child: Center(
                    child: Stack(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: UIDefine.getPixelWidth(15)),
                          child: _buildBackground(child: _buildBody(context, false)),
                        ),

                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: UIDefine.getPixelWidth(25)),
                          child: _buildBody(context, true),
                        ),

                        Positioned(
                            top: 40,
                            right: 50,
                            child: InkWell(
                                onTap: () => viewModel.popPage(context),
                                child: Image.asset(AppImagePath.dialogCloseBtn)))
                      ],
                    ),
                  ),
                ))));
  }

  Widget _buildBackground({required Widget child}) {
    return Container(
      width: UIDefine.getWidth(),
      margin: EdgeInsets.symmetric(horizontal: UIDefine.getPixelWidth(25)),
      padding: EdgeInsets.all(UIDefine.getPixelWidth(12)),
      decoration: AppStyle().styleColorsRadiusBackground(
          color: Colors.white.withOpacity(0.3), radius: 15),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Container(
          decoration: const BoxDecoration(
              color: Colors.white,
              image: DecorationImage(
                  image: AssetImage(AppImagePath.backgroundDeposit),
                  fit: BoxFit.cover)),
          child: child,
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context, bool vis) {
    return Visibility(
        visible: vis,
        maintainState: true,
        maintainAnimation: true,
        maintainSize: true,
        child:Container(
            width: UIDefine.getWidth(),
            margin: EdgeInsets.symmetric(horizontal: UIDefine.getPixelWidth(25)),
            padding: EdgeInsets.all(UIDefine.getPixelWidth(24)),
            child:Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(AppImagePath.mainAppBarLogo,
                    height: 35, fit: BoxFit.fitHeight),

                SizedBox(height: UIDefine.getPixelHeight(24)),

                Stack(children: [
                  // Image.asset(AppImagePath.noticeBackground, fit: BoxFit.fitWidth),
                  Text("Notification",
                      style: AppTextStyle.getBaseStyle(
                          color: AppColors.textBlack,
                          fontSize: UIDefine.fontSize28,
                          fontWeight: FontWeight.w800,
                          fontFamily: AppTextFamily.PosteramaText)
                  ),
                ]),

                SizedBox(height: UIDefine.getPixelHeight(24)),

                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: UIDefine.getPixelWidth(10),
                      vertical: UIDefine.getPixelWidth(15)),
                  width: UIDefine.getWidth(),
                  decoration: AppStyle().baseBolderGradient(radius:12, borderWidth: 2),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                  Html(
                  data: widget.data.title,
                    style: {
                      "*": Style(
                          fontSize: FontSize(UIDefine.fontSize12),
                          color: AppColors.textBlack,
                          fontWeight: FontWeight.w600,
                          padding: EdgeInsets.zero,
                          fontFamily: AppTextFamily.PosteramaText.name
                      ),
                    },
                  ),

                        // Text(widget.data.title,
                        //     maxLines: 4,
                        //     overflow: TextOverflow.ellipsis,
                        //     style: AppTextStyle.getBaseStyle(
                        //         color: AppColors.textBlack,
                        //         fontSize: UIDefine.fontSize12,
                        //         fontWeight: FontWeight.w600,
                        //         fontFamily: AppTextFamily.PosteramaText)),

                        SizedBox(height: UIDefine.getPixelHeight(8)),

                        // widget.data.content.toString().contains("p>")
                        //     ?
                        Html(
                            data: widget.data.content,
                            onLinkTap: (String? url, RenderContext context, Map<String, String> attributes, element) {
                              viewModel.launchInBrowser(url!);
                            },
                            style: {
                                "*": Style(
                                  maxLines: 3,
                                  fontSize: FontSize(UIDefine.fontSize12),
                                  fontWeight: FontWeight.w400,
                                  padding: EdgeInsets.zero,
                                  fontFamily: AppTextFamily.PosteramaText.name
                                ),
                              },
                            )

                            // :  Text(widget.data.content,
                            // maxLines: 4,
                            // overflow: TextOverflow.ellipsis,
                            // style: AppTextStyle.getBaseStyle(
                            //     color: AppColors.textBlack,
                            //     fontSize: UIDefine.fontSize12,
                            //     fontWeight: FontWeight.w400,
                            //     fontFamily:
                            //     AppTextFamily.PosteramaText)),

                      ]),
                ),

                SizedBox(height: UIDefine.getPixelHeight(30)),


                Row(mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                  SizedBox(
                      width: UIDefine.getPixelWidth(195),
                      child:LoginButtonWidget(
                          padding: EdgeInsets.symmetric(
                              horizontal: UIDefine.getPixelWidth(10)),
                          isFillWidth: false,
                          radius: 45,
                          btnText: tr('go'),
                          textColor: AppColors.textBlack,
                          fontSize: UIDefine.fontSize20,
                          onPressed: () => viewModel.pushPage(
                              context, AnnouncementDetailPage(data: widget.data, viewModel: announcementViewModel)))),
                ]),



              ],
            )));
  }



}
