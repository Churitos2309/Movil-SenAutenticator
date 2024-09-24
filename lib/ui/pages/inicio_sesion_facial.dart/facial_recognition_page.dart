import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:reconocimiento_app/services/api_services.dart';

class FacialRecognitionPage extends StatefulWidget {
  @override
  _FacialRecognitionPageState createState() => _FacialRecognitionPageState();
}

class _FacialRecognitionPageState extends State<FacialRecognitionPage> {
  final ApiService apiService = ApiService();
  File? _image;
  final ImagePicker _picker = ImagePicker();
  bool _isLoading = false; // Indicador de carga

  // Función para seleccionar la imagen desde la galería o cámara
  Future<void> _pickImage() async {
    try {
      final pickedFile = await _picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 20, //Reducir calidad para reducir tamaño
      );
      if (pickedFile != null) {
        setState(() {
          _image = File(pickedFile.path);
          _showMessage(context,
              'Imagen seleccionada con éxito.'); // Pass the context here
        });
      } else {
        _showMessage(context,
            'No se ha seleccionado ninguna imagen.'); // Pass the context here
      }
    } catch (e) {
      _showMessage(context,
          'Error al seleccionar la imagen: $e'); // Pass the context here
    }
  }

  // Función para enviar la imagen a la API
  Future<void> _sendImage() async {
    if (_image == null) {
      _showMessage(context,
          'No se ha seleccionado ninguna imagen.'); // Pass the context here
      return;
    }

    setState(() {
      _isLoading = true; // Inicia el indicador de carga
    });

    try {
      final result =
          await apiService.postWithImage('inicioSesionFacial/', _image!);
      print('Respuesta completa: $result');
      _showMessage(context, 'Resultado: $result'); // Pass the context here
      // Manejar la respuesta según el resultado (matching, user_name, etc.)
    } catch (e) {
      print('Error detallado: $e'); // Pass the context here
      _showMessage(
          context, 'Error al enviar la imagen: $e'); // Pass the context here
    } finally {
      setState(() {
        _isLoading = false; // Detiene el indicador de carga
      });
    }
  }

  // Mostrar SnackBar con un mensaje
  void _showMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inicio Sesión Facial'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _image != null
                ? Image.file(_image!)
                : Text('No se ha seleccionado ninguna imagen.'),
            SizedBox(height: 20),
            _isLoading
                ? CircularProgressIndicator() // Indicador de carga
                : Column(
                    children: [
                      ElevatedButton(
                        onPressed: _pickImage,
                        child: Text('Tomar Foto'),
                      ),
                      ElevatedButton(
                        onPressed: _sendImage,
                        child: Text('Enviar Imagen'),
                      ),
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}
