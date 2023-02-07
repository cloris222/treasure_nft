import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TimePickUtil {
  Future<String> pickDate(BuildContext context,
      {String format = 'yyyy-MM-dd'}) async {
    DateTime? date = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1000),
        lastDate: DateTime(2099));
    if (date != null) {
      return DateFormat(format).format(date);
    }
    return '';
  }

  Future<String> pickAfterDate(BuildContext context,
      {String format = 'yyyy-MM-dd'}) async {
    DateTime? date = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2099));
    if (date != null) {
      return DateFormat(format, 'en').format(date);
    }
    return '';
  }
}
