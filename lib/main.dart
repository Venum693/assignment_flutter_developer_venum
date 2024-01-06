import 'package:assignment_flutter_developer_venum/screen1.dart';
import 'package:assignment_flutter_developer_venum/screen2.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      home: Screen2(),
    );
  }
}
