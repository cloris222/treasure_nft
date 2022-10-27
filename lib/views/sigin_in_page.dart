import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:format/format.dart';
import 'package:treasure_nft_project/constant/global_data.dart';
import 'package:treasure_nft_project/utils/date_format_util.dart';
import 'package:treasure_nft_project/utils/number_format_util.dart';
import 'package:treasure_nft_project/widgets/button/login_button_widget.dart';
import 'package:treasure_nft_project/widgets/label/icon/base_icon_widget.dart';
import '../constant/theme/app_colors.dart';
import '../constant/theme/app_image_path.dart';
import '../constant/ui_define.dart';
import '../models/http/parameter/sign_in_data.dart';
import '../view_models/base_view_model.dart';
import '../widgets/label/gradient_bolder_widget.dart';

///MARK: 每日簽到
class SignInPage extends StatelessWidget {
  const SignInPage({Key? key, required this.data}) : super(key: key);
  final SignInData data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.opacityBackground,
        body: WillPopScope(
            onWillPop: () async {
              return false;
            },
            child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(
                    vertical: MediaQuery.of(context).padding.top,
                    horizontal: MediaQuery.of(context).padding.top),
                child: GradientBolderWidget(
                    height: UIDefine.getHeight() * 0.85,
                    child: Column(children: [
                      Image.asset(AppImagePath.signInBar, fit: BoxFit.fitWidth),
                      Flexible(child: _buildDailyBody(context))
                    ])))));
  }

  Widget _buildDailyBody(BuildContext context) {
    List<String> days = DateFormatUtil().getCurrentMonthDays();
    String currentDay = DateFormatUtil().getNowTimeWithDayFormat();
    return Container(
        margin: EdgeInsets.symmetric(horizontal: UIDefine.getScreenWidth(5)),
        height: UIDefine.getHeight(),
        child: Column(children: [
          _buildTitle(context),
          Container(
            height: UIDefine.getHeight() * 0.55,
            alignment: Alignment.topCenter,
            child: MediaQuery.removePadding(
                removeTop: true,
                context: context,
                child: GridView.builder(
                  itemBuilder: (BuildContext context, int index) =>
                      _buildItem(context, index, days[index], currentDay),
                  itemCount: days.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 5,
                      childAspectRatio: 1,
                      mainAxisSpacing: UIDefine.getScreenWidth(1),
                      crossAxisSpacing: UIDefine.getScreenWidth(1)),
                )),
          ),
          LoginButtonWidget(
              radius: 5,
              fontSize: UIDefine.fontSize16,
              height: UIDefine.fontSize30,
              btnText: tr('checkin'),
              onPressed: () => _onPressSignIn(context)),
        ]));
  }

  Widget _buildTitle(BuildContext context) {
    return Stack(children: [
      SizedBox(
        width: UIDefine.getWidth(),
        child: Text('　  ${tr('dailyMissionRewards')}',
            softWrap: true,
            maxLines: 3,
            style: TextStyle(
                fontWeight: FontWeight.w500, fontSize: UIDefine.fontSize20)),
      ),
      Positioned(
          top: 0,
          left: 0,
          child: Image.asset(AppImagePath.signTitle,
              height: UIDefine.fontSize24, fit: BoxFit.contain))
    ]);
  }

  Widget _buildItem(
      BuildContext context, int index, String day, String currentDay) {
    double size = UIDefine.getScreenWidth(16);
    String dayPath;
    bool needMask = false;
    if (currentDay.compareTo(day) > 0) {
      dayPath = (data.finishedDateList.contains(day))
          ? AppImagePath.dailySignInIcon
          : AppImagePath.dailyFailIcon;
    } else if (currentDay.compareTo(day) == 0) {
      dayPath = AppImagePath.dailyCurrentDay;
    } else {
      needMask = true;
      dayPath = format(AppImagePath.dailyDayIcon,
          {'day': NumberFormatUtil().integerTwoFormat(index + 1)});
    }

    return needMask
        ? ShaderMask(
            blendMode: BlendMode.lighten,
            shaderCallback: (Rect bounds) {
              return LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.white.withOpacity(0.3),
                    Colors.white.withOpacity(0.4)
                  ]).createShader(
                  Rect.fromLTWH(0, 0, bounds.width, bounds.height));
            },
            child: _buildImage(size, dayPath))
        : _buildImage(size, dayPath);
  }

  Widget _buildImage(double size, String dayPath) {
    return Stack(children: [
      BaseIconWidget(
        imageAssetPath: dayPath,
        size: size,
      ),
      Positioned(
          bottom: 3,
          right: 3,
          child: BaseIconWidget(
            imageAssetPath: AppImagePath.dailyPointIcon,
            size: UIDefine.getScreenWidth(7.5),
          ))
    ]);
  }

  void _onPressSignIn(BuildContext context) async {
    GlobalData.signInInfo = null;
    BaseViewModel().popPage(context);
  }
}
