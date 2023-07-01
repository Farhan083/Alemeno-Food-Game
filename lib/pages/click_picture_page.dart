import 'package:alemeno_food_game/pallete.dart';
import 'package:flutter/material.dart';

class ClickPicturePage extends StatefulWidget {
  const ClickPicturePage({super.key});

  @override
  State<ClickPicturePage> createState() => _ClickPicturePageState();
}

class _ClickPicturePageState extends State<ClickPicturePage> {
  @override
  Widget build(BuildContext context) {
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
                              Positioned(
                                left: 50,
                                top: -25,
                                child: Image.asset(
                                  'assets/images/corners.png',
                                  width: 240,
                                ),
                              ),
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
                            onPressed: () {},
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
}
