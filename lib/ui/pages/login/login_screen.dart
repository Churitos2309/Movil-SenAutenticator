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
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  
  Color _emailTextColor = Colors.grey;
  Color _passwordTextColor = Colors.grey;
  
  bool _isloading = false;

  @override
  void initState() {
    super.initState();
    _emailFocusNode.addListener(_onEmailFocusChange);
    _passwordFocusNode.addListener(_onPasswordFocusChange);
  }

  @override
  void dispose() {
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onEmailFocusChange() {
    setState(() {
      _emailTextColor = _emailFocusNode.hasFocus ? Colors.green : Colors.grey;
    });
  }

  void _onPasswordFocusChange() {
    setState(() {
      _passwordTextColor = _passwordFocusNode.hasFocus ? Colors.green : Colors.grey;
    });
  }

  Future<void> _login() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();


    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (email.isEmpty && password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Por favor, ingrese un correo electrónico y contraseña"),
      ));
      return;
    } else if (!emailRegex.hasMatch(email)) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Por favor, ingrese un correo electrónico válido"),
      ));
      return;
    } else if (password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Por favor, ingrese la contraseña"),
      ));
      return;
    } else if (email.isEmpty || password.isEmpty) {
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
          "email": email,
          "password": password,
        }),
      );

      if (!mounted) return;

      if (responselogin.statusCode == 200) {
        final jsonData = jsonDecode(responselogin.body);
        print('Respuesta de la API: $jsonData');

        final user = jsonData['user'];
        final nombre = user != null ? user['nombre'] : null;
        print('Nombre extraido: $nombre');

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Bienvenido $nombre"),
        ));
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
                    focusNode: _emailFocusNode,
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: 'Digita Email',
                      labelStyle: TextStyle(color: _emailTextColor),
                      prefixIcon: Icon(Icons.email, color: _emailTextColor),
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
                    focusNode: _passwordFocusNode,
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      labelStyle: TextStyle(color: _passwordTextColor),
                      prefixIcon: Icon(Icons.lock, color: _passwordTextColor),
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
                      "Olvidó su contraseña?",
                      style: TextStyle(color: Colors.grey),
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