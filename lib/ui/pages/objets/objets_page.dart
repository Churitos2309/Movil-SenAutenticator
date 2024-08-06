import 'package:flutter/material.dart';
class ObjetsPage extends StatelessWidget {
  const ObjetsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Objetos registrados'),
      ),
      body: const Center(
        child: Text('Objets'),
      ),
    );
  }
}