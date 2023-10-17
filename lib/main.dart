// ignore_for_file: unused_local_variable

import 'package:flashlight/flashlight_app.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // to ensure frameworks's binding before running the app
  final camera = await availableCameras();
  // this will check for camera flashlight availablity in device
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: flashlight(),
    );
  }
}
