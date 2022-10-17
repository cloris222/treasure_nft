import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:treasure_nft_project/constant/global_data.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';

import '../../constant/theme/app_style.dart';
import '../../models/http/parameter/user_property.dart';

class PersonalSubLevelView extends StatelessWidget {
  const PersonalSubLevelView({Key? key, this.userProperty}) : super(key: key);
  final UserProperty? userProperty;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      runSpacing: 10,
      children: [_buildCountry(), _buildProperty(), _buildReserve()],
    );
  }

  Widget _buildCountry() {
    return Container(
      alignment: Alignment.centerLeft,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('${tr('nationality')} :'),
          Text(tr(GlobalData.userInfo.country)),
          Text('(${tr(GlobalData.userInfo.zone)})')
        ],
      ),
    );
  }

  Widget _buildProperty() {
    return Container(
      width: UIDefine.getWidth(),
      decoration: AppStyle().styleColorBorderBackground(
          radius: 10, backgroundColor: Colors.transparent),
      padding: const EdgeInsets.all(5),
      child: Column(children: [
        _buildPropertyParam(title: 'A', value: 'b'),
        _buildPropertyParam(title: 'A', value: 'b'),
        _buildPropertyParam(title: 'A', value: 'b'),
        _buildPropertyParam(title: 'A', value: 'b'),
      ]),
    );
  }

  Widget _buildPropertyParam({required String title, required String value}) {
    return Row(children: [Text(title), Text(value)]);
  }

  Widget _buildReserve() {
    return Container();
  }
}
