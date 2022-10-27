import 'package:flutter/cupertino.dart';

import 'enum/task_enum.dart';

///MARK: 常用call back
typedef onClickFunction = void Function();
typedef onGetIntFunction = void Function(int value);
typedef onGetDoubleFunction = void Function(double value);
typedef onGetStringFunction = void Function(String value);
typedef onGetBoolFunction = void Function(bool value);
typedef onDateFunction = void Function(String startDate, String endDate);


///MARK: setState
typedef ViewChange = void Function(VoidCallback fn);

///MARK: response
typedef ResponseErrorFunction = void Function(String errorMessage);

/// for search bar decide show keyboard
typedef ShowKeyBoard = bool Function();

///用於倒數按鈕
typedef PressVerification = Future<bool> Function();

///MARK: 背景執行程式
typedef BackgroundFunction = Future<void> Function();

typedef GetMissionPoint = void Function(String recordNo, int point);
typedef GetAchievementMissionPoint = void Function(
    AchievementCode code, String recordNo, int point);
