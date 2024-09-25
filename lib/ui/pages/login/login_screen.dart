import 'dart:math';

import 'package:flutter/material.dart';
import 'package:particles_flutter/component/particle/particle.dart';
import 'package:particles_flutter/particles_engine.dart';
import 'package:reconocimiento_app/services/api_services.dart';

class LoginScreen extends StatefulWidget {
  final ApiService apiService;

  LoginScreen({Key? key, required this.apiService}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final FocusNode _numeroIdentificacionFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  final TextEditingController _numeroIdentificacionController =
      TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Color _numeroIdentificacionTextColor = Colors.yellow;
  Color _passwordTextColor = Colors.grey;

  bool _isLoading = false;
  List token = [];

  @override
  void initState() {
    super.initState();
    _numeroIdentificacionFocusNode
        .addListener(_onNumeroIdentificacionFocusChange);
    _passwordFocusNode.addListener(_onPasswordFocusChange);
  }

  @override
  void dispose() {
    _numeroIdentificacionFocusNode
        .removeListener(_onNumeroIdentificacionFocusChange);
    _passwordFocusNode.removeListener(_onPasswordFocusChange);
    _numeroIdentificacionFocusNode.dispose();
    _passwordFocusNode.dispose();
    _numeroIdentificacionController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
//   void uploadImage() async {
//   File imageFile = File('/ruta/a/tu/imagen.jpg'); // Ruta a tu archivo de imagen
//   try {
//     var response = await apiService.postWithImage('tu_endpoint', imageFile);
//     print('Respuesta: $response');
//   } catch (e) {
//     print('Error: $e');
//   }
// }

  void _onNumeroIdentificacionFocusChange() {
    setState(() {
      _numeroIdentificacionTextColor =
          _numeroIdentificacionFocusNode.hasFocus ? Colors.green : Colors.grey;
    });
  }

  void _onPasswordFocusChange() {
    setState(() {
      _passwordTextColor =
          _passwordFocusNode.hasFocus ? Colors.green : Colors.grey;
    });
  }

  void _login() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    setState(() {
      _isLoading = true;
    });

    try {
      final responseData = await widget.apiService.post('inicioSesion/', {
        'numero_documento_usuario':
            int.tryParse(_numeroIdentificacionController.text) ?? 0,
        'password': _passwordController.text,
      });

      try {
        // Acceder a getList usando la instancia apiService
        final responseToken = await widget.apiService.getList('validarToken/');
        setState(() {
          token =
              responseToken; // Asegúrate de que estás guardando el valor correcto aquí.
        });
      } catch (e) {
        print('Error Obteniendo Usuarios: $e');
      }

      if (responseData != null) {
        final token = responseData['token'];
        final user = responseData['user'];

        if (token == null) {
          throw Exception('Token no proporcionados por el servidor');
        }
        if (user == null) {
          throw Exception('Usuario no proporcionados por el servidor');
        }
        // Continua con el manejo del login exitoso...
      } else {
        throw Exception('Error: Respuesta vacía del servidor');
      }
    } catch (e) {
      final errorMessage = e is Exception ? e.toString() : 'Error desconocido';
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al iniciar sesión: $errorMessage')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _validarToken(String token) async {
    setState(() {
      _isLoading = true;
    });

    try {
      final responseData =
          await widget.apiService.getWithHeaders('validarToken/', headers: {
        'Authorization': 'Bearer $token',
      });

      if (responseData != null && responseData['status'] == 'success') {
        // Token válido, puedes continuar con el flujo de la app
      } else {
        throw Exception('Token inválido o no autorizado');
      }
    } catch (e) {
      final errorMessage = e is Exception ? e.toString() : 'Error desconocido';
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al validar token: $errorMessage')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: const Color.fromARGB(255, 10, 10, 10),
            child: Particles(
              awayRadius: 100,
              particles: createParticles(),
              height: screenHeight,
              width: screenWidth,
              onTapAnimation: true,
              awayAnimationDuration: const Duration(milliseconds: 500),
              awayAnimationCurve: Curves.easeInOutCirc,
              enableHover: true,
              hoverRadius: 90,
              connectDots: false,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: _isLoading
                  ? const CircularProgressIndicator()
                  // const CardLoading(
                  //     height: 100,
                  //     borderRadius: BorderRadius.all(Radius.circular(10)),
                  //     margin: EdgeInsets.only(bottom: 10),
                  //   )
                  : Card(
                      shadowColor: Colors.green[700],
                      color: const Color.fromARGB(150, 10, 10, 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: SizedBox(
                        width: 300,
                        child: SingleChildScrollView(
                          child: Form(
                            key: _formKey,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Flexible(
                                  fit: FlexFit.loose,
                                  child: Image.asset(
                                    'images/login/LogoReconocimientoFacialBlanco.png',
                                    width: 100,
                                    height: 100,
                                    color: Colors.green,
                                  ),
                                ),
                                const SizedBox(height: 16.0),
                                const Text(
                                  "Bienvenido a SENAuthenticator",
                                  style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                                const SizedBox(height: 16.0),
                                const Text(
                                  "Iniciar sesión para continuar..",
                                  style: TextStyle(
                                      fontSize: 16.0, color: Colors.grey),
                                ),
                                const SizedBox(height: 30),
                                TextFormField(
                                  key: const Key('identificacionInput'),
                                  focusNode: _numeroIdentificacionFocusNode,
                                  controller: _numeroIdentificacionController,
                                  decoration: InputDecoration(
                                    labelText: 'Cédula',
                                    labelStyle: TextStyle(
                                        color: _numeroIdentificacionTextColor),
                                    prefixIcon: Icon(Icons.email,
                                        color: _numeroIdentificacionTextColor),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          const BorderSide(color: Colors.green),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide:
                                          const BorderSide(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                  ),
                                  style: const TextStyle(color: Colors.white),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Por favor, ingrese su numero de cédula';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 15),
                                TextFormField(
                                  key: const Key('passwordInput'),
                                  focusNode: _passwordFocusNode,
                                  controller: _passwordController,
                                  obscureText: true,
                                  decoration: InputDecoration(
                                    labelText: 'Contraseña',
                                    labelStyle:
                                        TextStyle(color: _passwordTextColor),
                                    prefixIcon: Icon(Icons.lock,
                                        color: _passwordTextColor),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          const BorderSide(color: Colors.green),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide:
                                          const BorderSide(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                  ),
                                  style: const TextStyle(color: Colors.white),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Por favor, ingrese su contraseña';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 30.0),
                                SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    onPressed: _isLoading ? null : _login,
                                    style: ElevatedButton.styleFrom(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 15.0),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      backgroundColor: Colors.green,
                                      foregroundColor: Colors.white,
                                    ),
                                    child: _isLoading
                                        ? CircularProgressIndicator(
                                            color: Colors.white,
                                          )
                                        : const Text("Iniciar sesión"),
                                  ),
                                ),
                                const SizedBox(height: 20.0),
                                const Text(
                                  "O inicie con ",
                                  style: TextStyle(color: Colors.white),
                                ),
                                const SizedBox(height: 20.0),
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Text(
                                        "¿No tienes una cuenta?",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pushNamed(
                                              context, '/registro');
                                        },
                                        child: const Text(
                                          "Regístrate",
                                          style: TextStyle(color: Colors.green),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 20.0),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }

  List<Particle> createParticles() {
    var rng = Random();
    List<Particle> particles = [];
    for (int i = 0; i < 50; i++) {
      particles.add(Particle(
        color: Colors.green.withOpacity(0.6),
        size: rng.nextDouble() * 10,
        velocity: Offset(rng.nextDouble() * 50 * randomSign(),
            rng.nextDouble() * 50 * randomSign()),
      ));
    }
    return particles;
  }

  double randomSign() {
    var rng = Random();
    return rng.nextBool() ? 1.0 : -1.0;
  }
}
