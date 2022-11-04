import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:stomp_dart_client/stomp.dart';
import 'package:stomp_dart_client/stomp_config.dart';
import 'package:stomp_dart_client/stomp_frame.dart';
import 'package:treasure_nft_project/constant/global_data.dart';

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
        url: 'https://dev.treasurenft.xyz/gateway/websocket/websocket-connect',
        onDebugMessage: (msg) {
          if (msg != '<<< h') {
            debugPrint('$key $msg');
          }
        },
        onConnect: (frame) {
          debugPrint('$key _onConnect');
          onConnect(frame);
        },
        beforeConnect: () async {
          debugPrint('$key wait connecting...');
        },
        onWebSocketError: (dynamic error) {
          debugPrint('$key ${error.toString()}');
        },
        onStompError: (d) {
          debugPrint('$key error stomp${d.command.toString()}');
        },
        onDisconnect: (f) {
          debugPrint('$key disconnected${f.command.toString()}');
        },
        onUnhandledFrame: (f) {
          debugPrint('$key onUnhandledFrame${f.command.toString()}');
        },
        onWebSocketDone: () {
          debugPrint('$key onWebSocketDone}');
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
