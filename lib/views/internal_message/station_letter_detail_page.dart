import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:treasure_nft_project/utils/app_text_style.dart';
import 'package:treasure_nft_project/view_models/base_view_model.dart';
import '../../constant/theme/app_image_path.dart';
import '../../constant/ui_define.dart';
import '../../models/data/station_letter_data.dart';
import '../custom_appbar_view.dart';

///站內信詳細資訊
class StationLetterDetailPage extends StatefulWidget {
  const StationLetterDetailPage({Key? key, this.isSystemType = false, required this.data}) : super(key: key);
  final StationLetterData data;
  final bool isSystemType;

  @override
  State<StationLetterDetailPage> createState() => _StationLetterDetailPageState();
}

class _StationLetterDetailPageState extends State<StationLetterDetailPage> {
  StationLetterData get data => widget.data;

  @override
  Widget build(BuildContext context) {
    return CustomAppbarView(
      needScrollView: true,
      needBottom: true,
      body: _buildBody(),
      onLanguageChange: () {
        if (mounted) {
          setState(() {});
        }
      },
    );
  }

  Widget _buildBody() {
    return _buildPage();
  }

  Widget _buildPage() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: UIDefine.getPixelWidth(20)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        _buildTitleBar(),
        SizedBox(height: UIDefine.getPixelWidth(20)),
        Row(
          children: [
            Image.asset(
              widget.isSystemType ? AppImagePath.mailReserve : AppImagePath.mailService,
              height: UIDefine.getPixelWidth(40),
              width: UIDefine.getPixelWidth(40),
              fit: BoxFit.contain,
            ),
            SizedBox(width: UIDefine.getPixelWidth(10)),
            Text(data.title, style: AppTextStyle.getBaseStyle(fontSize: UIDefine.fontSize16, color: Colors.black, fontWeight: FontWeight.w400)),
          ],
        ),
        SizedBox(height: UIDefine.getPixelWidth(20)),
        Text(data.content, style: AppTextStyle.getBaseStyle(fontSize: UIDefine.fontSize14, color: Colors.black, fontWeight: FontWeight.w400)),
        SizedBox(height: UIDefine.getPixelWidth(10)),
        SizedBox(height: UIDefine.navigationBarPadding),
      ]),
    );
  }

  String getTime(String strTime) {
    var dateFormat = DateFormat('yyyy-MM-dd');
    DateTime time = dateFormat.parse(strTime);
    return "${time.year}-${time.month}-${time.day}";
  }

  Widget _buildTitleBar() {
    return Stack(
      children: [
        SizedBox(width: UIDefine.getWidth(), height: UIDefine.getPixelWidth(40)),
        Positioned.fill(
            child: Center(child: Text(tr("stationMessage"), style: AppTextStyle.getBaseStyle(fontWeight: FontWeight.w600, fontSize: UIDefine.fontSize18, height: 1.1)))),
        Positioned(
          left: 0,
          top: 0,
          bottom: 0,
          child: IconButton(
              onPressed: () => BaseViewModel().popPage(context),
              icon: Image.asset(
                AppImagePath.arrowLeftBlack,
                fit: BoxFit.contain,
                width: UIDefine.getPixelWidth(24),
                height: UIDefine.getPixelWidth(24),
              )),
        ),
      ],
    );
  }
}
