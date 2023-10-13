import 'package:flutter/cupertino.dart';

class ReserveSuccessNotifier extends ChangeNotifier {
 bool _connectReserveSuccess = false;
 bool get ConnectReserveSuccess => _connectReserveSuccess;

 void updateState(bool newState) {
   _connectReserveSuccess = newState;
   notifyListeners();
 }

}