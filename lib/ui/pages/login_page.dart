// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:reconocimiento_app/providers/login_privider.dart';

// class LoginPage extends StatelessWidget {
//   const LoginPage({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Login Page'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             const Text('Login Page'),
//             LoginForm(),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class LoginForm extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final loginProvider = Provider.of<LoginProvider>(context);

//     return Column(
//       children: [
//         TextField(
//           onChanged: (value) => loginProvider.setNumeroIdentificacion(value),
//           decoration: InputDecoration(labelText: 'Número de Identificación'),
//         ),
//         TextField(
//           onChanged: (value) => loginProvider.setPassword(value),
//           decoration: InputDecoration(labelText: 'Password'),
//         ),
//         ElevatedButton(
//           onPressed: () {
//             loginProvider.login();
//           },
//           child: Text('Login'),
//         ),
//       ],
//     );
//   }
// }