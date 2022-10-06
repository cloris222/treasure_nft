class RegularExpressionUtil {
  bool _checkFormat(String pattern, String value) {
    RegExp regex = RegExp(pattern);
    return regex.hasMatch(value);
  }

  bool checkFormatUserID(String uid) {
    if (uid.isNotEmpty) {
      // String pattern =
      //     '^(?=.*[a-zA-Z])(?=.*[_-])(?=.*[0-9])[a-zA-Z0-9_-]{1,12}\$';
      String pattern = '^[a-zA-Z0-9_-]{1,12}\$';
      return _checkFormat(pattern, uid);
    }
    return false;
  }
}
