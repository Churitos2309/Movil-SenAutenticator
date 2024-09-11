import 'dart:convert';
import 'package:http/http.dart' as http;

class Objeto {
  final String id;
  final String marcaObjeto;
  final String modeloObjeto;
  final String descripcionObjeto;
  final String fotoObjeto; // URL de la foto
  final String usuarioObjetoId; // ID del usuario

  const Objeto({
    required this.id,
    required this.marcaObjeto,
    required this.modeloObjeto,
    required this.descripcionObjeto,
    required this.fotoObjeto,
    required this.usuarioObjetoId,
  });

  factory Objeto.fromJson(Map<String, dynamic> json) {
    return Objeto(
      id: json['_id'],
      marcaObjeto: json['marca_objeto'],
      modeloObjeto: json['modelo_objeto'],
      descripcionObjeto: json['descripcion_objeto'],
      fotoObjeto: json['foto_objeto'],
      usuarioObjetoId: json['usuario_objeto'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'marca_objeto': marcaObjeto,
      'modelo_objeto': modeloObjeto,
      'descripcion_objeto': descripcionObjeto,
      'foto_objeto': fotoObjeto,
      'usuario_objeto': usuarioObjetoId,
    };
  }
  
  // Constructor vacío para cuando sea necesario
  Objeto.empty()
      : id = '',
        marcaObjeto = '',
        modeloObjeto = '',
        descripcionObjeto = '',
        fotoObjeto = '',
        usuarioObjetoId = '';
}

Future<List<Objeto>> obtenerObjetos() async {
  try {
    final response = await http.get(
        Uri.parse('https://api-nodejs-mongodb-2j7b.onrender.com/api/objeto'));
    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      final objetos = body.map((objeto) => Objeto.fromJson(objeto)).toList();
      return objetos;
    } else {
      throw Exception('Error al cargar objetos: ${response.statusCode}');
    }
  } catch (e) {
    throw Exception('Error al obtener objetos: $e');
  }
}

Future<Objeto> crearObjeto(
    String marcaObjeto, String modeloObjeto, String descripcionObjeto, String fotoObjeto, String usuarioObjetoId) async {
  try {
    final response = await http.post(
        Uri.parse('https://api-nodejs-mongodb-2j7b.onrender.com/api/objeto'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: jsonEncode(<String, String>{
          'marca_objeto': marcaObjeto,
          'modelo_objeto': modeloObjeto,
          'descripcion_objeto': descripcionObjeto,
          'foto_objeto': fotoObjeto,
          'usuario_objeto': usuarioObjetoId,
        }));
    if (response.statusCode == 201 || response.statusCode == 200) {
      return Objeto.fromJson(
          jsonDecode(response.body) as Map<String, dynamic>);
    } else {
      throw Exception('No ha sido posible crear el objeto: ${response.statusCode}');
    }
  } catch (e) {
    throw Exception('Error al crear objeto: $e');
  }
}

Future<Objeto> actualizarObjeto(String id, String marcaObjeto, String modeloObjeto, String descripcionObjeto, String fotoObjeto, String usuarioObjetoId) async {
  try {
    final response = await http.put(
        Uri.parse('https://api-nodejs-mongodb-2j7b.onrender.com/api/objeto/$id'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: jsonEncode(<String, String>{
          'marca_objeto': marcaObjeto,
          'modelo_objeto': modeloObjeto,
          'descripcion_objeto': descripcionObjeto,
          'foto_objeto': fotoObjeto,
          'usuario_objeto': usuarioObjetoId,
        }));
    if (response.statusCode == 201 || response.statusCode == 200) {
      return Objeto.fromJson(
          jsonDecode(response.body) as Map<String, dynamic>);
    } else {
      throw Exception('No ha sido posible actualizar el objeto: ${response.statusCode}');
    }
  } catch (e) {
    throw Exception('Error al actualizar objeto: $e');
  }
}

Future<Objeto> eliminarObjeto(String id) async {
  try {
    final response = await http.delete(
      Uri.parse('https://api-nodejs-mongodb-2j7b.onrender.com/api/objeto/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      return Objeto.empty();
    } else {
      throw Exception('Error al eliminar el objeto: ${response.statusCode}');
    }
  } catch (e) {
    throw Exception('Error al eliminar objeto: $e');
  }
}
