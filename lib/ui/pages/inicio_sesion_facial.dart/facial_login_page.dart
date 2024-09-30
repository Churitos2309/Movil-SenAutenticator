import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:reconocimiento_app/providers/facial_login_provider.dart';

class FacialLoginPage extends StatefulWidget {
  const FacialLoginPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _FacialLoginPageState createState() => _FacialLoginPageState();
}

class _FacialLoginPageState extends State<FacialLoginPage> {
  File? _image;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    try {
      final pickedFile = await _picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 20,
      );
      if (pickedFile != null) {
        setState(() {
          _image = File(pickedFile.path);
        });
      }
    } catch (e) {
      print('Error al seleccionar la imagen: $e');
    }
  }

  Future<void> _loginFace() async {
    if (_image == null) {
      _showMessage('Por favor, selecciona una imagen.');
      return;
    }

    final provider = Provider.of<FacialLoginProvider>(context, listen: false);
    try {
      final response = await provider.loginFace(
        faceImage: _image!,
      );
      if (response['matching'] != null) {
        if (response['matching']) {
          _showMessage('Inicio de sesión exitoso: ${response['user_name']}');
        } else {
          _showMessage('Usuario no encontrado');
        }
      } else {
        _showMessage('Error en el inicio de sesión facial: Respuesta nula o inválida');
      }
    } catch (e) {
      _showMessage('Error en el inicio de sesión facial: $e');
    }
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<FacialLoginProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Inicio de Sesión Facial'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _image == null
                ? const Text('No se ha seleccionado ninguna imagen.')
                : Image.file(_image!),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _pickImage,
              child: const Text('Seleccionar Imagen'),
            ),
            const SizedBox(height: 16),
            provider.isLoading
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: _loginFace,
                    child: const Text('Iniciar Sesión'),
                  ),
          ],
        ),
      ),
    );
  }
}