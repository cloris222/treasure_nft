import 'dart:convert';

import 'package:stomp_dart_client/stomp.dart';
import 'package:stomp_dart_client/stomp_config.dart';
import 'package:stomp_dart_client/stomp_frame.dart';
import 'package:treasure_nft_project/constant/global_data.dart';

class StompSocketUtil {
  StompSocketUtil._();

  static StompClient? stompClient;
  static String key = '-Stomp:';

  static void init() {
    stompClient = StompClient(
      config: StompConfig.SockJS(
        // useSockJS: true,
        url: 'https://dev.treasurenft.xyz/gateway/websocket/websocket-connect',
        onDebugMessage: (msg) {
          if (msg != '<<< h') {
            print('$key $msg');
          }
        },
        onConnect: _onConnect,
        beforeConnect: () async {
          print('$key wait connecting...');
        },
        onWebSocketError: (dynamic error) {
          print('$key ${error.toString()}');
        },
        onStompError: (d) {
          print('$key error stomp${d.command.toString()}');
        },
        onDisconnect: (f) {
          print('$key disconnected${f.command.toString()}');
        },
        onUnhandledFrame: (f) {
          print('$key onUnhandledFrame${f.command.toString()}');
        },
        onWebSocketDone: () {
          print('$key onWebSocketDone}');
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
    print('$key Bearer ${GlobalData.userToken}');
    stompClient!.activate();
  }

  static void _onConnect(StompFrame frame) {
    print('$key _onConnect');
    stompClient!.subscribe(
      destination: '/user/notify/${GlobalData.userMemberId}',
      callback: (frame) {
        print('$key ${frame.body}');
      },
    );
    stompClient!.subscribe(
      destination: '/user/levelUp/${GlobalData.userMemberId}',
      callback: (frame) {
        print('$key ${frame.body}');
      },
    );
  }
}
