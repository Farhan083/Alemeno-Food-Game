import 'package:alemeno_food_game/pallete.dart';
import 'package:alemeno_food_game/services/firebase_service.dart';
import 'package:alemeno_food_game/services/helper_function.dart';
import 'package:flutter/material.dart';

class SharedMealPage extends StatefulWidget {
  const SharedMealPage({super.key});

  @override
  State<SharedMealPage> createState() => _SharedMealPageState();
}

class _SharedMealPageState extends State<SharedMealPage> {
  List<String> imageUrls = [];
  HelperFunction helperFunction = HelperFunction();
  FirebaseService firebaseService = FirebaseService();
  bool isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserImages();
  }

  getUserImages() async {
    var userId = await helperFunction.loadUserId();
    List<String> urls =
        await firebaseService.getUserImagesFromFirebaseStorage(userId!);

    setState(() {
      imageUrls = urls;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Shared meals"),
        centerTitle: true,
        backgroundColor: Pallete.greenColor,
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: imageUrls.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      height: 400,
                      width: 512,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(imageUrls[index]),
                          fit: BoxFit.contain,
                        ),
                      ),
                      // child: Image.network(imageUrls[index]),
                    ),
                    SizedBox(
                      width: 100,
                      child: Divider(
                        thickness: 4,
                        height: 2,
                      ),
                    ),
                    SizedBox(
                      height: 6,
                    ),
                  ],
                );
              },
            ),
    );
  }
}
