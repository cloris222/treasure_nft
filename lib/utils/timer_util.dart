import 'dart:async';

typedef MyCallBack = Function(String sTimeLeft);

class MyCallBackListener {
  final MyCallBack myCallBack;
  MyCallBackListener({required this.myCallBack});
}

class CountDownTimerUtil {
  late Timer _timer;
  late int seconds;
  late MyCallBackListener callBackListener;

  /// 外部使用呼叫此方法  endTimeSeconds: 距離開賣的剩餘秒數
  void init({required MyCallBackListener callBackListener, int endTimeSeconds = 0}) {
    this.callBackListener = callBackListener;
    var now = DateTime.now();
    var timeLeft = now.add(Duration(seconds: endTimeSeconds)).difference(now);
    seconds = timeLeft.inSeconds;
    if (seconds > 0) {
      _startTimer();
    }
  }

  /// dispose呼叫此方法
  void cancelTimer() {
    _timer.cancel();
  }

  /// 時間格式化，根據總秒數轉換為對應的 dd:hh:mm:ss
  String _constructTime(int seconds) {
    int day = seconds ~/ 86400;
    int hour = (seconds - (day*86400)) ~/ 3600;
    int minute = (seconds - (day*86400) - (hour*3600)) ~/ 60;
    int second = seconds % 60;
    return _formatTime(day) + ':' + _formatTime(hour) + ':' + _formatTime(minute) + ':' + _formatTime(second);
  }

  /// 數字格式化 將0~9 => 00~09
  String _formatTime(int timeNum) {
    return timeNum < 10? "0" + timeNum.toString() : timeNum.toString();
  }

  /// 開始倒數
  void _startTimer() {
    // 每秒回撥一次
    const period = Duration(seconds: 1);
    _timer = Timer.periodic(period, (timer) {
      // CallBack
      seconds--;
      String sTime = _constructTime(seconds);
      callBackListener.myCallBack(sTime);

      if (seconds == 0) {
        // 歸零自動取消定時器
        cancelTimer();
      }
    });
  }


  ///////// MM:SS ////////
  void initMMSS({required MyCallBackListener callBackListener, int endTimeSeconds = 0}) {
    this.callBackListener = callBackListener;
    var now = DateTime.now();
    var timeLeft = now.add(Duration(seconds: endTimeSeconds)).difference(now);
    seconds = timeLeft.inSeconds;
    if (seconds > 0) {
      _startTimerMMSS();
    }
  }

  void _startTimerMMSS() {
    // 每秒回撥一次
    const period = Duration(seconds: 1);
    _timer = Timer.periodic(period, (timer) {
      // CallBack
      seconds--;
      String sTime = _constructTimeMMSS(seconds);
      callBackListener.myCallBack(sTime);

      if (seconds == 0) {
        // 歸零自動取消定時器
        cancelTimer();
      }
    });
  }

  String _constructTimeMMSS(int seconds) {
    int minute = seconds ~/ 60;
    int second = seconds % 60;
    return _formatTime(minute) + ':' + _formatTime(second);
  }
  ///////// MM:SS ////////
}