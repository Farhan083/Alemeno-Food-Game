import 'dart:io';

import 'package:alemeno_food_game/services/helper_function.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as path;
import 'package:image/image.dart' as img;
import 'package:path_provider/path_provider.dart';

class FirebaseService {
  Future<void> uploadImageToFirebaseStorage(File imageFile) async {
    final storage = FirebaseStorage.instance;
    // loading shared preference
    HelperFunction helperFunction = HelperFunction();
    String? userId = await helperFunction.loadUserId();
    final fileName = '${userId}_${path.basename(imageFile.path)}';

    //setting the quality of the image

    // Read the image file
    final image = img.decodeImage(await imageFile.readAsBytes());

    // Resize the image to a specific width and height
    final resizedImage = img.copyResize(image!, width: 512, height: 512);

    // Compress the image by adjusting the quality (0-100, 100 being highest)
    final compressedImage = img.encodeJpg(resizedImage, quality: 80);

    // Get the temporary directory path
    final tempDir = await getTemporaryDirectory();

    // Create a temporary file path
    final tempPath = path.join(tempDir.path, 'compressed_image.jpg');

    // Write the compressed image to the temporary file
    File(tempPath).writeAsBytesSync(compressedImage);

    final Reference ref = storage.ref().child('users/$userId/$fileName');

    try {
      await ref.putFile(File(tempPath));
      final String imageUrl = await ref.getDownloadURL();
      print('Image uploaded successfully. URL: $imageUrl');
    } catch (e) {
      print('Error uploading image: $e');
    }
  }
}
