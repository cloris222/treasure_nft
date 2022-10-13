import 'package:treasure_nft_project/constant/global_data.dart';
import 'package:treasure_nft_project/models/http/parameter/check_reservation_info.dart';
import 'package:treasure_nft_project/view_models/base_view_model.dart';

import '../../constant/call_back_function.dart';
import '../../constant/theme/app_image_path.dart';
import '../../models/http/api/trade_api.dart';

class TradeMainViewModel extends BaseViewModel {
  TradeMainViewModel({required this.setState});

  final ViewChange setState;
  CheckReservationInfo? info;

  Future<void> initState() async {
    info = await TradeAPI().getCheckReservationInfoAPI();
    setState(() {});
  }
  /// display star ~ end price range
  String getRange(){
    dynamic? min;
    dynamic? max;
    if(info!=null){
      if(GlobalData.userInfo.level==0){
        min = info?.reserveRanges[0].startPrice;
        max = info?.reserveRanges[GlobalData.userInfo.level].endPrice;
      }else {
        min = info?.reserveRanges[0].startPrice;
        max = info?.reserveRanges[GlobalData.userInfo.level].startPrice;
      }
      return '$min-$max';
    }
    return '';
  }
  /// display level image
  String getLevelImg() {
    if(GlobalData.userInfo.level == 0){
      return AppImagePath.level0;
    } else if(GlobalData.userInfo.level == 1){
      return AppImagePath.level1;
    } else if(GlobalData.userInfo.level == 2){
      return AppImagePath.level2;
    }else if(GlobalData.userInfo.level == 3){
      return AppImagePath.level3;
    }else if(GlobalData.userInfo.level == 4){
      return AppImagePath.level4;
    }else if(GlobalData.userInfo.level == 5){
      return AppImagePath.level5;
    }else if(GlobalData.userInfo.level == 6){
      return AppImagePath.level6;
    }else if(GlobalData.userInfo.level == 7){
      return AppImagePath.level7;
    }else if(GlobalData.userInfo.level == 8){
      return AppImagePath.level8;
    }else if(GlobalData.userInfo.level == 9){
      return AppImagePath.level9;
    }else if(GlobalData.userInfo.level == 10){
      return AppImagePath.level10;
    }
    return '';
  }
}
