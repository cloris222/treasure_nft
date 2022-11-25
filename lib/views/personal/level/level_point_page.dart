import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
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
    viewModel = LevelPointViewModel(onListChange: () {
      if (mounted) {
        setState(() {});
      }
    });
    viewModel.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomAppbarView(
      needCover: true,
      needScrollView: false,
      title: tr('pointRecord'),
      body: _buildBody(),
      type: AppNavigationBarType.typePersonal,
    );
  }

  Widget _buildBody() {
    return viewModel.buildListView();
  }
}
