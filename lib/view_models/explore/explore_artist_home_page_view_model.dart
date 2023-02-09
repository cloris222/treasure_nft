import 'package:format/format.dart';
import 'package:share_plus/share_plus.dart';
import 'package:treasure_nft_project/models/http/http_setting.dart';
import 'package:treasure_nft_project/view_models/base_view_model.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../constant/call_back_function.dart';
import '../../views/explore/api/explore_api.dart';
import '../../views/explore/data/explore_artist_detail_response_data.dart';

class ExploreArtistHomePageViewModel extends BaseViewModel {


  Future<ExploreArtistDetailResponseData> getArtistDetailResponse(
      String artistId, String name, int page, int size, String sortBy,
      {ResponseErrorFunction? onConnectFail}) async {

    return await ExploreApi(onConnectFail: onConnectFail)
        .getExploreArtistDetail(page: page, size: size, artistId: artistId, name: name, sortBy: sortBy);
  }


  /// 分享畫家PC網址
  void sharePCUrl(String artistId) {
    String pcUrl = format(HttpSetting.pcArtistUrl, {'artistId': artistId});
    Share.share(pcUrl);
  }

}