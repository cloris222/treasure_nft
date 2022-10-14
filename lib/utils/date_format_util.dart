import 'package:easy_localization/easy_localization.dart';

import 'language_util.dart';

class DateFormatUtil {
  String _buildDataFormat({required String strFormat, required DateTime time}) {
    return DateFormat(strFormat, LanguageUtil.getTimeLocale()).format(time);
  }

  DateTime _getNow() {
    return DateTime.now();
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
      return '${week.toString()} week ago';
    } else if (day > 1 || day == 1) {
      return '${day.toString()} days ago';
    } else if (hour < 24 && hour > 0) {
      return '${hour.toString()} hours ago';
    } else if (minutes > 0 && minutes < 60) {
      return '${minutes.toString()} minutes ago';
    } else if (second >= 0 && second < 60) {
      return '${second.toString()} sec ago';
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
}
