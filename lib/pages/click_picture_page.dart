import 'dart:io';

import 'package:alemeno_food_game/pages/share_picture.dart';
import 'package:alemeno_food_game/pallete.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:async';

class ClickPicturePage extends StatefulWidget {
  const ClickPicturePage({super.key});

  @override
  State<ClickPicturePage> createState() => _ClickPicturePageState();
}

class _ClickPicturePageState extends State<ClickPicturePage> {
  late CameraController cameraController;
  late List<CameraDescription> cameras;
  // late String imagePath;
  File? imagePath;
  bool isInitialized = false;
  bool isError = false;
  String errorMessage = '';
  String savedImagePath = '';
  bool isLoading = false;
  bool isAvailable = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initializeCamera();
  }

  Future<void> initializeCamera() async {
    cameras = await availableCameras();
    cameraController = CameraController(
      cameras[0], // You can choose a specific camera here (front/rear)
      ResolutionPreset.high,
      imageFormatGroup: ImageFormatGroup.yuv420,
    );
    // await cameraController.initialize();
    // setState(() {
    //   isInitialized = true;
    // });
    cameraController.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {
        isInitialized = true;
      });
    }).catchError((Object e) {
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessDenied':
            // Handle access errors here.
            setState(() {
              isError = true;
              errorMessage =
                  '${e.code} - ${e.description}\nPlease allow permissions from App Settings';
            });

            print(errorMessage);

            break;
          default:
            // Handle other errors here.
            setState(() {
              isError = true;
              errorMessage = '${e.code} - ${e.description}';
            });
            print(errorMessage);
            break;
        }
      }
    });
  }

  Future<void> takePicture() async {
    if (!cameraController.value.isInitialized) {
      return;
    }
    print('outside try catch');
    print('outside try catch');
    print('outside try catch');
    // try {
    final XFile imageFile = await cameraController.takePicture();
    print('before directory');
    final directory = await getApplicationDocumentsDirectory();
    final fileName = 'my_image.jpg';
    savedImagePath = '${directory.path}/$fileName';
    print('inside takepicture');
    print(savedImagePath);

    await File(imageFile.path).copy(savedImagePath);

    setState(() {
      imagePath = File(imageFile.path);
      isAvailable = true;
    });
    print(imageFile.path);
    print("hello");
    // } catch (e) {
    //   print('Error capturing image: $e');
    // }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final CameraController? cameraControllerr = cameraController;

    // App state changed before we got the chance to initialize.
    if (cameraControllerr == null || !cameraControllerr.value.isInitialized) {
      return;
    }

    if (state == AppLifecycleState.inactive) {
      cameraControllerr.dispose();
    } else if (state == AppLifecycleState.resumed) {
      initializeCamera();
    }
  }

  @override
  void dispose() {
    cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Widget cameraPreview = CameraPreview(cameraController);
    if (isError && !isInitialized) {
      return Scaffold(
        body: SizedBox(
          width: double.infinity,
          child: Center(
            child: Text(errorMessage),
          ),
        ),
      );
    }

    if (!isInitialized) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return Scaffold(
      backgroundColor: Pallete.whiteColor,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        height: 50,
                        width: 50,
                        margin: const EdgeInsets.only(top: 20, left: 20),
                        decoration: BoxDecoration(
                          color: Pallete.greenColor,
                          borderRadius: const BorderRadius.all(
                            Radius.circular(50),
                          ),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black.withOpacity(0.3),
                                blurRadius: 2,
                                spreadRadius: 2,
                                offset: const Offset(0, 2)),
                          ],
                        ),
                        child: const Icon(
                          Icons.arrow_back,
                          color: Pallete.whiteColor,
                          size: 35,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Image.asset(
                  'assets/images/lionImg2.png',
                ),
                Expanded(
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Pallete.greyColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50),
                      ),
                    ),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 100,
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 30),
                          child: Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Image.asset(
                                'assets/images/cutleryImg.png',
                              ),
                              // !cameraController.value.isInitialized ?

                              Positioned(
                                left: 50,
                                top: -25,
                                child: Image.asset(
                                  'assets/images/corners.png',
                                  width: 240,
                                ),
                              ),

                              if (!isInitialized) // Display a placeholder while the camera is initializing
                                const Positioned(
                                  top: -15,
                                  left: 70,
                                  child: CircleAvatar(
                                    backgroundColor: Pallete.cameraPreviewColor,
                                    radius: 100,
                                  ),
                                )
                              else if (imagePath ==
                                  null) // Display the camera preview
                                Positioned(
                                  top: -15,
                                  left: 70,
                                  child: ClipOval(
                                    child: SizedBox(
                                      height: 200,
                                      width: 200,
                                      child: AspectRatio(
                                        aspectRatio: 1,
                                        child: CameraPreview(cameraController),
                                      ),
                                    ),
                                  ),
                                )
                              else // Display the captured image
                                Positioned(
                                  top: -15,
                                  left: 70,
                                  child: ClipOval(
                                    child: SizedBox(
                                      height: 200,
                                      width: 200,
                                      child: AspectRatio(
                                        aspectRatio: 1,
                                        child: Image.file(
                                          File(savedImagePath),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        const Text(
                          'Click your meal',
                          style: TextStyle(fontSize: 24, fontFamily: 'Andika'),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        SizedBox(
                          width: 80,
                          height: 80,
                          child: FloatingActionButton(
                            backgroundColor: Pallete.greenColor,
                            onPressed: () {
                              // await takePicture();
                              // if (isAvailable)
                              //   navigateToNextScreen(context);
                              // else {
                              //   print('not completed');
                              // }
                              takePicandNavigate(context);
                            },
                            child: const Icon(
                              Icons.camera_alt_sharp,
                              size: 45,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // void navigateToNextScreen(BuildContext context) async {
  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(
  //         builder: (context) => SharePictureScreen(imageFile: imagePath!)),
  //   );
  // }

  void takePicandNavigate(BuildContext context) async {
    await takePicture();
    print('wait completed');
    navigateToNextScreen(context);
  }

  void navigateToNextScreen(BuildContext context) {
    if (imagePath != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => SharePictureScreen(imageFile: imagePath!),
        ),
      );
    } else {
      // Handle error when picture is not taken
      print('Picture not taken');
    }
  }
}
