import 'package:flutter/material.dart';
import 'package:treasure_nft_project/constant/theme/app_colors.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';
import 'package:treasure_nft_project/view_models/personal/level/level_point_view_model.dart';
import 'package:treasure_nft_project/views/custom_appbar_view.dart';
import 'package:treasure_nft_project/widgets/app_bottom_navigation_bar.dart';

///MARK: 積分

class LevelPointPage extends StatefulWidget {
  const LevelPointPage({Key? key}) : super(key: key);

  @override
  State<LevelPointPage> createState() => _LevelPointPageState();
}

class _LevelPointPageState extends State<LevelPointPage> {
  late LevelPointViewModel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = LevelPointViewModel(
        context: context,
        onListChange: () {
          if (mounted) {
            setState(() {});
          }
        },
        padding: EdgeInsets.only(bottom: UIDefine.navigationBarPadding));
    viewModel.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomAppbarView(
      needCover: true,
      needScrollView: false,
      onLanguageChange: () {
        if (mounted) {
          setState(() {});
        }
      },
      body: _buildBody(),
      type: AppNavigationBarType.typePersonal,
    );
  }

  Widget _buildBody() {
    return Container(
        color: AppColors.defaultBackgroundSpace,
        child: viewModel.buildListView());
  }
}
