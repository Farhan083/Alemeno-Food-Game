import 'package:alemeno_food_game/pages/click_picture_page.dart';
import 'package:alemeno_food_game/pallete.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Pallete.whiteColor,
      body: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 150),
              child: ElevatedButton(
                style: ButtonStyle(
                  padding: MaterialStatePropertyAll(
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 8)
                        .copyWith(bottom: 12),
                  ),
                  backgroundColor:
                      const MaterialStatePropertyAll(Pallete.greenColor),
                  shape: const MaterialStatePropertyAll(RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(50)))),
                ),
                child: const Text(
                  "Share your meal",
                  style: TextStyle(
                    fontSize: 25,
                    fontFamily: "Andika",
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return ClickPicturePage();
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
