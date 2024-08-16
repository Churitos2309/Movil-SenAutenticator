import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:reconocimiento_app/ui/pages/home/home_page.dart';

class PaginadeInicio extends StatefulWidget {
  const PaginadeInicio({super.key});

  @override
  State<PaginadeInicio> createState() => _PaginadeInicioState();
}

class _PaginadeInicioState extends State<PaginadeInicio> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isloading = false;

  Future<void> _login() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Por favor, ingrese un correo electrónico y contraseña"),
      ));
      return;
    }

    setState(() {
      _isloading = true;
    });

    try {
      final responselogin = await http.post(
        Uri.parse("https://apimercadolibreochoa.onrender.com/api/login"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          "nombre": "DatoFucticio",
          "email": email,
          "password": password,
        }),
      );

      if (responselogin.statusCode == 200) {
        final jsonData = jsonDecode(responselogin.body);
        if (jsonData['token'] != null) {
          if (mounted) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const MyHomePage()),
            );
          }
        } else {
          _showError("Contraseña o correo son incorrectos.");
        }
      } else if (responselogin.statusCode == 401) {
        final jsonData = jsonDecode(responselogin.body);
        if (jsonData['error'] == 'Invalid password') {
          _showError("La contraseña es incorrecta.");
        } else if (jsonData['error'] == 'Email not found') {
          _showError("El correo no existe.");
        } else {
          _showError("Por favor verifique su correo y contraseña.");
        }
      } else {
        _showError("Por favor verifique su correo.");
      }
    } catch (e) {
      _showError(
          "Ocurrió un error inesperado. Verifique su conexión a Internet e intente nuevamente.");
    } finally {
      setState(() {
        _isloading = false;
      });
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 10, 10, 10),
      // backgroundColor: const Color(0xFFF7FAFC),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: SizedBox(
            width: 300,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'images/login/LogoReconocimientoFacialBlanco.png',
                    width: 100,
                    height: 100,
                    color: Colors.green ,
                  ),
                  const SizedBox(height: 16.0),
                  const Text(
                    "Bienvenido a SENAuthenticator ",
                    style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  const SizedBox(height: 16.0),
                  const Text(
                    "Iniciar sesión para continuar..",
                    style: TextStyle(fontSize: 16.0, color: Colors.grey),
                  ),
                  const SizedBox(height: 30),
                  TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: 'Digita Email',
                      labelStyle: const TextStyle(color: Colors.green),
                      prefixIcon: const Icon(Icons.email, color: Colors.green),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.green),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    style: const TextStyle(color: Colors.white),
                  ),
                  const SizedBox(height: 15),
                  TextField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      labelStyle: const TextStyle(color: Colors.green),
                      prefixIcon: const Icon(Icons.lock, color: Colors.green),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.green),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    style: const TextStyle(color: Colors.white),
                  ),
                  const SizedBox(height: 30.0),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _isloading ? null : _login,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 15.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                      ),
                      child: _isloading
                          ? const CircularProgressIndicator()
                          : const Text("Iniciar sesión"),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  const Text(
                    "O inicie con ",
                    style: TextStyle(color: Colors.white),
                  ),
                  const SizedBox(height: 20.0),
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      "Olvidó su password",
                      style: TextStyle(color: Colors.green),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/registro');
                    },
                    child: const Text(
                      "No tiene una cuenta? Registrarse",
                      style: TextStyle(color: Colors.green),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
