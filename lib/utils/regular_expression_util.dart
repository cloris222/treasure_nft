class RegularExpressionUtil {
  bool _checkFormat(String pattern, String value) {
    RegExp regex = RegExp(pattern);
    return regex.hasMatch(value);
  }

  ///MARK: 檢查是使用者信箱
  bool checkFormatEmail(String value) {
    if (value.isNotEmpty) {
      String pattern =
          "^\\w{1,63}@[a-zA-Z0-9]{2,63}\\.[a-zA-Z]{2,63}(\\.[a-zA-Z]{2,63})?\$";
      return _checkFormat(pattern, value);
    }
    return false;
  }

  ///MARK: 檢查是使用者暱稱
  bool checkFormatNickName(String value) {
    if (value.isNotEmpty) {
      String pattern = '^[a-zA-Z0-9]{1,30}\$';
      return _checkFormat(pattern, value);
    }
    return false;
  }
}
