import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:treasure_nft_project/constant/theme/app_colors.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';
import 'package:treasure_nft_project/models/http/parameter/user_info_data.dart';
import 'package:treasure_nft_project/utils/app_text_style.dart';
import 'package:treasure_nft_project/view_models/gobal_provider/user_info_provider.dart';
import 'package:treasure_nft_project/widgets/appbar/title_app_bar.dart';
import 'package:treasure_nft_project/widgets/list_view/base_list_interface.dart';
import '../../../constant/enum/order_enum.dart';
import '../../../models/http/api/order_api.dart';
import '../../../view_models/personal/orders/order_info_page_view_model.dart';
import '../../../widgets/app_bottom_navigation_bar.dart';
import '../../../widgets/date_picker/date_picker.dart';
import '../../custom_appbar_view.dart';
import 'orderinfo/data/order_message_list_response_data.dart';
import 'orderinfo/order_info_selector_drop_down_bar.dart';

///MARK: 訂單信息
class OrderInfoPage extends ConsumerStatefulWidget {
  const OrderInfoPage({Key? key, this.bFromWallet = false}) : super(key: key);

  final bool bFromWallet;

  @override
  ConsumerState createState() => _OrderInfoPageState();
}

class _OrderInfoPageState extends ConsumerState<OrderInfoPage>
    with BaseListInterface {
  int page = 1;
  OrderInfoPageViewModel viewModel = OrderInfoPageViewModel();

  UserInfoData get userInfo {
    return ref.read(userInfoProvider);
  }

  @override
  initState() {
    viewModel.init(widget.bFromWallet);
    init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomAppbarView(
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
                      getDropDownValue: (OrderInfoType value) {
                        if (value == viewModel.currentType) {
                          return;
                        }
                        viewModel.currentType = value;
                        reloadInit();
                      }),
                  DatePickerWidget(
                      displayButton: false,
                      bUsePhoneTime: false,
                      startDate: viewModel.startDate,
                      endDate: viewModel.endDate,
                      dateCallback: (String startDate, String endDate) {
                        if (startDate == viewModel.startDate &&
                            endDate == viewModel.endDate) {
                          return;
                        }
                        viewModel.startDate = startDate;
                        viewModel.endDate = endDate;
                        reloadInit();
                      }),
                  currentItems.isNotEmpty
                      ? buildListView(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.only(
                              bottom: UIDefine.navigationBarPadding))
                      : Column(
                          children: [
                            SizedBox(height: UIDefine.getScreenWidth(10)),
                            Image.asset('assets/icon/icon/icon_nodata_01.png'),
                            const SizedBox(height: 10),
                            Text(
                              tr("ES_0007"),
                              style: AppTextStyle.getBaseStyle(
                                  color: AppColors.textGrey,
                                  fontSize: UIDefine.fontSize16,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                  SizedBox(height: UIDefine.navigationBarPadding)
                ],
              ),
            ),
          ],
        ));
  }

  @override
  Widget buildItemBuilder(int index, data) {
    return viewModel.createItemView(index, data);
  }

  @override
  Widget buildSeparatorBuilder(int index) {
    return SizedBox(height: UIDefine.getScreenWidth(5.5));
  }

  @override
  Widget? buildTopView() {
    return null;
  }

  @override
  changeDataFromJson(json) {
    return OrderMessageListResponseData.fromJson(json);
  }

  @override
  Future<List> loadData(int page, int size) async {
    return await OrderAPI().getOrderMessageListResponse(
        page: page,
        size: size,
        type: viewModel.currentType.name,
        startTime: viewModel.getStartTime(viewModel.startDate),
        endTime: viewModel.getEndTime(viewModel.endDate));
  }

  @override
  void loadingFinish() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  bool needReadSharedPreferencesValue() {
    return viewModel.checkToday();
  }

  @override
  bool needSave(int page) {
    return page == 1 && viewModel.checkToday();
  }

  @override
  String setKey() {
    return 'orderInfo_${viewModel.currentType.name}';
  }

  @override
  bool setUserTemporaryValue() {
    return true;
  }
}
