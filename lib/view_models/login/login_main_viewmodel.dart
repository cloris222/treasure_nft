import 'package:treasure_nft_project/models/data/validate_result_data.dart';
import 'package:treasure_nft_project/view_models/base_view_model.dart';

class LoginMainViewModel extends BaseViewModel {
  ValidateResultData accountData = ValidateResultData();
  ValidateResultData passwordData = ValidateResultData();

  bool checkPress(String account, String password) {
    return account.isNotEmpty &&
        password.isNotEmpty &&
        passwordData.result &&
        accountData.result;
  }
}
