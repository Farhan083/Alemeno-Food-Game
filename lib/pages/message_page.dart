import 'package:alemeno_food_game/pages/home_page.dart';
import 'package:alemeno_food_game/pallete.dart';
import 'package:flutter/material.dart';

class MessagePage extends StatelessWidget {
  const MessagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 120,
            ),
            const Text(
              'GOOD JOB',
              style: TextStyle(
                  fontFamily: 'Lilita',
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: Pallete.greenColor),
            ),
            SizedBox(
              height: 100,
            ),
            ElevatedButton(
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
                "Return to HomePage",
                style: TextStyle(
                  fontSize: 25,
                  fontFamily: "Andika",
                ),
              ),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return HomePage();
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
