import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:treasure_nft_project/utils/observer_pattern/notification_data.dart';

import '../models/data/trade_model_data.dart';
import '../models/http/parameter/country_phone_data.dart';
import '../models/http/parameter/sign_in_data.dart';
import 'enum/task_enum.dart';
import 'enum/team_enum.dart';

///MARK: 常用call back
typedef onClickFunction = void Function();
typedef onGetIntFunction = void Function(int value);
typedef onGetDoubleFunction = void Function(double value);
typedef onGetStringFunction = void Function(String value);
typedef onGetBoolFunction = void Function(bool value);
typedef onDateFunction = void Function(String startDate, String endDate);
typedef onDateTypeFunction = void Function(Search type);
typedef onReturnBoolFunction = bool Function();

///MARK: 監聽用
typedef NotificationDataFunction = void Function(NotificationData notification);

///MARK: setState
typedef ViewChange = void Function(VoidCallback fn);

///MARK: response
typedef ResponseErrorFunction = void Function(String errorMessage);
typedef ResponseErrorResponseFunction = void Function(String errorMessage,Response? response);

/// for search bar decide show keyboard
typedef ShowKeyBoard = bool Function();

///用於倒數按鈕
typedef PressVerification = Future<bool> Function();

///MARK: 背景執行程式
typedef BackgroundFunction = Future<void> Function();

///MARK: 任務達成用
typedef GetMissionPoint = void Function(String recordNo, int point);
typedef GetAchievementMissionPoint = void Function(
    AchievementCode code, String recordNo, int point);

///MARK: 顯示簽到頁面用
typedef GetSignInDate = void Function(SignInData? data);

typedef GetTradDate = void Function(TradeData data);

typedef GetCountry = void Function(CountryPhoneData data);
