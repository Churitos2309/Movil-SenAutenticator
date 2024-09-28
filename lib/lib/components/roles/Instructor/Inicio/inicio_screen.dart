import 'package:flutter/material.dart';
import 'dart:math'; // Para seleccionar aleatoriamente
import 'package:reconocimiento_app/services/api_services.dart';
import '../Reportes/Fichas_Instructor/Usuarios_aprendiz/Usuarios.dart';

class InicioScreen extends StatefulWidget {
  const InicioScreen({super.key});

  @override
  State<InicioScreen> createState() => _InicioScreenState();
}

class _InicioScreenState extends State<InicioScreen> {
  final ApiService apiService = ApiService();
  List<dynamic> fichas = [];

  // @override
  // void initState() {
  //   super.initState();
  //   fetchFichas();
  // }

  // // Función para obtener fichas de la API
  // void fetchFichas() async {
  //   try {
  //     final data = await apiService.get('fichas/');
  //     setState(() {
  //       fichas = data;
  //     });
  //   } catch (e) {
  //     print('Error obteniendo fichas: $e');
  //   }
  // }

  // Función para obtener datos aleatorios de la API
  Map<String, dynamic> obtenerDatosAleatorios() {
    final random = Random();
    if (fichas.isNotEmpty) {
      final fichaAleatoria = fichas[random.nextInt(fichas.length)];
      return {
        'numero_ficha': fichaAleatoria['numero_ficha'] ?? 'No disponible',
        'jornada_ficha': fichaAleatoria['jornada_ficha'] ?? 'No disponible',
        'aprendices_actuales_ficha':
            fichaAleatoria['aprendices_actuales_ficha']?.toString() ?? 'No disponible',
        'ficha_id': fichaAleatoria['id'], // Agregamos ficha_id para navegar
      };
    } else {
      return {
        'numero_ficha': 'Cargando...',
        'jornada_ficha': 'Cargando...',
        'aprendices_actuales_ficha': 'Cargando...',
        'ficha_id': null, // Sin ficha disponible
      };
    }
  }

  @override
  Widget build(BuildContext context) {
    // Llama a obtenerDatosAleatorios para los 3 campos
    final datosCampo1 = obtenerDatosAleatorios();
    final datosCampo2 = obtenerDatosAleatorios();
    final datosCampo3 = obtenerDatosAleatorios();

    return Scaffold(
      backgroundColor: Colors.grey[100], // Fondo más claro
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(defaultPadding),
        child: Column(
          children: [
            // Campo 1
            _buildField(
              title: datosCampo1['numero_ficha'],
              description: datosCampo1['jornada_ficha'],
              buttonText: datosCampo1['aprendices_actuales_ficha'],
              onPressed: () {
                // Navegación a UsuariosScreen
                if (datosCampo1['ficha_id'] != null) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UsuariosScreen(
                        fichaId: datosCampo1['ficha_id'],
                        numeroFicha: datosCampo1['numero_ficha'],
                      ),
                    ),
                  );
                }
              },
              imagePath: 'images/login/sena-cauca.jpg', // Imagen de fondo
            ),
            SizedBox(height: defaultPadding), // Espacio entre campos

            // Campo 2
            _buildField(
              title: datosCampo2['numero_ficha'],
              description: datosCampo2['jornada_ficha'],
              buttonText: datosCampo2['aprendices_actuales_ficha'],
              onPressed: () {
                // Navegación a UsuariosScreen
                if (datosCampo2['ficha_id'] != null) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UsuariosScreen(
                        fichaId: datosCampo2['ficha_id'],
                        numeroFicha: datosCampo2['numero_ficha'],
                      ),
                    ),
                  );
                }
              },
              imagePath: 'images/login/SENA1.jpg', // Imagen de fondo
            ),
            SizedBox(height: defaultPadding), // Espacio entre campos

            // Campo 3
            _buildField(
              title: datosCampo3['numero_ficha'],
              description: datosCampo3['jornada_ficha'],
              buttonText: datosCampo3['aprendices_actuales_ficha'],
              onPressed: () {
                // Navegación a UsuariosScreen
                if (datosCampo3['ficha_id'] != null) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UsuariosScreen(
                        fichaId: datosCampo3['ficha_id'],
                        numeroFicha: datosCampo3['numero_ficha'],
                      ),
                    ),
                  );
                }
              },
              imagePath: 'images/login/SENACAUCA.jpg', // Imagen de fondo
            ),
          ],
        ),
      ),
    );
  }

  // Widget para crear un campo con título, descripción y botón
  Widget _buildField({
    required String title,
    required String description,
    required String buttonText,
    required VoidCallback onPressed,
    required String imagePath,
  }) {
    return SizedBox(
      width: double.infinity, // Ancho igual al del contenedor padre
      height: 220.0, // Alto un poco más grande para darle espacio al contenido
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(imagePath), // Ruta de la imagen de fondo
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.3), // Opacidad ligera para mantener la visibilidad de la imagen
                  BlendMode.darken,
                ),
              ),
              borderRadius: BorderRadius.circular(20.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  spreadRadius: 3,
                  blurRadius: 8,
                  offset: Offset(0, 6), // Sombra suave y más dispersa
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(defaultPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Fondo degradado para el título
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.black.withOpacity(0.7), Colors.transparent],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white, // Contraste con el fondo
                    ),
                  ),
                ),
                SizedBox(height: 10.0), // Espacio entre el título y la descripción

                // Fondo degradado para la descripción
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 10.0),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.black.withOpacity(0.6), Colors.transparent],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Text(
                    description,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
                Spacer(), // Empuja el botón hacia abajo

                // Botón con un estilo más moderno
                ElevatedButton(
                  onPressed: onPressed,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white.withOpacity(0.9), // Fondo semitransparente
                    padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0),
                    elevation: 8, // Efecto de elevación más pronunciado
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0), // Bordes más redondeados
                    ),
                  ),
                  child: Text(
                    buttonText,
                    style: TextStyle(
                      color: Colors.black87, // Texto más oscuro para contraste con el botón
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

const defaultPadding = 16.0;
