import 'package:flutter/material.dart';
import 'package:reconocimiento_app/services/api_services.dart';

class PaginadeRegistro extends StatefulWidget {
  @override
  _PaginadeRegistroState createState() => _PaginadeRegistroState();
}

class _PaginadeRegistroState extends State<PaginadeRegistro> {
  final _formKey = GlobalKey<FormState>();

  final ApiService apiService = ApiService();

  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _confirmEmailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final TextEditingController _numeroIdentificacionConroller = TextEditingController();

  final FocusNode _nameFocusNode = FocusNode();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _confirmEmailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  final FocusNode _confirmPasswordFocusNode = FocusNode();
  final FocusNode _numeroIdentificacionFocusNode = FocusNode();


  Color _nameTextColor = Colors.grey;
  Color _emailTextColor = Colors.grey;
  Color _confirmEmailTextColor = Colors.grey;
  Color _passwordTextColor = Colors.grey;
  Color _confirmPasswordTextColor = Colors.grey;
  Color _numeroIdentificacionTextColor = Colors.grey;

  String selectedTipoDocumento = 'Cedula de ciudadania';

  bool _isloading = false;

  final List<String> _tiposDocumentos = [
    'Cedula de ciudadania',
    'Tarjeta de Identidad',
    'Cedula de extranjeria',
  ];

  @override
  void initState() {
    super.initState();
    _nameFocusNode.addListener(_onNameFocusChange);
    _emailFocusNode.addListener(_onEmailFocusChange);
    _confirmEmailFocusNode.addListener(_onConfirmEmailFocusChange);
    _passwordFocusNode.addListener(_onPasswordFocusChange);
    _confirmPasswordFocusNode.addListener(_onConfirmPasswordFocusChange);
  }

