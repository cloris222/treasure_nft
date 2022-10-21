import 'package:treasure_nft_project/models/http/http_manager.dart';
import 'package:treasure_nft_project/models/http/http_setting.dart';
import 'package:treasure_nft_project/models/http/parameter/api_response.dart';
import 'package:treasure_nft_project/models/http/parameter/home_artist_record.dart';
import 'package:treasure_nft_project/models/http/parameter/home_carousel.dart';


class HomeAPI extends HttpManager {
  HomeAPI({super.onConnectFail, super.baseUrl = HttpSetting.developUrl});

  Future<List<HomeCarousel>> getCarouselItem() async {
    List<HomeCarousel> result = <HomeCarousel>[];
    try {
      ApiResponse response = await get('/index/rotate/item');
      response.printLog();
      for (Map<String, dynamic> json in response.data) {
        result.add(HomeCarousel.fromJson(json));
      }
    } catch (e) {
      print(e.toString());
    }
    return result;
  }

  Future<List<ArtistRecord>> getArtistRecord(
      {int page = 1, int size = 10}) async {
    List<ArtistRecord> result = <ArtistRecord>[];
    try {
      ApiResponse response = await get('/index/artist/record',
          queryParameters: {
            'size' : size,
            'page' : page,
          });
      response.printLog();
      for (Map<String, dynamic> json in response.data['pageList']) {
        result.add(ArtistRecord.fromJson(json));
      }
    } catch (e) {
      print(e.toString());
    }
    return result;
  }


}