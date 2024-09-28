import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;

class ObjetosScreen extends StatefulWidget {
  const ObjetosScreen({Key? key}) : super(key: key);

  @override
  _ObjetosScreenState createState() => _ObjetosScreenState();
}

class _ObjetosScreenState extends State<ObjetosScreen> {
  final TextEditingController _marcaController = TextEditingController();
  final TextEditingController _modeloController = TextEditingController();
  final TextEditingController _descripcionController = TextEditingController();
  final TextEditingController _usuarioController = TextEditingController();
  XFile? _image;
  bool _isLoading = false;

  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    try {
      final pickedFile = await picker.pickImage(
        source: source,
        maxWidth: 800,
        maxHeight: 800,
      );

      if (pickedFile != null) {
        setState(() {
          _image = pickedFile;
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No se seleccionó ninguna imagen.')),
        );
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al seleccionar la imagen: $error')),
      );
    }
  }

  // Mostrar un diálogo para seleccionar entre cámara o galería
  Future<void> _selectImageSource() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Seleccionar imagen desde:'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cámara'),
              onPressed: () {
                Navigator.of(context).pop(); // Cerrar el diálogo
                _pickImage(ImageSource.camera); // Abrir la cámara
              },
            ),
            TextButton(
              child: const Text('Galería'),
              onPressed: () {
                Navigator.of(context).pop(); // Cerrar el diálogo
                _pickImage(ImageSource.gallery); // Abrir la galería
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _submitData() async {
    if (_marcaController.text.isEmpty ||
        _modeloController.text.isEmpty ||
        _descripcionController.text.isEmpty ||
        _usuarioController.text.isEmpty ||
        _image == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, completa todos los campos e incluye una imagen')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    const String url = 'https://backendsenauthenticator.up.railway.app/api/objetos/';

    final request = http.MultipartRequest('POST', Uri.parse(url))
      ..fields['marca_objeto'] = _marcaController.text
      ..fields['modelo_objeto'] = _modeloController.text
      ..fields['descripcion_objeto'] = _descripcionController.text
      ..fields['usuario_objeto'] = _usuarioController.text;

    if (!kIsWeb) {
      request.files.add(await http.MultipartFile.fromPath(
        'foto_objeto',
        _image!.path,
      ));
    } else {
      request.files.add(http.MultipartFile.fromBytes(
        'foto_objeto',
        await _image!.readAsBytes(),
        filename: _image!.name,
      ));
    }

    try {
      final response = await request.send();

      if (response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Objeto creado exitosamente')),
        );
        _marcaController.clear();
        _modeloController.clear();
        _descripcionController.clear();
        _usuarioController.clear();
        setState(() {
          _image = null;
        });
      } else {
        final responseBody = await response.stream.bytesToString();
        final errorResponse = jsonDecode(responseBody);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al crear el objeto: ${response.statusCode} - ${errorResponse['message'] ?? 'Sin detalles'}')),
        );
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al crear el objeto: $error')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          bool isWideScreen = constraints.maxWidth > 600;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (isWideScreen)
                  Row(
                    children: [
                      Expanded(
                        flex: 4,
                        child: Container(
                          color: Colors.white,
                          child: Center(
                            child: Icon(
                              Icons.do_not_disturb,
                              size: 200,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 6,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: _buildContent(isWideScreen),
                        ),
                      ),
                    ],
                  )
                else
                  Column(
                    children: [
                      Container(
                        width: 150,
                        height: 150,
                        color: Colors.white,
                        child: Center(
                          child: Icon(
                            Icons.do_not_disturb,
                            size: 100,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Text(
                            'Prohibido el ingreso de:',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      _buildContent(isWideScreen),
                    ],
                  ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildContent(bool isWideScreen) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (isWideScreen) ...[
          Text(
            'Prohibido el ingreso de:',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 8.0),
        ],
        Text(
          'Armas, municiones, explosivos, elementos cortantes, punzantes, contundentes o sus combinaciones, que amenacen o causen riesgo a la convivencia',
          style: TextStyle(
            fontSize: isWideScreen ? 16 : 14,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 16.0),
        Text(
          '¿Qué objeto desea ingresar?',
          style: TextStyle(
            fontSize: isWideScreen ? 18 : 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 8.0),
        TextField(
          controller: _marcaController,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Ingrese la marca del objeto',
          ),
        ),
        const SizedBox(height: 16.0),
        TextField(
          controller: _modeloController,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Ingrese el modelo del objeto',
          ),
        ),
        const SizedBox(height: 16.0),
        TextField(
          controller: _descripcionController,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Ingrese una descripción del objeto',
          ),
        ),
        const SizedBox(height: 16.0),
        TextField(
          controller: _usuarioController,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Ingrese el usuario del objeto',
          ),
        ),
        const SizedBox(height: 16.0),
        if (_image != null)
          kIsWeb
              ? Image.network(
                  _image!.path,
                  height: 150,
                  width: 150,
                  fit: BoxFit.cover,
                )
              : Image.file(
                  File(_image!.path),
                  height: 150,
                  width: 150,
                  fit: BoxFit.cover,
                ),
        const SizedBox(height: 16.0),
        ElevatedButton(
          onPressed: _selectImageSource,
          child: Text(_image == null ? 'Seleccionar imagen' : 'Cambiar imagen'),
        ),
        const SizedBox(height: 16.0),
        ElevatedButton(
          onPressed: _isLoading ? null : _submitData,
          child: _isLoading
              ? const CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                )
              : const Text('Enviar'),
        ),
      ],
    );
  }
}
