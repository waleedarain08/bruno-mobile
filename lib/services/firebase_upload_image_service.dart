import 'package:brunos_kitchen/main.dart';
import 'package:brunos_kitchen/view_models/auth_view_model.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:provider/provider.dart';
import 'package:universal_io/io.dart';

class FirebaseUploadImageService {
  Future<String> upLoadImageFile(
      {required CroppedFile mFileImage, required String fileName}) async {
    final Reference storageReference = FirebaseStorage.instance.ref().child(
        navigatorKey.currentContext!
            .read<AuthViewModel>()
            .getAuthResponse
            .data!
            .sId!);
    // Create a reference to "mountains.jpg"
    final mountainsRef = storageReference.child("$fileName.jpg");
    mountainsRef.putFile(File(mFileImage.path));
    String url = await mountainsRef.getDownloadURL();
    return url;
  }
}
