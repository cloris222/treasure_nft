import 'package:treasure_nft_project/models/http/api/home_api.dart';

import '../../models/http/parameter/home_footer_data.dart';
import 'home_main_viewmodel.dart';

class HomeContactViewModel extends HomeMainViewModel {
  Map<String, String> status = {};

  Future<void> initState() async {
    status = await HomeAPI().getFooterSetting();
  }
}
