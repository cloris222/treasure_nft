import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:format/format.dart';
import 'package:treasure_nft_project/constant/global_data.dart';
import 'package:treasure_nft_project/utils/date_format_util.dart';
import 'package:treasure_nft_project/utils/number_format_util.dart';
import 'package:treasure_nft_project/widgets/appbar/title_app_bar.dart';
import 'package:treasure_nft_project/widgets/button/login_button_widget.dart';
import 'package:treasure_nft_project/utils/app_text_style.dart';
import '../constant/theme/app_colors.dart';
import '../constant/theme/app_image_path.dart';
import '../constant/ui_define.dart';
import '../models/http/parameter/sign_in_data.dart';
import '../view_models/base_view_model.dart';

///MARK: 每日簽到
class SignInPage extends StatelessWidget {
  const SignInPage({Key? key, required this.data}) : super(key: key);
  final SignInData data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: WillPopScope(
            onWillPop: () async {
              return false;
            },
            child: Container(
              alignment: Alignment.center,
              child: _buildDailyBody(context),
            )));
  }

  Widget _buildDailyBody(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: UIDefine.getScreenWidth(5)),
        child: Column(children: [
          TitleAppBar(title: tr('dailyMissionRewards'), needArrowIcon: false),
          _buildMonth(),
          const SizedBox(height: 10),
          _buildWeek(context),
          const SizedBox(height: 5),
          _buildDays(context),
          LoginButtonWidget(
              radius: 22,
              fontWeight: FontWeight.w600,
              fontSize: UIDefine.fontSize16,
              height: UIDefine.getPixelWidth(45),
              btnText: tr('checkin'),
              onPressed: () => _onPressSignIn(context)),
          const SizedBox(height: 10),
        ]));
  }

  Widget _buildWeek(BuildContext context) {
    return Container(
        height: UIDefine.getPixelWidth(20),
        alignment: Alignment.topCenter,
        child: Row(
          children: List<Widget>.generate(7, (index) {
            String weekText;
            switch (index + 1) {
              case 1:
                {
                  weekText = tr('monday');
                }
                break;
              case 2:
                {
                  weekText = tr('tuesday');
                }
                break;
              case 3:
                {
                  weekText = tr('wednesday');
                }
                break;
              case 4:
                {
                  weekText = tr('thursday');
                }
                break;
              case 5:
                {
                  weekText = tr('friday');
                }
                break;
              case 6:
                {
                  weekText = tr('saturday');
                }
                break;
              default:
                {
                  weekText = tr('sunday');
                }
                break;
            }
            return Expanded(
              child: Container(
                  alignment: Alignment.topCenter,
                  child: Text(
                    weekText,
                    style: AppTextStyle.getBaseStyle(
                        fontWeight: FontWeight.w600,
                        color: AppColors.textNineBlack,
                        fontSize: UIDefine.fontSize12),
                  )),
            );
          }),
        ));
  }

  Widget _buildDays(BuildContext context) {
    List<String> days = [];

    ///補齊前面未滿的部分
    int firstWeek = DateFormatUtil().getCurrentMonthFirstWeek();
    for (int i = firstWeek; i > 1; i--) {
      // days.add(DateFormatUtil().getPreMonthLastDay(i));
      days.add('');
    }

    ///加入當前月份
    days.addAll(DateFormatUtil().getCurrentMonthDays());

    ///補齊後面月份
    int endWeek = DateFormatUtil().getCurrentMonthLastWeek();
    for (int i = 1; i <= 7 - endWeek; i++) {
      // days.add(DateFormatUtil().getNextMonthLastDay(i));
      days.add('');
    }
    String currentDay = DateFormatUtil().getNowTimeWithDayFormat();

    return Expanded(
      child: Center(
        child: MediaQuery.removePadding(
            removeTop: true,
            context: context,
            child: ListView.separated(
              itemBuilder: (BuildContext context, int rowIndex) {
                return Row(
                    children: List<Widget>.generate(
                        7,
                        (index) => Expanded(
                              child: _buildItem(context, index,
                                  days[rowIndex * 7 + index], currentDay),
                            )));
              },
              itemCount: days.length ~/ 7,
              separatorBuilder: (BuildContext context, int index) {
                return SizedBox(height: UIDefine.getPixelWidth(5));
              },
            )),
      ),
    );
  }

  Widget _buildItem(
      BuildContext context, int index, String day, String currentDay) {
    if (day.isEmpty) {
      return const SizedBox();
    }
    String dayPath;
    if (currentDay.compareTo(day) > 0) {
      dayPath = (data.finishedDateList.contains(day))
          ? AppImagePath.dailySignInIcon
          : AppImagePath.dailyFailIcon;
    } else if (currentDay.compareTo(day) == 0) {
      dayPath = AppImagePath.dailyCurrentDay;
    } else {
      dayPath = AppImagePath.dailyUnSignInIcon;
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(dayPath,
            height: UIDefine.getPixelWidth(58), fit: BoxFit.contain),
        Text(
          day.substring(5).replaceAll('-', '.'),
          style: AppTextStyle.getBaseStyle(
              color: AppColors.textSixBlack,
              fontSize: UIDefine.fontSize10,
              fontWeight: FontWeight.w600),
        )
      ],
    );
  }

  void _onPressSignIn(BuildContext context) async {
    GlobalData.signInInfo = null;
    BaseViewModel().popPage(context);
  }

  Widget _buildMonth() {
    String month = format('{year}${tr('year')}{month}${tr('month')}', {
      "year": DateTime.now().year,
      "month": NumberFormatUtil().integerTwoFormat(DateTime.now().month)
    });
    return Text(month,
        style: AppTextStyle.getBaseStyle(
            fontWeight: FontWeight.w600,
            fontSize: UIDefine.fontSize14,
            color: AppColors.textSixBlack));
  }
}
