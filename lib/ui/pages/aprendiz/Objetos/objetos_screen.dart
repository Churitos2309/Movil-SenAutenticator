import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'dart:convert';
import 'dart:io';
import 'package:image/image.dart' as img;

class ObjetosScreen extends StatefulWidget {
  const ObjetosScreen({Key? key}) : super(key: key);

  @override
  _ObjetosScreenState createState() => _ObjetosScreenState();
}

class _ObjetosScreenState extends State<ObjetosScreen> {
  final TextEditingController _marcaController = TextEditingController();
  final TextEditingController _modeloController = TextEditingController();
  final TextEditingController _descripcionController = TextEditingController();
  File? _image;
  bool _isLoading = false;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 800,
      maxHeight: 800,
    );

    if (pickedFile != null) {
      final File imageFile = File(pickedFile.path);

      // Redimensionar la imagen
      final img.Image image = img.decodeImage(imageFile.readAsBytesSync())!;
      final img.Image resizedImage = img.copyResize(image, width: 800);

      final File resizedFile = File(pickedFile.path)
        ..writeAsBytesSync(img.encodeJpg(resizedImage, quality: 85));

      setState(() {
        _image = resizedFile;
      });
    }
  }

  Future<void> _submitData() async {
    if (_image == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Por favor, selecciona una imagen')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    final String url = 'https://backendsenauthenticator.onrender.com/api/objeto/';

    final request = http.MultipartRequest('POST', Uri.parse(url));
    request.fields['marca_objeto'] = _marcaController.text;
    request.fields['modelo_objeto'] = _modeloController.text;
    request.fields['descripcion_objeto'] = _descripcionController.text;

    request.files.add(await http.MultipartFile.fromPath(
      'foto_objeto',
      _image!.path,
    ));

    try {
      final response = await request.send();

      if (response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Objeto creado exitosamente')),
        );
        _marcaController.clear();
        _modeloController.clear();
        _descripcionController.clear();
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
        if (_image != null)
          Image.file(
            _image!,
            height: 150,
            width: 150,
            fit: BoxFit.cover,
          ),
        const SizedBox(height: 8.0),
        ElevatedButton(
          onPressed: _pickImage,
          child: const Text('Seleccionar Imagen'),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF39A900),
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            textStyle: TextStyle(fontSize: isWideScreen ? 18 : 16),
          ),
        ),
        const SizedBox(height: 24.0),
        if (_isLoading)
          Center(child: CircularProgressIndicator()),
        if (!_isLoading)
          Center(
            child: ElevatedButton(
              onPressed: _submitData,
              child: const Text('Aceptar'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF39A900),
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                textStyle: TextStyle(fontSize: isWideScreen ? 18 : 16),
              ),
            ),
          ),
      ],
    );
  }
}
