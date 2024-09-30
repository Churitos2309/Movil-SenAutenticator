// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:provider/provider.dart';
// import 'package:reconocimiento_app/services/api_services.dart';

// class ProfilePage extends StatefulWidget {
//   const ProfilePage({super.key});

//   @override
//   // ignore: library_private_types_in_public_api
//   _ProfilePageState createState() => _ProfilePageState();
// }

// class _ProfilePageState extends State<ProfilePage> {
//   final _formKey = GlobalKey<FormState>();
//   final _picker = ImagePicker();
//   File? _image;
//   final Map<String, dynamic> _profileData = {
//     "numero_documento_usuario": "444",
//     "password": "1234",
//     "first_name": "Juan",
//     "last_name": "Usuario",
//     "email": "Usuario@gmail.com",
//     "tipo_documento_usuario": "Cédula de ciudadanía",
//     "genero_usuario": "Masculino",
//     "rol_usuario": "Usuario"
//   };

//   Future<void> _pickImage() async {
//     final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
//     if (pickedFile != null) {
//       setState(() {
//         _image = File(pickedFile.path);
//       });
//     }
//   }

//   Future<void> _submitProfile() async {
//     if (_formKey.currentState!.validate()) {
//       _formKey.currentState!.save();
//       final apiService = Provider.of<ApiService>(context, listen: false);
//       try {
//         final response = await apiService.uploadProfile(_profileData, _image);
//         print('Profile updated: $response');
//       } catch (e) {
//         print('Error updating profile: $e');
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Profile'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: ListView(
//             children: [
//               GestureDetector(
//                 onTap: _pickImage,
//                 child: CircleAvatar(
//                   radius: 50,
//                   backgroundImage: _image != null ? FileImage(_image!) : const AssetImage('assets/default_profile.png') as ImageProvider,
//                 ),
//               ),
//               const SizedBox(height: 16),
//               TextFormField(
//                 initialValue: _profileData['first_name'],
//                 decoration: const InputDecoration(labelText: 'First Name'),
//                 onSaved: (value) {
//                   _profileData['first_name'] = value!;
//                 },
//               ),
//               TextFormField(
//                 initialValue: _profileData['last_name'],
//                 decoration: const InputDecoration(labelText: 'Last Name'),
//                 onSaved: (value) {
//                   _profileData['last_name'] = value!;
//                 },
//               ),
//               TextFormField(
//                 initialValue: _profileData['email'],
//                 decoration: const InputDecoration(labelText: 'Email'),
//                 onSaved: (value) {
//                   _profileData['email'] = value!;
//                 },
//               ),
//               // Agrega más campos según sea necesario
//               const SizedBox(height: 16),
//               ElevatedButton(
//                 onPressed: _submitProfile,
//                 child: const Text('Save Profile'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:reconocimiento_app/ui/pages/custom_app_bar_lobby.dart';

class ProfilePage extends StatefulWidget {
  final dynamic user;

  const ProfilePage({super.key, required this.user});

  @override
  // ignore: library_private_types_in_public_api
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // UserController userController = UserController();
  final passwordController = TextEditingController();
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final fotoController = TextEditingController();

  get userController => null;

  @override
  Widget build(BuildContext contex) {
    return Scaffold(
      appBar: const CustomAppBarLobby(
        title: 'Perfil',
      ),
      body: ListView(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: Column(
              children: [
                SizedBox(
                  width: 200,
                  height: 200,
                  child: ClipOval(
                    child: widget.user!.profilePicture != null
                        ? Image.network(
                            widget.user!.profilePicture!,
                            fit: BoxFit.cover,
                          )
                        : Image.network(
                            'https://cdn-icons-png.flaticon.com/512/2223/2223126.png',
                            cacheWidth: 200,
                          ),
                    // Image.asset(
                    //     'assets/images/default_profile_picture.png', // Imagen predeterminada
                    //     fit: BoxFit.cover,
                    //   ),
                  ),
                  // ClipOval(child: Image.network(widget.user.profilePicture, fit: BoxFit.cover,)),
                ),
                const SizedBox(height: 30),
                Row(children: [
                  const Text("Nome: "),
                  const SizedBox(width: 20),
                  Expanded(
                    child: TextFormField(
                      controller: usernameController,
                      decoration: InputDecoration(
                          hintText: widget.user.username,
                          border: const OutlineInputBorder()),
                    ),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        String newUsername = usernameController.text;
                        userController.updateUsername(widget.user, newUsername);
                        setState(() {
                          widget.user.username = newUsername;
                        });
                      },
                      child: const Text('Atualizar Nome')),
                ]),
                const SizedBox(height: 30),
                Row(children: [
                  const Text("Senha: "),
                  const SizedBox(width: 20),
                  Expanded(
                    child: TextFormField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                          hintText: widget.user.password,
                          border: const OutlineInputBorder()),
                    ),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        String newPassword = passwordController.text;
                        userController.updatePassword(widget.user, newPassword);
                        setState(() {
                          widget.user.password = newPassword;
                        });
                      },
                      child: const Text('Atualizar Senha')),
                ]),
                const SizedBox(height: 30),
                Row(children: [
                  const Text("Email: "),
                  const SizedBox(width: 20),
                  Expanded(
                    child: TextFormField(
                      controller: emailController,
                      decoration: InputDecoration(
                          hintText: widget.user.email,
                          border: const OutlineInputBorder()),
                    ),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        String email = emailController.text;
                        userController.updateEmail(widget.user, email);
                        setState(() {
                          widget.user.email = email;
                        });
                      },
                      child: const Text('Atualizar Email')),
                ]),
                const SizedBox(height: 30),
                Row(children: [
                  const Text("Foto de Perfil: "),
                  const SizedBox(width: 20),
                  Expanded(
                    child: TextFormField(
                      controller: fotoController,
                      decoration: InputDecoration(
                          hintText: widget.user.profilePicture,
                          border: const OutlineInputBorder()),
                    ),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        String fotoURL = fotoController.text;
                        userController.updatePassword(widget.user, fotoURL);
                        setState(() {
                          widget.user.profilePicture = fotoURL;
                        });
                      },
                      child: const Text('Atualizar foto')),
                ]),
                Text("Nome: ${widget.user.username}"),
                Text("Senha: ${widget.user.password}"),
                Text("Email: ${widget.user.email}"),
                Text("foto: ${widget.user.profilePicture}"),
              ],
            ),
          )
        ],
      ),
    );
  }
}
