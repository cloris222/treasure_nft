import 'package:flutter/cupertino.dart';

class SellSuccessNotifier extends ChangeNotifier {
 bool _connectSellSuccess = false;
 bool get ConnectSellSuccess => _connectSellSuccess;

 void updateState(bool newState) {
   _connectSellSuccess = newState;
   notifyListeners();
 }

}