///MARK: 常用call back
typedef onClickFunction = void Function();
typedef onGetIntFunction = void Function(int value);
typedef onGetDoubleFunction = void Function(double value);
typedef onGetStringFunction = void Function(String value);
typedef onGetBoolFunction = void Function(bool value);


///MARK: response
typedef ResponseErrorFunction = void Function(String errorMessage);

/// for search bar decide show keyboard
typedef ShowKeyBoard = bool Function();

///用於倒數按鈕
typedef PressVerification = Future<bool> Function();


