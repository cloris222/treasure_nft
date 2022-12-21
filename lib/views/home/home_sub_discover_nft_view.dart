import 'package:flutter/material.dart';
import 'package:treasure_nft_project/constant/theme/app_colors.dart';
import 'package:treasure_nft_project/constant/theme/app_style.dart';
import 'package:treasure_nft_project/view_models/home/home_main_viewmodel.dart';

class HomeSubDiscoverNftView extends StatefulWidget {
  const HomeSubDiscoverNftView({Key? key, required this.viewModel})
      : super(key: key);
  final HomeMainViewModel viewModel;

  @override
  State<HomeSubDiscoverNftView> createState() => _HomeSubDiscoverNftViewState();
}

class _HomeSubDiscoverNftViewState extends State<HomeSubDiscoverNftView> {
  HomeMainViewModel get viewModel{return widget.viewModel;}
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: AppStyle().buildGradient(
          radius: 0, colors: AppColors.gradientBackgroundColorBg),
      padding: viewModel.getMainPadding(width: 30, height: 30),

    );
  }
}
