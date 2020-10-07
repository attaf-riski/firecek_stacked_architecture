import 'package:image_picker/image_picker.dart';

class MediaService {
  //get image from galery or camera
  Future<PickedFile> getImage({bool fromGallery = true}) async {
    final picker = ImagePicker();
    return await picker.getImage(
        source: fromGallery ? ImageSource.gallery : ImageSource.camera,
        imageQuality: 25);
  }
}
