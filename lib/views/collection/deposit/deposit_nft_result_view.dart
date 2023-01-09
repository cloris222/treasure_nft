import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:treasure_nft_project/utils/app_text_style.dart';
import 'package:treasure_nft_project/widgets/appbar/title_app_bar.dart';
import '../../../constant/call_back_function.dart';
import '../../../constant/theme/app_colors.dart';
import '../../../constant/ui_define.dart';
import '../../../view_models/base_view_model.dart';
import '../../../widgets/app_bottom_navigation_bar.dart';
import '../../custom_appbar_view.dart';
import '../api/collection_api.dart';

class DepositNftResultView extends StatefulWidget {
  const DepositNftResultView({super.key, required this.netWork});

  final String netWork;

  @override
  State<StatefulWidget> createState() => _DepositNftResultView();
}

class _DepositNftResultView extends State<DepositNftResultView> {

  String data = '';

  @override
  void initState() {
    super.initState();

    Future<String> result = getContractOwnerResponse();
    result.then((value) => { data = value, setState(() {}) });
  }

  Future<String> getContractOwnerResponse(
      {ResponseErrorFunction? onConnectFail}) async {
    return await CollectionApiCommon(onConnectFail: onConnectFail)
        .getContractOwnerResponse();
  }

  @override
  Widget build(BuildContext context) {
    return CustomAppbarView(
      needScrollView: false,
      type: AppNavigationBarType.typeCollection,

      body: Padding(
        padding: EdgeInsets.all(UIDefine.getScreenWidth(5)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TitleAppBar(title: tr('depositNFT')),
            SizedBox(height: UIDefine.getScreenWidth(5)),

            /// QRCode
            QrImage(
              errorStateBuilder: (context, error) =>
                  Text(error.toString()),
              data: data,
              version: QrVersions.auto,
              size: UIDefine.getScreenWidth(41.6),
              foregroundColor: AppColors.mainThemeButton,
            ),

            SizedBox(height: UIDefine.getScreenWidth(10)),

            /// 文字
            Text(
              tr("Polygon-text'"), // 完成付款 Polygon
              style: AppTextStyle.getBaseStyle(
                  color: AppColors.textBlack, fontSize: UIDefine.fontSize14, fontWeight: FontWeight.w500),
            ),

            SizedBox(height: UIDefine.getScreenWidth(10)),

            Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.all(UIDefine.getScreenWidth(2)),
                decoration: (
                    BoxDecoration(
                      color: AppColors.textWhite,
                      border: Border.all(color: AppColors.bolderGrey, width: 2),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    )),
                child: Padding(
                    padding: EdgeInsets.all(UIDefine.getScreenWidth(2.77)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          tr("Polygon-address'"),
                          style: AppTextStyle.getBaseStyle(color: AppColors.textBlack, fontSize: UIDefine.fontSize14, fontWeight: FontWeight.w500),
                        ),

                        const SizedBox(height: 4),

                        Row(
                          children: [
                            SizedBox(
                              width: UIDefine.getScreenWidth(70),
                              child: Text(
                                data,
                                style: AppTextStyle.getBaseStyle(color: AppColors.dialogGrey, fontSize: UIDefine.fontSize14, fontWeight: FontWeight.w400),
                              )
                            ),
                            SizedBox(width: UIDefine.getScreenWidth(3)),
                            GestureDetector(
                             onTap: () {
                               BaseViewModel().copyText(copyText: data);
                               BaseViewModel().showToast(context, tr('copiedSuccess'));
                             },
                             child: Image.asset('assets/icon/btn/btn_edit_01_nor.png', width: UIDefine.getScreenWidth(6), height: UIDefine.getScreenWidth(6))
                            )
                          ],
                        )
                      ],
                    )
                )
            ),

            SizedBox(height: UIDefine.getScreenWidth(5)),

            Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.all(UIDefine.getScreenWidth(2)),
                decoration: (
                    BoxDecoration(
                      color: AppColors.textWhite,
                      border: Border.all(color: AppColors.bolderGrey, width: 2),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    )),
                child: Padding(
                    padding: EdgeInsets.all(UIDefine.getScreenWidth(2.77)),
                    child: Row(
                      children: [
                        Text(
                          tr("chain"),
                          style: AppTextStyle.getBaseStyle(color: AppColors.textBlack, fontSize: UIDefine.fontSize14, fontWeight: FontWeight.w500),
                        ),

                        SizedBox(width: UIDefine.getScreenWidth(3)),

                        Text(
                          widget.netWork,
                          style: AppTextStyle.getBaseStyle(color: AppColors.dialogGrey, fontSize: UIDefine.fontSize14, fontWeight: FontWeight.w400),
                        )
                      ],
                    )
                )
            ),
            SizedBox(height: UIDefine.navigationBarPadding)
          ],
        ),
      ),
    );
  }
}
