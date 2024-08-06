import 'package:flutter/material.dart';

class CameraOpen extends StatelessWidget {
  const CameraOpen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            IconButton(
              icon: const Icon(Icons.camera_alt),
              onPressed: () {
                Navigator.of(context).pushNamed('/camera');
              },
            ),
          ],
        ),
      ),
    );
  }
}