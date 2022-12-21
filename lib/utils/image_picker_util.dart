import 'package:image_picker/image_picker.dart';
import 'package:treasure_nft_project/constant/global_data.dart';

class ImagePickerUtil {
  // select video
  Future<XFile?> selectVideo() async {
    XFile? video = await ImagePicker().pickVideo(
      source: ImageSource.gallery,
      maxDuration: const Duration(seconds: 30),
    );
    return video;
  }

  //use camera take video
  Future<XFile?> takeVideo() async {
    XFile? video = await ImagePicker().pickVideo(
      source: ImageSource.camera,
      maxDuration: const Duration(seconds: 30),
    );
    return video;
  }

  //take picture
  Future<XFile?> takePicture() async {
    XFile? photo = await ImagePicker()
        .pickImage(source: ImageSource.camera, imageQuality: 50);
    return photo;
  }

  // only use front lens take picture
  Future<XFile?> takePicFrontCamera() async {
    XFile? photo = await ImagePicker().pickImage(
        source: ImageSource.camera,
        preferredCameraDevice: CameraDevice.front,
        imageQuality: 50);
    return photo;
  }

//pick up multiple image
// Future<List<XFile>?> pickImage() async {
//   try {
//     List<XFile>? selectedImages = await ImagePicker().pickMultiImage(imageQuality: 78);
//     if (selectedImages != null) {
//       //read every single image
//       for (var element in selectedImages) {
//         //maximum image = 10
//         if(_imageList.length < 10) {
//           _imageList.add(element);
//         }
//       }
//     }
//     setState(() {});
//   } on PlatformException catch (e) {
//     GlobalData.printLog('Failed to pick image: $e');
//   }
// }

  Future<XFile?> selectImage({bool needCompress = true}) async {
    try {
      XFile? selectedImages = await ImagePicker().pickImage(
          source: ImageSource.gallery, imageQuality: needCompress ? 50 : null);
      if (selectedImages != null) {
        //read every single image
        return selectedImages;
      }
    } catch (e) {
      GlobalData.printLog('Failed to pick image: $e');
    }
    return null;
  }
}
