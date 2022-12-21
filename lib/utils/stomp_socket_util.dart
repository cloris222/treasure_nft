import 'package:stomp_dart_client/stomp.dart';
import 'package:stomp_dart_client/stomp_config.dart';
import 'package:treasure_nft_project/constant/global_data.dart';

import '../models/http/http_setting.dart';

class StompSocketUtil {
  /// 單例
  static StompSocketUtil? _stompSocketUtil;

  StompSocketUtil._();

  /// 獲取單例内部方法
  factory StompSocketUtil() {
    /// 只能有一个實例
    return _stompSocketUtil ??= StompSocketUtil._();
  }

  StompClient? stompClient;
  final String key = '-Stomp:';

  void connect({required StompFrameCallback onConnect}) async {
    if (stompClient != null) {
      disconnect();
      await Future.delayed(const Duration(seconds: 1));
    }

    stompClient = StompClient(
      config: StompConfig.SockJS(
        // useSockJS: true,
        url: HttpSetting.socketUrl,
        onDebugMessage: (msg) {
          if (msg != '<<< h') {
            GlobalData.printLog('$key $msg');
          }
        },
        onConnect: (frame) {
          GlobalData.printLog('$key _onConnect');
          onConnect(frame);
        },
        beforeConnect: () async {
          GlobalData.printLog('$key wait connecting...');
        },
        onWebSocketError: (dynamic error) {
          GlobalData.printLog('$key ${error.toString()}');
        },
        onStompError: (d) {
          GlobalData.printLog('$key error stomp${d.command.toString()}');
        },
        onDisconnect: (f) {
          GlobalData.printLog('$key disconnected${f.command.toString()}');
        },
        onUnhandledFrame: (f) {
          GlobalData.printLog('$key onUnhandledFrame${f.command.toString()}');
        },
        onWebSocketDone: () {
          GlobalData.printLog('$key onWebSocketDone}');
        },
        stompConnectHeaders: {
          'Authorization': GlobalData.userToken,
          'marketId': 'DEFAULT'
        },
        webSocketConnectHeaders: {
          'Authorization': GlobalData.userToken,
          'marketId': 'DEFAULT'
        },
      ),
    );
    stompClient!.activate();
  }

  void disconnect() {
    stompClient?.deactivate();
  }
}
