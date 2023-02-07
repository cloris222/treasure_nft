import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:treasure_nft_project/constant/theme/app_colors.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';
import 'package:treasure_nft_project/constant/global_data.dart';
import 'package:treasure_nft_project/utils/app_text_style.dart';
import 'package:treasure_nft_project/widgets/appbar/title_app_bar.dart';
import 'package:treasure_nft_project/constant/global_data.dart';
import '../../../view_models/personal/orders/order_info_page_view_model.dart';
import '../../../widgets/app_bottom_navigation_bar.dart';
import '../../../widgets/date_picker/date_picker.dart';
import '../../custom_appbar_view.dart';
import 'orderinfo/order_info_selector_drop_down_bar.dart';

///MARK: 訂單信息
class OrderInfoPage extends StatefulWidget {
  const OrderInfoPage({
    Key? key,
    this.bFromWallet = false
  }) : super(key: key);

  final bool bFromWallet;

  @override
  State<StatefulWidget> createState() => _OrderInfoPage();
}

class _OrderInfoPage extends State<OrderInfoPage> {

  int page = 1;
  late OrderInfoPageViewModel viewModel;


  @override
  initState() {
    super.initState();
    viewModel = OrderInfoPageViewModel(setState: setState);
    viewModel.init(widget.bFromWallet);
    viewModel.requestAPI(page, 10);
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollEndNotification>(
        onNotification: (scrollEnd) {
      final metrics = scrollEnd.metrics;
      if (metrics.atEdge) {
        bool isTop = metrics.pixels == 0;
        if (isTop) {
          GlobalData.printLog('At the top');
        } else {
          GlobalData.printLog('At the bottom');
          page += 1;
          viewModel.requestAPIForUpdate(page, 10);
        }
      }
      return true;
    },
      child: CustomAppbarView(
          needScrollView: true,
          onLanguageChange: () {
            if (mounted) {
              setState(() {});
            }
          },
          type: AppNavigationBarType.typePersonal,
          body: Column(
            children: [
              TitleAppBar(title: tr('Notification_nav')),
              Padding(
                padding: EdgeInsets.all(UIDefine.getScreenWidth(2.77)),
                child: Column(

                  children: [
                    SizedBox(height: UIDefine.getScreenWidth(5.5)),

                    OrderInfoSelectorDropDownBar(
                      bFromWallet: widget.bFromWallet,
                      getDropDownValue: (String value) {
                        if (value == viewModel.currentType) {
                          return;
                        }
                      viewModel.currentType = value;
                      viewModel.requestAPI(1, 10);
                    }),

                    DatePickerWidget(
                        displayButton: false, bUsePhoneTime: false,
                        startDate: viewModel.startDate, endDate: viewModel.endDate,
                        dateCallback: (String startDate, String endDate) {
                          if (startDate == viewModel.startDate && endDate == viewModel.endDate) {
                            return;
                          }
                          viewModel.startDate = startDate;
                          viewModel.endDate = endDate;
                          viewModel.requestAPI(1, 10);
                        }),

                    viewModel.dataList.isNotEmpty ?
                    _getListView()
                        :
                    Column(
                      children: [
                        SizedBox(height: UIDefine.getScreenWidth(10)),
                        Image.asset('assets/icon/icon/icon_nodata_01.png'),
                        const SizedBox(height: 10),
                        Text(
                          tr("ES_0007"),
                          style: AppTextStyle.getBaseStyle(color: AppColors.textGrey,
                              fontSize: UIDefine.fontSize16, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    SizedBox(height: UIDefine.navigationBarPadding)
                  ],
                ),
              ),
            ],
          )
      )
    );
  }

  Widget _getListView() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: viewModel.dataList.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.only(bottom: UIDefine.getScreenWidth(5.5)),
          child: viewModel.createItemView(index),
        );
      },
    );
  }

}
