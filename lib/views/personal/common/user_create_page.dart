import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';
import 'package:treasure_nft_project/utils/app_text_style.dart';
import 'package:treasure_nft_project/utils/number_format_util.dart';
import 'package:treasure_nft_project/widgets/appbar/title_app_bar.dart';
import 'package:treasure_nft_project/widgets/button/action_button_widget.dart';
import 'package:treasure_nft_project/widgets/button/login_button_widget.dart';

import '../../../constant/theme/app_colors.dart';
import '../../../view_models/personal/common/user_create_viewmodel.dart';
import '../../../widgets/app_bottom_navigation_bar.dart';
import '../../custom_appbar_view.dart';
import '../../login/login_param_view.dart';
import 'choose_date_view.dart';

///MARK: 鑄造
class UserCreatePage extends StatefulWidget {
  const UserCreatePage({Key? key}) : super(key: key);

  @override
  State<UserCreatePage> createState() => _UserCreatePageState();
}

class _UserCreatePageState extends State<UserCreatePage> {
  late UserCreateViewModel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = UserCreateViewModel(setState: setState);
    viewModel.initState();
  }

  @override
  void dispose() {
    super.dispose();
    viewModel.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomAppbarView(
      needScrollView: false,
      type: AppNavigationBarType.typePersonal,
      body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: _buildBody()),
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
        child: Container(
      padding: EdgeInsets.only(
          top: UIDefine.getPixelWidth(20),
          bottom: UIDefine.navigationBarPadding),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        TitleAppBar(title: tr('create')),
        Visibility(
            visible: viewModel.uploadImage != null,
            child: ActionButtonWidget(
              btnText: tr('cancel'),
              onPressed: viewModel.onCancelImg,
              isBorderStyle: true,
              isFillWidth: false,
            )),
        viewModel.uploadImage != null
            ? Container(
                constraints:
                    BoxConstraints(maxHeight: UIDefine.getHeight() * 0.8),
                child: Image.file(File(viewModel.uploadImage!.path),
                    fit: BoxFit.fitHeight),
              )
            : Container(),
        Visibility(
          visible: viewModel.uploadImage == null,
          child: LoginButtonWidget(
              btnText: tr('upload'), onPressed: viewModel.onChooseImage),
        ),
        SizedBox(height: UIDefine.getScreenHeight(1)),
        Text(tr('imageSupport'),
            style: AppTextStyle.getBaseStyle(
                color: AppColors.dialogGrey, fontSize: UIDefine.fontSize12)),
        LoginParamView(
          titleText: tr('itemName'),
          hintText: tr("name2-placeholder'"),
          controller: viewModel.nameController,
          data: viewModel.nameData,
          onChanged: viewModel.onNameChange,
        ),
        LoginParamView(
          bLimitDecimalLength: true,
          keyboardType: TextInputType.number,
          titleText: tr('mintAmount'),
          hintText: tr("mintAmount-placeholder'"),
          controller: viewModel.priceController,
          data: viewModel.priceData,
        ),
        ChooseDateView(
          titleText: tr('sellDate'),
          hintText: tr("sellDate-placeholder'"),
          controller: viewModel.dateController,
          data: viewModel.dateData,
          onTap: () => viewModel.onChooseDate(context),
        ),
        Text(
            '${tr('royalty')} : ${NumberFormatUtil().removeTwoPointFormat(viewModel.rate)} %'),
        SizedBox(height: UIDefine.getScreenHeight(10)),
        Row(children: [
          Flexible(
              child: ActionButtonWidget(
            setHeight: UIDefine.getScreenHeight(8),
            btnText: tr('cancel'),
            onPressed: () => viewModel.onCancel(context),
            isBorderStyle: true,
          )),
          const SizedBox(width: 20),
          Flexible(
              child: ActionButtonWidget(
            setHeight: UIDefine.getScreenHeight(8),
            btnText: tr('confirm'),
            onPressed: () => viewModel.onConfirm(context),
          ))
        ]),
      ]),
    ));
  }
}