  @override
  void dispose() {
    _nameFocusNode.dispose();
    _emailFocusNode.dispose();
    _confirmEmailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _confirmPasswordFocusNode.dispose();

    _nombreController.dispose();
    _emailController.dispose();
    _confirmEmailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _onNameFocusChange() {
    setState(() {
      _nameTextColor = _nameFocusNode.hasFocus ? Colors.green : Colors.grey;
    });
  }

  void _onEmailFocusChange() {
    setState(() {
      _emailTextColor = _emailFocusNode.hasFocus ? Colors.green : Colors.grey;
    });
  }

  void _onConfirmEmailFocusChange() {
    setState(() {
      _confirmEmailTextColor =
          _confirmEmailFocusNode.hasFocus ? Colors.green : Colors.grey;
    });
  }

  void _onPasswordFocusChange() {
    setState(() {
      _passwordTextColor =
          _passwordFocusNode.hasFocus ? Colors.green : Colors.grey;
    });
  }

  void _onConfirmPasswordFocusChange() {
    setState(() {
      _confirmPasswordTextColor =
          _confirmPasswordFocusNode.hasFocus ? Colors.green : Colors.grey;
    });
  }

  Future<void> _register() async {
    // if (!_formKey.currentState!.validate()) {
    //   return;
    // }
    final nombre = _nombreController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    final confirmPassword = _confirmPasswordController.text.trim();
    final numeroIdentificacion = _numeroIdentificacionConroller.text.trim();

    // final confirmEmail = _confirmEmailController.text.trim();

    // if (email == confirmPassword) {
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     const SnackBar(content: Text('Los correos electrónicos no coinciden')),
    //   );
    //   return;
    // }

    // if (password == confirmPassword) {
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     const SnackBar(content: Text('Las contraseñas no coinciden')),
    //   );
    //   return;
    // }

    setState(() {
      _isloading = true;
    });

    try {
      final responseData = await apiService.post('usuario/', {
        'nombre': nombre,
        'email': email,
        'password': password,
        'tipo_documento_usuario': selectedTipoDocumento,
        'numero_identificacion_usuario': numeroIdentificacion,
      });
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Registro exitoso')),
      );
      Navigator.pushNamed(context, '/vistaLogin');
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al registrar: $e')),
      );
    } finally {
      setState(() {
        _isloading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 10, 10, 10),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: SizedBox(
            width: 300,
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'images/login/LogoReconocimientoFacialBlanco.png',
                      width: 100,
                      height: 100,
                      color: Colors.green,
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
                      "Regístrate para continuar..",
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 30),
                    TextFormField(
                      focusNode: _nameFocusNode,
                      controller: _nombreController,
                      decoration: InputDecoration(
                        labelText: 'Nombre',
                        labelStyle: TextStyle(color: _nameTextColor),
                        prefixIcon: Icon(Icons.person, color: _nameTextColor),
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
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, ingrese su nombre';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 15),
                    TextFormField(
                      focusNode: _emailFocusNode,
                      controller: _emailController,
                      decoration: InputDecoration(
                        labelText: 'Correo Electronico',
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
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, ingrese su correo electrónico';
                        }
                        final emailRegex =
                            RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                        if (!emailRegex.hasMatch(value)) {
                          return 'Por favor, ingrese un correo electrónico válido';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 15),

                    TextFormField(
                      focusNode: _confirmEmailFocusNode,
                      controller: _confirmEmailController,
                      decoration: InputDecoration(
                        labelText: 'Confirmar Correo',
                        labelStyle: TextStyle(color: _confirmEmailTextColor),
                        prefixIcon:
                            Icon(Icons.email, color: _confirmEmailTextColor),
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
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, confirme su correo electrónico';
                        }
                        if (value != _emailController.text) {
                          print(_emailController.text);
                          return 'Los correos electrónicos no coinciden, por favor verifique $_emailController.text';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 15),

                    DropdownButtonFormField<String>(
                      value: selectedTipoDocumento,
                      decoration: InputDecoration(
                        labelText: 'Tipo de Documento',
                        labelStyle: const TextStyle(color: Colors.grey),
                        prefixIcon:const Icon(Icons.document_scanner, color: Colors.grey),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.green),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        filled: true,
                        fillColor: const Color.fromARGB(255, 20, 20, 20),
                      ),
                      dropdownColor: const Color.fromARGB(255, 20, 20, 20),
                      items: _tiposDocumentos.map((String tipo) {
                        return DropdownMenuItem(
                          value: tipo,
                          child: Text(tipo),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedTipoDocumento = newValue!;
                        });
                      },
                      style: TextStyle(color: Colors.grey),
                    ),

                    const SizedBox(height: 15),
                    
                    TextFormField(
                      focusNode: _numeroIdentificacionFocusNode,
                      controller: _numeroIdentificacionConroller,
                      decoration: InputDecoration(
                        labelText: 'Numero de Identificacion',
                        labelStyle: TextStyle(color: _numeroIdentificacionTextColor),
                        prefixIcon: Icon(Icons.person, color: _numeroIdentificacionTextColor),
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
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, Identificacion';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 15),

                    TextFormField(
                      focusNode: _passwordFocusNode,
                      controller: _passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Contraseña',
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
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, ingrese su contraseña';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 15),

                    TextFormField(
                      focusNode: _confirmPasswordFocusNode,
                      controller: _confirmPasswordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Confirmar Contraseña',
                        labelStyle: TextStyle(color: _confirmPasswordTextColor),
                        prefixIcon:
                            Icon(Icons.lock, color: _confirmPasswordTextColor),
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
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, confirme su contraseña';
                        }
                        if (value != _passwordController.text) {
                          print(_passwordController.text);

                          return 'Las contraseñas no coinciden, por favor verifique ${_passwordController.text}';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 15),
                    const SizedBox(height: 30.0),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _isloading ? null : _register,
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
                            : const Text("Registrarse"),
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "¿Tienes una cuenta?",
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
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}




// import 'package:flutter/material.dart';
// import 'package:reconocimiento_app/controllers/users.dart';

// class PaginadeRegistro extends StatefulWidget {
//   const PaginadeRegistro({super.key});

//   @override
//   State<PaginadeRegistro> createState() => _PaginadeRegistroState();
// }

// class _PaginadeRegistroState extends State<PaginadeRegistro> {
//   final _formKey = GlobalKey<FormState>();
//   final TextEditingController _nombreController = TextEditingController();
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();

//   void _clearControllers() {
//     _nombreController.clear();
//     _emailController.clear();
//     _passwordController.clear();
//   }

//   void _navigateToLogin() {
//     Navigator.pushNamed(context, '/inicio');
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color.fromARGB(255, 10, 10, 10),
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: SingleChildScrollView(
//             child: Form(
//                 key: _formKey,
//                 child: Column(
//                   children: [
//                     Image.asset(
//                       'images/login/LogoReconocimientoFacialBlanco.png',
//                       width: 100,
//                       height: 100,
//                     ),
//                     const SizedBox(height: 16.0),
//                     const Text(
//                       "Crear una nueva cuenta",
//                       style: TextStyle(
//                           fontSize: 24.0,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.white),
//                     ),
//                     const SizedBox(height: 24.0),
//                     TextFormField(
//                       controller: _nombreController,
//                       decoration: InputDecoration(
//                         labelText: "Nombre completo",
//                         labelStyle: const TextStyle(color: Colors.green),
//                         prefixIcon: const Icon(Icons.person_3_rounded, color: Colors.green),
//                         focusedBorder: OutlineInputBorder(
//                           borderSide: const BorderSide(color: Colors.green),
//                           borderRadius: BorderRadius.circular(8.0),
//                         ),
//                         enabledBorder: OutlineInputBorder(
//                           borderSide: const BorderSide(color: Colors.grey),
//                           borderRadius: BorderRadius.circular(8.0),
//                         ),
//                       ),
//                       style: const TextStyle(color: Colors.white),
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return "Ingrese nombre completo";
//                         }
//                         return null;
//                       },
//                     ),
//                     const SizedBox(height: 12.0),
//                     TextField(
//                       controller: _emailController,
//                       decoration: InputDecoration(
//                         labelText: "Email",
//                         labelStyle: const TextStyle(color: Colors.green),
//                         prefixIcon: const Icon(Icons.email_sharp, color: Colors.green),
//                         focusedBorder: OutlineInputBorder(
//                           borderSide: const BorderSide(color: Colors.green),
//                           borderRadius: BorderRadius.circular(8.0),
//                         ),
//                         enabledBorder: OutlineInputBorder(
//                           borderSide: const BorderSide(color: Colors.grey),
//                           borderRadius: BorderRadius.circular(8.0),
//                         ),
//                       ),
//                       style: const TextStyle(color: Colors.white),
//                     ),
//                     const SizedBox(height: 12.0),
//                     TextField(
//                       controller: _passwordController,
//                       decoration: InputDecoration(
//                         labelText: "Password",
//                         labelStyle: const TextStyle(color: Colors.green),
//                         prefixIcon: const Icon(Icons.lock, color: Colors.green),
//                         focusedBorder: OutlineInputBorder(
//                           borderSide: const BorderSide(color: Colors.green),
//                           borderRadius: BorderRadius.circular(8.0),
//                         ),
//                         enabledBorder: OutlineInputBorder(
//                           borderSide: const BorderSide(color: Colors.grey),
//                           borderRadius: BorderRadius.circular(8.0),
//                         ),
//                       ),
//                       style: const TextStyle(color: Colors.white),
//                     ),
//                     const SizedBox(height: 12.0),
//                     TextField(
//                       decoration: InputDecoration(
//                         labelText: "Confirmar Password",
//                         labelStyle: const TextStyle(color: Colors.green),
//                         prefixIcon: const Icon(Icons.lock, color: Colors.green),
//                         focusedBorder: OutlineInputBorder(
//                           borderSide: const BorderSide(color: Colors.green),
//                           borderRadius: BorderRadius.circular(8.0),
//                         ),
//                         enabledBorder: OutlineInputBorder(
//                           borderSide: const BorderSide(color: Colors.grey),
//                           borderRadius: BorderRadius.circular(8.0),
//                         ),
//                       ),
//                       style: const TextStyle(color: Colors.white),
//                     ),
//                     const SizedBox(height: 24.0),
//                     SizedBox(
//                       width: double.infinity,
//                       height: 50.0,
//                       child: ElevatedButton(
//                         onPressed: () {
//                           if (_formKey.currentState!.validate()) {
//                             setState(
//                               () {
//                                 if (_formKey.currentState?.validate() ?? false) {
//                                   setState(() {
//                                     createUsers(
//                                       _nombreController.text,
//                                       _emailController.text,
//                                       _passwordController.text,
//                                     );
//                                   });
//                                 }
//                               },
//                             );
//                             ScaffoldMessenger.of(context).showSnackBar(
//                               const SnackBar(
//                                   content: Text('Registro exitoso')),
//                             );
//                             _clearControllers();
//                             _navigateToLogin();
//                           }
//                         },
//                         style: ElevatedButton.styleFrom(
//                             backgroundColor: Colors.green,
//                             foregroundColor: Colors.white,
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(8.0),
//                             )),
//                         child: const Text("Registrarse"),
//                       ),
//                     ),
//                     const SizedBox(height: 16.0),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         const Text(
//                           "Tienes una cuenta?",
//                           style: TextStyle(color: Colors.white),
//                         ),
//                         TextButton(
//                           onPressed: () {
//                             Navigator.pushNamed(context, '/vistaLogin');
//                           },
//                           child: const Text(
//                             "Iniciar sesión",
//                             style: TextStyle(color: Colors.green),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 )),
//           ),
//         ),
//       ),
//     );
//   }
// }