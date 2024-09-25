import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:reconocimiento_app/ui/widgets/button_new_navigation.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({super.key});

  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  CameraController? _controller;
  File? _image;

  @override
  void initState() {
    super.initState();
    _initCamera();
  }

  Future<void> _initCamera() async {
    try {
      final cameras = await availableCameras();
      final firstCamera = cameras.first;
      _controller = CameraController(firstCamera, ResolutionPreset.medium);
      await _controller?.initialize();
      setState(() {}); // Ensure the UI is updated after the camera is initialized
    } catch (e) {
      print('Error initializing camera: $e');
    }
  }

  Future<void> _takePicture() async {
    try {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(source: ImageSource.camera);
      setState(() {
        if (pickedFile != null) {
          _image = File(pickedFile.path);
        } else {
          _image = null;
        }
      });
    } catch (e) {
      print('Error taking picture: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cámara'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _controller == null || !_controller!.value.isInitialized
                ? const CircularProgressIndicator()
                : AspectRatio(
                    aspectRatio: _controller!.value.aspectRatio,
                    child: CameraPreview(_controller!),
                  ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _takePicture,
              child: const Text('Tomar Foto'),
            ),
            _image == null
                ? Container()
                : Image.file(_image!),
          ],
        ),
      ),
      bottomNavigationBar: const ButtonNewNavigation(),
    );
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }
}