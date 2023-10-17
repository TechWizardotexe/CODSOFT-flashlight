// ignore_for_file: camel_case_types, use_build_context_synchronously

import 'package:camera/camera.dart';
import 'package:flashlight/error_handling.dart';
import 'package:flutter/material.dart';

class flashlight extends StatefulWidget {
  const flashlight({super.key});

  @override
  State<flashlight> createState() => _flashlightState();
}

class _flashlightState extends State<flashlight> {
  late CameraController _controller;
  bool isFlashlightOn = false;
  // initially flashlight state in turned off

  @override
  void initState() {
    super.initState();
    _initCameraController(context);
  }

  Future<void> _initCameraController(BuildContext context) async {
    final cameras = await availableCameras();
    if (cameras.isEmpty) {
      ErrorHandling.showErrorDialog(
          context, "No Camera flash available on this device.");
    } else {
      _controller = CameraController(cameras[0], ResolutionPreset.medium);
      await _controller.initialize();
    }

    if (mounted) {
      setState(() {});
    }
  }

  void _toggleFlashlight() {
    if (_controller.value.isInitialized) {
      if (isFlashlightOn) {
        _controller.setFlashMode(FlashMode.off);
      } else {
        _controller.setFlashMode(FlashMode.torch);
      }
      setState(() {
        isFlashlightOn = !isFlashlightOn;
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade700,
        title:
            const Text('Flashlight App', style: TextStyle(color: Colors.white)),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Flashlight",
              style: TextStyle(
                  fontSize: 60,
                  color: Colors.green.shade700,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15),
            Text(
              "_" * 69,
              style: const TextStyle(color: Colors.grey),
            ),
            const Padding(
              padding: EdgeInsets.only(bottom: 50),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  shadowColor: Colors.black,
                  backgroundColor: Colors.grey.shade400,
                  fixedSize: const Size(180, 50)),
              onPressed: _toggleFlashlight,
              child: Text(
                isFlashlightOn ? "OFF" : "ON",
                style: const TextStyle(color: Colors.black, fontSize: 40),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
