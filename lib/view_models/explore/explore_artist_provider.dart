import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:treasure_nft_project/constant/call_back_function.dart';
import 'package:treasure_nft_project/view_models/base_pref_provider.dart';

import '../../utils/app_shared_Preferences.dart';
import '../../views/explore/api/explore_api.dart';
import '../../views/explore/data/explore_artist_detail_response_data.dart';

final exploreArtistProvider = StateNotifierProvider.family<
    ExploreArtistNotifier,
    ExploreArtistDetailResponseData?,
    String>((ref, artistId) {
  return ExploreArtistNotifier(artistId);
});

class ExploreArtistNotifier
    extends StateNotifier<ExploreArtistDetailResponseData?>
    with BasePrefProvider {
  ExploreArtistNotifier(this.artistId) : super(null);
  final String artistId;

  @override
  Future<void> initProvider() async {
    state = null;
  }

  @override
  Future<void> initValue() async {
    state = null;
  }

  @override
  Future<void> readAPIValue({ResponseErrorFunction? onConnectFail}) async {
    state = await ExploreApi().getExploreArtistDetail(
        page: 1, size: 1, artistId: artistId, name: '', sortBy: 'price');
  }

  @override
  Future<void> readSharedPreferencesValue() async {
    var json = await AppSharedPreferences.getJson(getSharedPreferencesKey());
    if (json != null) {
      state = ExploreArtistDetailResponseData.fromJson(json);
    }
  }

  @override
  String setKey() {
    return "exploreArtist_$artistId";
  }

  @override
  Future<void> setSharedPreferencesValue() async {
    if (state != null) {
      AppSharedPreferences.setJson(getSharedPreferencesKey(), state!.toJson());
    }
  }

  @override
  bool setUserTemporaryValue() {
    return false;
  }
}
