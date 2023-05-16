
import 'package:flutter/cupertino.dart';
import '../../../constant/call_back_function.dart';
import '../../../models/http/api/user_info_api.dart';
import '../../base_view_model.dart';


class GoogleAuthViewModel extends BaseViewModel {
  GoogleAuthViewModel({required this.setState});
  final ViewChange setState;

  TextEditingController verifyController = TextEditingController();

  Future<void> onPressSave(BuildContext context) async{
    await UserInfoAPI(
        onConnectFail:(message) => onBaseConnectFail(context, message))
        .bindGoogleAuth(verifyController.text)
        .then((value) => popPage(context));
  }
}