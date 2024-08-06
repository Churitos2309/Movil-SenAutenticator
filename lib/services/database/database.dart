import 'package:mongo_dart/mongo_dart.dart';

class Database {
  static Db? _db;

  static Future<void> init() async {
    var db = await Db.create("mongodb+srv://JuanOchoa:ANA2000JUAN@cluster0.cof4rpm.mongodb.net:27017/puebaFacial?retryWrites=true&w=majority");
    _db = db; // Asignar la instancia de Db a _db
    await _db!.open();
    // ignore: avoid_print
    print('Conectado a la base de datos: ${_db?.isConnected}');
  }

  static Db? get db => _db;
}