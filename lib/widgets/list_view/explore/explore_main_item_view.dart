import 'package:flutter/cupertino.dart';

import '../../../views/explore/data/explore_main_response_data.dart';

class ExploreMainItemView extends StatefulWidget {
  const ExploreMainItemView({super.key, required this.exploreMainResponseData});

  final ExploreMainResponseData exploreMainResponseData;

  @override
  State<StatefulWidget> createState() => _ExploreMainItemView();

}

class _ExploreMainItemView extends State<ExploreMainItemView> {

  ExploreMainResponseData get exploreMainResponseData {
    return exploreMainResponseData;
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }

}