import 'package:easy_localization/easy_localization.dart';
import 'package:treasure_nft_project/utils/number_format_util.dart';

import 'language_util.dart';

class DateFormatUtil {
  String _buildDataFormat(
      {required String strFormat,
      required DateTime time,
      bool needLocale = false}) {
    return DateFormat(
            strFormat, needLocale ? LanguageUtil.getTimeLocale() : "en")
        .format(time);
  }

  DateTime _getNow() {
    return DateTime.now();
  }

  String buildFormat({required String strFormat, required DateTime time}) {
    return _buildDataFormat(strFormat: strFormat, time: time);
  }

  ///MARK: 2022/09/06 11:46 AM
  String getDateWith12HourFormat(DateTime time) {
    return _buildDataFormat(strFormat: 'yyyy/MM/dd hh:mm a', time: time);
  }

  ///MARK: 2022-09-06 11:46 AM
  String getDateWith12HourFormat2(DateTime time) {
    return _buildDataFormat(strFormat: 'yyyy-MM-dd hh:mm a', time: time);
  }

  ///MARK: 06 Sep 2022
  String getDateWithDayMouthYear(DateTime time) {
    return _buildDataFormat(strFormat: 'dd LLL yyyy', time: time);
  }

  /// calculate time
  String calculateTime(DateTime commentTime) {
    var result = '';
    var starTime = commentTime;
    var endTime = DateTime.now();
    var timeLag = endTime.difference(starTime);

    var second = timeLag.inSeconds;
    var minutes = timeLag.inMinutes;
    var hour = timeLag.inHours;
    var day = timeLag.inDays;
    var week = endTime.difference(starTime).inDays % 7;

    if (week > 7) {
      return week.toString();
    } else if (day > 1 || day == 1) {
      return day.toString();
    } else if (hour < 24 && hour > 0) {
      return hour.toString();
    } else if (minutes > 0 && minutes < 60) {
      return minutes.toString();
    } else if (second >= 0 && second < 60) {
      return second.toString();
    } else {
      return result;
    }
  }

  ///Increase one day & 8AM
  String increaseOneDay(DateTime time) {
    var newDate = DateTime(time.year, time.month, time.day + 1, 8, 0);
    return _buildDataFormat(strFormat: 'yyyy-MM-dd hh:mm a', time: newDate);
  }

  ///InterestsCalculation
  String interestsCalculation(DateTime startTime, int duration) {
    var newDate01 =
        DateTime(startTime.year, startTime.month, startTime.day + 1);
    var newDate02 =
        DateTime(newDate01.year, newDate01.month, newDate01.day + duration);
    return _buildDataFormat(strFormat: 'yyyy-MM-dd hh:mm a', time: newDate02);
  }

  ///redemptionDate
  String redemptionDate(DateTime startTime, int duration) {
    var newDate01 =
        DateTime(startTime.year, startTime.month, startTime.day + 1, 8, 0);
    var newDate02 = DateTime(
        newDate01.year, newDate01.month, newDate01.day + duration + 1, 8);
    return _buildDataFormat(strFormat: 'yyyy-MM-dd hh:mm a', time: newDate02);
  }

  ///MARK: 18:46 24H
  String getNowTimeWith24HourFormat() {
    return _buildDataFormat(strFormat: 'HH:mm', time: _getNow());
  }

  /// 現在時間 ex: 2022-10-18
  String getNowTimeWithDayFormat() {
    return getTimeWithDayFormat(time: _getNow());
  }

  /// ex: 2022-10-18
  String getTimeWithDayFormat({DateTime? time}) {
    return _buildDataFormat(strFormat: 'yyyy-MM-dd', time: time ?? _getNow());
  }

  /// 現在時間 ex: 2022-10-18
  String getFullWithDateFormat(DateTime dateTime) {
    return _buildDataFormat(strFormat: 'yyyy-MM-dd HH:mm:ss', time: dateTime);
  }

  /// 現在時間 ex: 2022-10-18
  String getFullWithDateFormat2(DateTime dateTime) {
    return _buildDataFormat(strFormat: 'yyyy/MM/dd HH:mm:ss', time: dateTime);
  }

  ///MARK: 11 : 46 : 22  AM
  String getDateWith12HourInSecondFormat(DateTime time) {
    return _buildDataFormat(strFormat: 'hh : mm : ss a', time: time);
  }

  ///MARK: 取得當月有幾天
  List<String> getCurrentMonthDays() {
    var year = _getNow().year;
    var month = _getNow().month;
    int days = DateTime(year, month + 1, 0).day;
    return List<String>.generate(
        days,
        (index) =>
            '$year-${NumberFormatUtil().integerTwoFormat(month)}-${NumberFormatUtil().integerTwoFormat(index + 1)}');
  }

  ///MARK: 取得當月第一天
  String getCurrentMonthFirst() {
    var year = _getNow().year;
    var month = _getNow().month;
    return '$year-${NumberFormatUtil().integerTwoFormat(month)}-${NumberFormatUtil().integerTwoFormat(1)}';
  }

  ///MARK: 取得當月最後一天
  String getCurrentMonthLast() {
    var year = _getNow().year;
    var month = _getNow().month;
    int days = DateTime(year, month + 1, 0).day;
    return '$year-${NumberFormatUtil().integerTwoFormat(month)}-${NumberFormatUtil().integerTwoFormat(days)}';
  }

  String getBeforeDays(int day) {
    DateTime dateTime = _getNow().subtract(Duration(days: day));
    return getTimeWithDayFormat(time: dateTime);
  }
}
