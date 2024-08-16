import 'package:flutter/material.dart';
import 'package:reconocimiento_app/controllers/users.dart';

class PaginadeRegistro extends StatefulWidget {
  const PaginadeRegistro({super.key});

  @override
  State<PaginadeRegistro> createState() => _PaginadeRegistroState();
}

class _PaginadeRegistroState extends State<PaginadeRegistro> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _clearControllers() {
    _nombreController.clear();
    _emailController.clear();
    _passwordController.clear();
  }

  void _navigateToLogin() {
    Navigator.pushNamed(context, '/inicio');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 10, 10, 10),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Image.asset(
                      'images/login/LogoReconocimientoFacialBlanco.png',
                      width: 100,
                      height: 100,
                    ),
                    const SizedBox(height: 16.0),
                    const Text(
                      "Crear una nueva cuenta",
                      style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    const SizedBox(height: 24.0),
                    TextFormField(
                      controller: _nombreController,
                      decoration: InputDecoration(
                        labelText: "Nombre completo",
                        labelStyle: const TextStyle(color: Colors.green),
                        prefixIcon: const Icon(Icons.person_3_rounded, color: Colors.green),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.green),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      style: const TextStyle(color: Colors.white),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Ingrese nombre completo";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 12.0),
                    TextField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        labelText: "Email",
                        labelStyle: const TextStyle(color: Colors.green),
                        prefixIcon: const Icon(Icons.email_sharp, color: Colors.green),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.green),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      style: const TextStyle(color: Colors.white),
                    ),
                    const SizedBox(height: 12.0),
                    TextField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                        labelText: "Password",
                        labelStyle: const TextStyle(color: Colors.green),
                        prefixIcon: const Icon(Icons.lock, color: Colors.green),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.green),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      style: const TextStyle(color: Colors.white),
                    ),
                    const SizedBox(height: 12.0),
                    TextField(
                      decoration: InputDecoration(
                        labelText: "Confirmar Password",
                        labelStyle: const TextStyle(color: Colors.green),
                        prefixIcon: const Icon(Icons.lock, color: Colors.green),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.green),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      style: const TextStyle(color: Colors.white),
                    ),
                    const SizedBox(height: 24.0),
                    SizedBox(
                      width: double.infinity,
                      height: 50.0,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            setState(
                              () {
                                if (_formKey.currentState?.validate() ?? false) {
                                  setState(() {
                                    createUsers(
                                      _nombreController.text,
                                      _emailController.text,
                                      _passwordController.text,
                                    );
                                  });
                                }
                              },
                            );
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Registro exitoso')),
                            );
                            _clearControllers();
                            _navigateToLogin();
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            )),
                        child: const Text("Registrarse"),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Tienes una cuenta?",
                          style: TextStyle(color: Colors.white),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/vistaLogin');
                          },
                          child: const Text(
                            "Iniciar sesión",
                            style: TextStyle(color: Colors.green),
                          ),
                        ),
                      ],
                    ),
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
