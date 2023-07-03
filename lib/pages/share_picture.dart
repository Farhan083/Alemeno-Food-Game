import 'dart:io';

import 'package:alemeno_food_game/pages/click_picture_page.dart';
import 'package:alemeno_food_game/pages/message_page.dart';
import 'package:alemeno_food_game/pallete.dart';
import 'package:alemeno_food_game/services/firebase_service.dart';
import 'package:alemeno_food_game/services/image_recognition_service.dart';
import 'package:flutter/material.dart';

class SharePictureScreen extends StatefulWidget {
  final File imageFile;
  const SharePictureScreen({
    super.key,
    required this.imageFile,
  });

  @override
  State<SharePictureScreen> createState() => _SharePictureScreenState();
}

class _SharePictureScreenState extends State<SharePictureScreen> {
  ImageRecognitionService imageRecognitionService = ImageRecognitionService();
  FirebaseService firebaseService = FirebaseService();
  List? outputs;
  String recLabel = '';
  bool isFood = false;
  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    imageRecog();
  }

  imageRecog() async {
    await imageRecognitionService.loadModel();
    await imageRecognitionService.classifyImage(widget.imageFile);
    outputs = imageRecognitionService.outputs;

    recLabel = outputs![0]['label'];
    recLabel = recLabel.replaceAll(RegExp(r'[0-9]'), '');
    print(outputs);
    print(recLabel);
    print(recLabel.length);
    if (recLabel == " food") {
      setState(() {
        isFood = true;
      });
    } else {
      setState(() {
        isFood = false;
      });
    }
    print(isFood);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Pallete.whiteColor,
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
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
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 30),
                                child: Stack(
                                  clipBehavior: Clip.none,
                                  children: [
                                    Visibility(
                                      visible:
                                          false, // Set to true to show the widget, false to hide it
                                      maintainSize: true,
                                      maintainAnimation: true,
                                      maintainState: true,
                                      child: Image.asset(
                                        'assets/images/cutleryImg.png',
                                      ),
                                    ),
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
                                              widget.imageFile,
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
                              isFood
                                  ? const Text(
                                      'Will you eat this?',
                                      style: TextStyle(
                                          fontSize: 24, fontFamily: 'Andika'),
                                    )
                                  : const Text(
                                      'This is not a food. Click Again!',
                                      style: TextStyle(
                                          fontSize: 24,
                                          fontFamily: 'Andika',
                                          color: Colors.red),
                                    ),
                              const SizedBox(
                                height: 30,
                              ),
                              isFood
                                  ? SizedBox(
                                      width: 80,
                                      height: 80,
                                      child: FloatingActionButton(
                                        backgroundColor: Pallete.greenColor,
                                        onPressed: () {
                                          setState(() {
                                            isLoading = true;
                                          });
                                          firebaseService
                                              .uploadImageToFirebaseStorage(
                                                  widget.imageFile)
                                              .then((value) =>
                                                  moveToMsgScreen(context));
                                        },
                                        child: const Icon(
                                          Icons.check,
                                          size: 45,
                                        ),
                                      ),
                                    )
                                  : SizedBox(
                                      width: 80,
                                      height: 80,
                                      child: FloatingActionButton(
                                        backgroundColor: Pallete.greenColor,
                                        onPressed: () {
                                          Navigator.pushReplacement(context,
                                              MaterialPageRoute(
                                            builder: (context) {
                                              return const ClickPicturePage();
                                            },
                                          ));
                                        },
                                        child: const Icon(
                                          Icons.camera_alt,
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

  moveToMsgScreen(BuildContext context) {
    Navigator.pushReplacement(context, MaterialPageRoute(
      builder: (context) {
        return MessagePage();
      },
    ));
  }
}
