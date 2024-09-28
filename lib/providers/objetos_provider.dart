import 'package:flutter/material.dart';
import 'package:reconocimiento_app/services/api_services.dart';

class ObjetosProvider with ChangeNotifier {
  final ApiService _apiService;
  List<dynamic> _objetos = [];
  bool _isLoading = false;

  ObjetosProvider(this._apiService);

  List<dynamic> get objetos => _objetos;
  bool get isLoading => _isLoading;

  Future<void> fetchObjetos() async {
    _isLoading = true;
    notifyListeners();

    try {
      _objetos = await _apiService.fetchObjetos();
    } catch (e) {
      print('Error al obtener objetos: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> createObjeto(Map<String, dynamic> data) async {
    _isLoading = true;
    notifyListeners();

    try {
      await _apiService.createObjeto(data);
      await fetchObjetos(); // Actualizar la lista de objetos
    } catch (e) {
      print('Error al crear objeto: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Otros métodos para actualizar y eliminar objetos
}