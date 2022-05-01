import 'package:flutter/material.dart';
import 'package:lab3/page/home_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "News App",
      theme: ThemeData(
        primaryColor: Colors.amber,
      ),
      home: const HomePage(),
    );
  }
}

