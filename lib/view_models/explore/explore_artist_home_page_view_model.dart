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

  /// 外部連結
  Future<void> launchInBrowser(String url) async {
    if (!await launchUrl(
      Uri.parse(url),
      mode: LaunchMode.externalApplication,
    )) {
      throw 'Could not launch $url';
    }
  }

}