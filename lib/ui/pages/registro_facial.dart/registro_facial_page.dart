import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart'
    as http; // Asegúrate de agregar la dependencia en el pubspec.yaml
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class RegisterFacePage extends StatefulWidget {
  @override
  _RegisterFacePageState createState() => _RegisterFacePageState();
}

class _RegisterFacePageState extends State<RegisterFacePage> {
  File? _image;
  final picker = ImagePicker();

  // Método para seleccionar una imagen desde la cámara
  Future<void> _pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    } else {
      print('No image selected.');
    }
  }

  // Método para registrar el rostro en el servidor
  Future<void> _registerFace() async {
    if (_image == null) {
      print("No se ha seleccionado ninguna imagen.");
      // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      //   content: Text('No se ha seleccionado ninguna imagen.'),
      // ));
      return;
    }

    // Datos adicionales que la API requiere
    Map<String, String> body = {
      'nombre_completo':
          'Juan Ochoa Cordoba', // Cambia esto por datos dinámicos o ingrésalos manualmente
      'numero_documento':
          '23090099', // Cambia esto por datos dinámicos o ingrésalos manualmente
    };

    try {
      // Crear la solicitud multipart
      var request = http.MultipartRequest(
          'POST',
          Uri.parse(
              'https://backsenauthenticator.up.railway.app/api/registroFacial/'));

      // Añadir los campos de texto (nombre completo y documento)
      request.fields.addAll(body);

      // Adjuntar la imagen
      request.files.add(await http.MultipartFile.fromPath(
        'face_register', // Nombre del campo esperado en la API
        _image!.path,
        filename: basename(_image!.path),
      ));

      // Enviar la solicitud
      var response = await request.send();

      // Procesar la respuesta
      if (response.statusCode == 201) {
        var responseData = await response.stream.bytesToString();
        var decodedResponse = jsonDecode(responseData);

        print("Rostro registrado exitosamente: ${decodedResponse['message']}");
        // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        // content:
        Text('Rostro registrado exitosamente.');
        // ));
      } else {
        var errorData = await response.stream.bytesToString();
        print("Error en el registro facial: $errorData");
        // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        //   content: Text('Error en el registro facial.'),
        // ));
      }
    } catch (e) {
      print("Error en la solicitud: $e");
      // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      //   content: Text('Error en la solicitud de registro facial.'),
      // ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registrar Rostro'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _image == null
                ? Text('No se ha seleccionado ninguna imagen.')
                : Image.file(_image!),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _pickImage,
              child: Text('Tomar Foto'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _registerFace,
              child: Text('Registrar Rostro'),
            ),
          ],
        ),
      ),
    );
  }
}
