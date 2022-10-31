




import 'package:format/format.dart';
import 'package:treasure_nft_project/constant/theme/app_image_path.dart';

class NationalFlagUtil {

  ///MARK: 取得圓型 國旗icon path
  String getNationalFlag(String country) {
    switch(country) {
      case 'English':
        return format(AppImagePath.languageIcon, {'country': 'en'});
      case 'Mandarin':
        return format(AppImagePath.languageIcon, {'country': 'tc'});
      case 'Arabic':
        return format(AppImagePath.languageIcon, {'country': 'sa'});
      case 'Farsi':
        return format(AppImagePath.languageIcon, {'country': 'ir'});
      case 'Spanish':
        return format(AppImagePath.languageIcon, {'country': 'es'});
      case 'Russian':
        return format(AppImagePath.languageIcon, {'country': 'ru'});
      case 'Portuguese':
        return format(AppImagePath.languageIcon, {'country': 'pt'});
      case 'Korean':
        return format(AppImagePath.languageIcon, {'country': 'kr'});
      case 'Vietnamese':
        return format(AppImagePath.languageIcon, {'country': 'vn'});
      case 'Thai':
        return format(AppImagePath.languageIcon, {'country': 'th'});
      case 'Turkish':
        return format(AppImagePath.languageIcon, {'country': 'tr'});
    }
    return AppImagePath.checkIcon02;
  }

}