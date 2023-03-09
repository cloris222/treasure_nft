import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';
import 'package:treasure_nft_project/utils/app_text_style.dart';
import 'package:treasure_nft_project/utils/number_format_util.dart';
import 'package:treasure_nft_project/view_models/personal/common/user_create_rate_provider.dart';
import 'package:treasure_nft_project/view_models/personal/common/user_create_white_provider.dart';
import 'package:treasure_nft_project/widgets/appbar/title_app_bar.dart';
import 'package:treasure_nft_project/widgets/button/action_button_widget.dart';
import 'package:treasure_nft_project/widgets/button/login_bolder_button_widget.dart';
import 'package:treasure_nft_project/widgets/button/login_button_widget.dart';

import '../../../constant/theme/app_colors.dart';
import '../../../view_models/personal/common/user_create_viewmodel.dart';
import '../../../widgets/app_bottom_navigation_bar.dart';
import '../../custom_appbar_view.dart';
import '../../login/login_param_view.dart';
import 'choose_date_view.dart';

///MARK: 鑄造
class UserCreatePage extends ConsumerStatefulWidget {
  const UserCreatePage({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _UserCreatePageState();
}

class _UserCreatePageState extends ConsumerState<UserCreatePage> {
  late UserCreateViewModel viewModel;

  double get rate {
    return ref.read(userCreateRateProvider);
  }

  bool get canMine {
    return ref.read(userCreateWhiteProvider);
  }

  @override
  void initState() {
    super.initState();
    viewModel = UserCreateViewModel(onViewChange: () {
      if (mounted) {
        setState(() {});
      }
    });
    ref.read(userCreateRateProvider.notifier).init();
    ref.read(userCreateWhiteProvider.notifier).init();
  }

  @override
  void dispose() {
    super.dispose();
    viewModel.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(userCreateRateProvider);
    return CustomAppbarView(
      needScrollView: false,
      onLanguageChange: () {
        if (mounted) {
          setState(() {});
        }
      },
      body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: _buildBody()),
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
        child: Container(
      padding: EdgeInsets.only(
          // top: UIDefine.getPixelWidth(20),
          bottom: UIDefine.navigationBarPadding),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        TitleAppBar(title: tr('create'), needCloseIcon: false),
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
        SizedBox(height: UIDefine.getScreenHeight(2)),
        LoginParamView(
          titleText: tr('itemName'),
          hintText: tr("name2-placeholder'"),
          bShowRed: true,
          controller: viewModel.nameController,
          data: viewModel.nameData,
          onChanged: viewModel.onNameChange,
        ),
        LoginParamView(
          bLimitDecimalLength: true,
          keyboardType: TextInputType.number,
          titleText: tr('mintAmount'),
          hintText: tr("mintAmount-placeholder'"),
          bShowRed: true,
          controller: viewModel.priceController,
          data: viewModel.priceData,
        ),
        ChooseDateView(
          titleText: tr('sellDate'),
          hintText: tr("sellDate-placeholder'"),
          bShowRed: true,
          controller: viewModel.dateController,
          data: viewModel.dateData,
          onTap: () => viewModel.onChooseDate(context),
        ),
        SizedBox(height: UIDefine.getScreenHeight(5)),
        Text(
          '${tr('royalty')} : ${NumberFormatUtil().removeTwoPointFormat(rate)} %',
          style: AppTextStyle.getBaseStyle(
              fontSize: UIDefine.fontSize14,
              fontWeight: FontWeight.w400,
              color: AppColors.textThreeBlack),
        ),
        SizedBox(height: UIDefine.getScreenHeight(5)),
        Row(children: [
          Flexible(
              child: LoginBolderButtonWidget(
            height: UIDefine.getScreenHeight(8),
            btnText: tr('cancel'),
            onPressed: () => viewModel.onCancel(context),
          )),
          const SizedBox(width: 20),
          Flexible(
              child: LoginButtonWidget(
            height: UIDefine.getScreenHeight(8),
            btnText: tr('confirm'),
            onPressed: () => viewModel.onConfirm(context, canMine),
          ))
        ]),
      ]),
    ));
  }
}
