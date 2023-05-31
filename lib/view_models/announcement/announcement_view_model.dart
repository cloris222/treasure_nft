
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:treasure_nft_project/models/http/api/announce_api.dart';
import '../../constant/call_back_function.dart';
import '../../models/http/parameter/announce_data.dart';
import '../base_view_model.dart';
import 'announce_tag_provider.dart';


class AnnouncementViewModel extends BaseViewModel {
  AnnouncementViewModel({required this.onViewChange, required this.ref});

  final onClickFunction onViewChange;
  final WidgetRef ref;

  List<AnnounceTagData> get tagList => ref.read(announceTagProvider);

  void initState() {
  }

  String getTagText(String tagId) {
    for (int i = 0 ; i < tagList.length ; i++) {
      if (tagList[i].id.toString() == tagId){
        return tagList[i].title;
      }
    }
    return "";
  }


  String getTagColor(String tagId) {
    for (int i = 0 ; i < tagList.length ; i++) {
      if (tagList[i].id.toString() == tagId){
        return tagList[i].color;
      }
    }
    return "";
  }


}