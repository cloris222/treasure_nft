// import 'dart:async';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// import '../constant/global_data.dart';
// import '../constant/theme/app_image_path.dart';
// import '../view_models/base_view_model.dart';
// import '../views/home_page.dart';
//
// //TODO: 定義主分頁類型
// enum AppNavigationBarType { type1, type2, type3, type4, type5 }
//
// typedef AppBottomFunction = Function(AppNavigationBarType type, int pageIndex);
//
// class FmBottomNavigationBar extends StatefulWidget {
//   FmBottomNavigationBar({this.isMainPage = false, required this.currentType});
//
//   final bool isMainPage;
//   final AppNavigationBarType currentType;
//   final AppBottomFunction _bottomFunction;
//
//   @override
//   State<StatefulWidget> createState() => _FmBottomNavigationBar();
// }
//
// class _FmBottomNavigationBar extends State<FmBottomNavigationBar>
//     with WidgetsBindingObserver {
//   bool bShow = false;
//   late StreamSubscription streamSubscription;
//
//   @override
//   void initState() {
//     super.initState();
//     _onWebSocketListen();
//     WidgetsBinding.instance.addObserver(this);
//   }
//
//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     if (GlobalData.firstLaunch) {
//       getUnreadResponse();
//       GlobalData.firstLaunch = false;
//     }
//   }
//
//   @override
//   void didChangeAppLifecycleState(AppLifecycleState state) {
//     super.didChangeAppLifecycleState(state);
//     switch (state) {
//       case AppLifecycleState.resumed:
//         debugPrint('開啟： resumed NavigationBar');
//         getUnreadResponse();
//         break;
//
//       case AppLifecycleState.paused:
//       case AppLifecycleState.detached:
//       case AppLifecycleState.inactive:
//         break;
//     }
//   }
//
//   @override
//   void dispose() {
//     WidgetsBinding.instance.removeObserver(this);
//     streamSubscription.cancel();
//     super.dispose();
//   }
//
//   getUnreadResponse() {
//     Future<int> total =
//         BaseViewModel().getUnreadCountTotalResponse(context, 'followed');
//     total.then((value) => {initNavigationBar(value)});
//
//     Future<int> total2 =
//         BaseViewModel().getUnreadCountTotalResponse(context, 'none');
//     total2.then((value) => {initNavigationBar(value)});
//   }
//
//   initNavigationBar(int iValue) {
//     if (iValue > 0) {
//       setState(() {
//         bShow = true;
//       });
//     }
//   }
//
//   _onWebSocketListen() {
//     streamSubscription =
//         WebSocketUtil().streamController.stream.listen((message) {
//       WsAckSendMessageData data = WebSocketUtil().getACKData(message);
//       if (GlobalData.userMemberId == data.chatData.otherSideMemberId &&
//           data.chatData.content.message != '') {
//         setState(() {
//           bShow = true;
//         });
//       }
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return StatefulBuilder(builder: _barBuilder);
//   }
//
//   Widget _barBuilder(BuildContext context, StateSetter setState) {
//     return CupertinoTabBar(
//         items: <BottomNavigationBarItem>[
//           BottomNavigationBarItem(
//               icon: Center(child: getIcon(AppNavigationBarType.type1)),
//               backgroundColor: Colors.white),
//           BottomNavigationBarItem(
//               icon: Center(child: getIcon(AppNavigationBarType.type2)),
//               backgroundColor: Colors.white),
//           BottomNavigationBarItem(
//               icon: getIcon(AppNavigationBarType.type3),
//               backgroundColor: Colors.white),
//           BottomNavigationBarItem(
//               icon: Center(child: getIcon(AppNavigationBarType.type4)),
//               backgroundColor: Colors.white),
//           BottomNavigationBarItem(
//               icon: Center(child: getIcon(AppNavigationBarType.type5)),
//               backgroundColor: Colors.white),
//         ],
//         onTap: (index) {
//           if (index == 3) {
//             setState(() {
//               bShow = false;
//             });
//           }
//           _navigationTapped(index, setState);
//         });
//   }
//
//   Widget getIcon(AppNavigationBarType type) {
//     bool isSelect = widget.currentType == type;
//     double sizeWidth = MediaQuery.of(context).size.width / 20;
//     String asset;
//     switch (type) {
//       case AppNavigationBarType.type1:
//         {
//           asset = isSelect ? AppImagePath.mainType1 : AppImagePath.mainType1;
//         }
//         break;
//       case AppNavigationBarType.type2:
//         {
//           asset = isSelect ? AppImagePath.mainType2 : AppImagePath.mainType2;
//         }
//         break;
//       case AppNavigationBarType.type3:
//         {
//           asset = isSelect ? AppImagePath.mainType3 : AppImagePath.mainType3;
//         }
//         break;
//       case AppNavigationBarType.type4:
//         {
//           asset = isSelect ? AppImagePath.mainType4 : AppImagePath.mainType4;
//         }
//         break;
//       case AppNavigationBarType.type5:
//         {
//           asset = isSelect ? AppImagePath.mainType5 : AppImagePath.mainType5;
//         }
//         break;
//     }
//
//     return Image.asset(asset,
//         fit: BoxFit.contain, width: sizeWidth, height: sizeWidth);
//   }
//
//   _navigationTapped(int index, void Function(VoidCallback fn) setState) {
//     widget.currentType = AppNavigationBarType.values[index];
//     if (widget.isMainPage) {
//       //呼叫首頁切換頁面
//       setState(() {
//         widget._bottomFunction(widget.currentType, index);
//       });
//     } else {
//       //清除所有頁面並回到首頁
//       Navigator.pushAndRemoveUntil<void>(
//         context,
//         MaterialPageRoute<void>(
//             builder: (BuildContext context) =>
//                 HomePage(type: widget.currentType)),
//         ModalRoute.withName('/'),
//       );
//     }
//   }
// }
