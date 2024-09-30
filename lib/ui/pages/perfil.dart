import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:reconocimiento_app/services/api_services.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _formKey = GlobalKey<FormState>();
  final _picker = ImagePicker();
  File? _image;
  final Map<String, dynamic> _profileData = {
    "numero_documento_usuario": "444",
    "password": "1234",
    "first_name": "Juan",
    "last_name": "Usuario",
    "email": "Usuario@gmail.com",
    "tipo_documento_usuario": "Cédula de ciudadanía",
    "genero_usuario": "Masculino",
    "rol_usuario": "Usuario"
  };

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Future<void> _submitProfile() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final apiService = Provider.of<ApiService>(context, listen: false);
      try {
        final response = await apiService.uploadProfile(_profileData, _image);
        print('Profile updated: $response');
      } catch (e) {
        print('Error updating profile: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              GestureDetector(
                onTap: _pickImage,
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: _image != null ? FileImage(_image!) : const AssetImage('assets/default_profile.png') as ImageProvider,
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                initialValue: _profileData['first_name'],
                decoration: const InputDecoration(labelText: 'First Name'),
                onSaved: (value) {
                  _profileData['first_name'] = value!;
                },
              ),
              TextFormField(
                initialValue: _profileData['last_name'],
                decoration: const InputDecoration(labelText: 'Last Name'),
                onSaved: (value) {
                  _profileData['last_name'] = value!;
                },
              ),
              TextFormField(
                initialValue: _profileData['email'],
                decoration: const InputDecoration(labelText: 'Email'),
                onSaved: (value) {
                  _profileData['email'] = value!;
                },
              ),
              // Agrega más campos según sea necesario
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _submitProfile,
                child: const Text('Save Profile'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}