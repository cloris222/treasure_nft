import 'package:flutter/material.dart';
import 'package:treasure_nft_project/constant/subject_key.dart';
import 'package:treasure_nft_project/utils/observer_pattern/home/home_observer.dart';
import 'package:treasure_nft_project/view_models/home/home_main_viewmodel.dart';
import '../../../constant/theme/app_colors.dart';
import 'artist_record_item.dart';

class ArtistRecordListView extends StatefulWidget {
  const ArtistRecordListView(
      {super.key, required this.showArtAnimate, required this.viewModel});

  final bool showArtAnimate;
  final HomeMainViewModel viewModel;

  @override
  State<StatefulWidget> createState() => _ArtistRecordListView();
}

class _ArtistRecordListView extends State<ArtistRecordListView> {
  HomeMainViewModel get viewModel {
    return widget.viewModel;
  }

  int animateIndex = -1;
  late HomeObserver observer;

  @override
  void didUpdateWidget(covariant ArtistRecordListView oldWidget) {
    if (viewModel.needRecordAnimation) {
      if (widget.showArtAnimate != oldWidget.showArtAnimate) {
        if (widget.showArtAnimate) {
          _playAnimate();
        } else {
          setState(() {
            animateIndex = -1;
          });
        }
      }
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    String key = SubjectKey.keyHomeArtRecords;
    observer = HomeObserver(key, onNotify: (notificationKey) {
      if (notificationKey == key) {
        if (mounted) {
          setState(() {});
        }
      }
    });
    viewModel.homeSubject.registerObserver(observer);
    super.initState();
  }

  @override
  void dispose() {
    viewModel.homeSubject.unregisterObserver(observer);
    super.dispose();
  }

  Widget createItemBuilder(BuildContext context, int index) {
    return ArtistRecordItemView(
        viewModel: viewModel,
        itemData: viewModel.homeArtistRecordList[index],
        showAnimate: animateIndex >= index);
  }

  Widget createSeparatorBuilder(BuildContext context, int index) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Divider(height: 5, color: AppColors.bolderGrey, thickness: 1),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      ListView.separated(
          padding: EdgeInsets.zero,
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return createItemBuilder(context, index);
          },
          itemCount: viewModel.homeArtistRecordList.length,
          separatorBuilder: (BuildContext context, int index) {
            return createSeparatorBuilder(context, index);
          }),
      createSeparatorBuilder(context, 1)
    ]);
  }

  void _playAnimate() async {
    _loopAnimate();
  }

  _loopAnimate() {
    Future.delayed(const Duration(milliseconds: 200)).then((value) {
      setState(() {
        animateIndex += 1;
      });
      if (animateIndex < viewModel.homeArtistRecordList.length) {
        _loopAnimate();
      }
    });
  }
}
