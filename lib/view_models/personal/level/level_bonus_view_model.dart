import 'package:treasure_nft_project/constant/call_back_function.dart';
import 'package:treasure_nft_project/models/http/api/level_api.dart';
import 'package:treasure_nft_project/models/http/parameter/level_bonus_data.dart';
import 'package:treasure_nft_project/view_models/base_view_model.dart';


class LevelBonusViewModel extends BaseViewModel {
  LevelBonusViewModel({required this.setState});

  LevelBonusData? levelBonus;

  final ViewChange setState;

  void initState() async {
    levelBonus = await LevelAPI().getBonusInfo();
    setState(() {});
  }
}
