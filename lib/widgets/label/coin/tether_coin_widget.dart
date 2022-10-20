import 'package:flutter/material.dart';

import '../../../constant/theme/app_image_path.dart';
import 'base_coin_widget.dart';

class TetherCoinWidget extends BaseCoinWidget {
  const TetherCoinWidget(
      {Key? key, super.size, super.imageAssetPath = AppImagePath.tetherImg})
      : super(key: key);
}
