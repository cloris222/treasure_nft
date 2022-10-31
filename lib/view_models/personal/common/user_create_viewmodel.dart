import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:treasure_nft_project/models/http/api/common_api.dart';
import 'package:treasure_nft_project/models/http/api/mine_api.dart';
import 'package:treasure_nft_project/utils/image_picker_util.dart';
import 'package:treasure_nft_project/utils/number_format_util.dart';
import 'package:treasure_nft_project/utils/time_pick_util.dart';
import 'package:treasure_nft_project/view_models/base_view_model.dart';
import 'package:treasure_nft_project/views/main_page.dart';
import 'package:treasure_nft_project/widgets/app_bottom_navigation_bar.dart';

import '../../../constant/call_back_function.dart';
import '../../../models/data/validate_result_data.dart';
import '../../../utils/date_format_util.dart';
import '../../../widgets/dialog/common_custom_dialog.dart';
import '../../../widgets/dialog/simple_custom_dialog.dart';

class UserCreateViewModel extends BaseViewModel {
  UserCreateViewModel({required this.setState});

  final ViewChange setState;
  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  ValidateResultData nameData = ValidateResultData();
  ValidateResultData priceData = ValidateResultData();
  ValidateResultData dateData = ValidateResultData();

  XFile? uploadImage;
  double rate = 0.0;
  bool canMine = false;

  void resetData() {
    setState(() {
      nameData = ValidateResultData();
      priceData = ValidateResultData();
      dateData = ValidateResultData();
    });
  }

  void initState() async {
    rate = await MineAPI().getRoyaltyRate();
    canMine = await MineAPI().getWhiteList();
    setState(() {});
  }

  void dispose() {
    nameController.dispose();
    priceController.dispose();
    dateController.dispose();
  }

  bool checkChooseDate(String date) {
    return date.compareTo(DateFormatUtil().getNowTimeWithDayFormat()) > 0;
  }

  void onChooseDate(BuildContext context) async {
    resetData();
    String date = await TimePickUtil().pickAfterDate(context);
    setState(() {
      dateController.text = date;
    });
  }

  void onCancelImg() {
    uploadImage = null;
    setState(() {});
  }

  void onChooseImage() async {
    uploadImage = await ImagePickerUtil().selectImage();

    ///MARK: 要不要做判斷?
    if (uploadImage != null) {
      String path = uploadImage!.path;
      var suffix = path.substring(path.lastIndexOf(".") + 1, path.length);
    }
    setState(() {});
  }

  void onCancel() {}

  void onConfirm(BuildContext context) async {
    if (uploadImage == null) {
      SimpleCustomDialog(context,
              mainText: tr("uploadImg-required'"), isSuccess: false)
          .show();
    }

    ///MARK: 檢查空值
    else if (nameController.text.isEmpty ||
        priceController.text.isEmpty ||
        dateController.text.isEmpty) {
      setState(() {
        nameData = ValidateResultData(
            result: nameController.text.isNotEmpty, message: tr('require'));
        priceData = ValidateResultData(
            result: priceController.text.isNotEmpty, message: tr('require'));
        dateData = ValidateResultData(
            result: dateController.text.isNotEmpty, message: tr('require'));
      });
    }

    ///MARK: 不再白名單
    else if (!canMine) {
      ///MARK: 顯示提示
      CommonCustomDialog(context,
          type: DialogImageType.warning,
          title: tr("temp-cant-use'"),
          content: tr("mint-cant-info'"),
          rightBtnText: tr('confirm'),
          onLeftPress: () {}, onRightPress: () {
        popPage(context);
      }).show();
    }

    ///MARK: 上傳鑄造
    else {
      var response = await CommonAPI(
              onConnectFail: (message) => onBaseConnectFail(context, message))
          .uploadImage(uploadImage!.path);
      await MineAPI(
              onConnectFail: (message) => onBaseConnectFail(context, message))
          .mineNFT(
              imageUrl: response.data,
              name: nameController.text,
              description: nameController.text,
              price: NumberFormatUtil()
                  .removeTwoPointFormat(double.parse(priceController.text)),
              sellDate: dateController.text)
          .then((value) {
        pushAndRemoveUntil(
            context, const MainPage(type: AppNavigationBarType.typeCollection));
        SimpleCustomDialog(context, isSuccess: true).show();
      });
    }
  }

  void onTap() {
    resetData();
  }
}
