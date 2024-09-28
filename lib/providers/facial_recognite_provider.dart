import 'dart:io';

import 'package:flutter/material.dart';
import 'package:reconocimiento_app/services/api_services.dart';

class FacialRecognitionProvider with ChangeNotifier {
  final ApiService _apiService;
  bool _isLoading = false;

  FacialRecognitionProvider(this._apiService);

  bool get isLoading => _isLoading;

  Future<void> registerFace({
    required String nombreCompleto,
    required String numeroDocumento,
    required File faceImage,
  }) async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await _apiService.registerFace(
        nombreCompleto: nombreCompleto,
        numeroDocumento: numeroDocumento,
        faceImage: faceImage,
      );
      print('Registro exitoso: $response');
    } catch (e) {
      print('Error en el registro facial: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}