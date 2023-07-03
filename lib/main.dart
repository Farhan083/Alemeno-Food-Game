import 'package:alemeno_food_game/pages/home_page.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Alemeno Food Game',
      home: HomePage(),
    );
  }
}
