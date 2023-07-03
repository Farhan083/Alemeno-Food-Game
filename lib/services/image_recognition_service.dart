import 'dart:io';
import 'package:flutter_tflite/flutter_tflite.dart';

class ImageRecognitionService {
  bool? isLoading;
  File? image;
  List? outputs;
  String filePath = '';

  loadModel() async {
    await Tflite.loadModel(
      model: "assets/model_unquant.tflite",
      labels: "assets/labels.txt",
// numThreads: 1, // defaults to 1
// isAsset: true, // defaults to true, set to false to load resources outside assets
// useGpuDelegate: false // defaults to false, set to true to use GPU delegate
    );
  }

  classifyImage(File imageFile) async {
    filePath = imageFile.path;
    var output = await Tflite.runModelOnImage(
        path: filePath, // required
        imageMean: 0.0, // defaults to 117.0
        imageStd: 255.0, // defaults to 1.0
        numResults: 2, // defaults to 5
        threshold: 0.2, // defaults to 0.1
        asynch: true // defaults to true
        );
    outputs = output;
  }
}
