import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart';

class ApiService {
  final String baseUrl = 'https://backendsenauthenticator.up.railway.app/api/';
  final Dio _dio = Dio();

  ApiService() {
    _dio.options.baseUrl = baseUrl;
    _dio.options.headers['Content-Type'] = 'application/json';
    _dio.options.validateStatus = (status) {
      return status! <
          500; // Considera errores solo si el código de estado es menor a 500
    };
    _dio.interceptors.add(TokenInterceptor(this));
  }

  void setTokens(String accessToken, String refreshToken) {
    _dio.options.headers['Authorization'] = 'Bearer $accessToken';
  }

  Future<Map<String, dynamic>> post(
      String path, Map<String, dynamic> data) async {
    try {
      final response = await _dio.post(path, data: data);
      if (kDebugMode) {
        print('Response data: ${response.data}');
      }
      return response.data;
    } on DioException catch (e) {
      _handleDioError(e);
    }
    throw Exception('Failed to complete post request');
  }

  // Future<Map<String, dynamic>> post(String path, Map<String, dynamic> data) async {
  //   try {
  //     final response = await _dio.post(path, data: data);
  //     if (kDebugMode) {
  //       print('Response data: ${response.data}');
  //     }
  //     return response.data;
  //   } catch (e) {
  //     if (kDebugMode) {
  //       print('Error: $e');
  //     }
  //     rethrow;
  //   }
  // }
  

  Future<Map<String, dynamic>> uploadProfile(
      Map<String, dynamic> data, File? image) async {
    FormData formData = FormData.fromMap(data);
    if (image != null) {
      formData.files.add(MapEntry(
        'photo',
        await MultipartFile.fromFile(image.path,
            filename: basename(image.path)),
      ));
    }
    final response = await _dio.post('usuarios/', data: formData);
    return response.data;
  }

  Future<Map<String, dynamic>> postRegister(
      String endpoint, Map<String, dynamic> data) async {
    return post(endpoint, data);
  }

  Future<Map<String, dynamic>> registerFace({
    required String nombreCompleto,
    required String numeroDocumento,
    required File faceImage,
  }) async {
    try {
      final formData = FormData.fromMap({
        'nombre_completo': nombreCompleto,
        'numero_documento': numeroDocumento,
        'face_image': await MultipartFile.fromFile(faceImage.path),
      });

      final response = await _dio.post('/register-face/', data: formData);
      return response.data;
    } on DioException catch (e) {
      _handleDioError(e);
    }
    throw Exception('Failed to register face');
  }

  Future<void> createObjeto(Map<String, dynamic> data) async {
    try {
      await _dio.post('/objetos/', data: data);
    } on DioException catch (e) {
      _handleDioError(e);
    }
  }

  Future<List<dynamic>> fetchObjetos() async {
    try {
      final response = await _dio.get('/objetos/');
      return response.data;
    } on DioException catch (e) {
      _handleDioError(e);
    }
    throw Exception('Failed to fetch objetos');
  }
  ///////////////////////////////////////////////////////////////////77
  Future<List<dynamic>> get(String path) async {
  try {
    final response = await _dio.get(path);
    return response.data; // Asegúrate de que response.data sea una lista
  } on DioException catch (e) {
    _handleDioError(e);
  }
  throw Exception('Failed to complete get request');
}



  Future<Map<String, dynamic>> loginFace({required File faceImage}) async {
    try {
      final formData = FormData.fromMap({
        'face_image': await MultipartFile.fromFile(faceImage.path),
      });

      final response = await _dio.post('/login-face/', data: formData);
      return response.data;
    } on DioException catch (e) {
      _handleDioError(e);
    }
    throw Exception('Failed to login face');
  }

  Future<void> refreshToken(String refreshToken) async {
    try {
      final response =
          await _dio.post('/refresh-token/', data: {'refresh': refreshToken});
      if (response.statusCode == 200) {
        final newAccessToken = response.data['access'];
        _dio.options.headers['Authorization'] = 'Bearer $newAccessToken';
      } else {
        throw Exception('Failed to refresh token');
      }
    } on DioException catch (e) {
      _handleDioError(e);
    }
  }

  void _handleDioError(DioException e) {
    if (e.response != null) {
      if (kDebugMode) {
        print('Error: ${e.response?.data}');
      }
      if (kDebugMode) {
        print('Status code: ${e.response?.statusCode}');
      }
    } else {
      if (kDebugMode) {
        print('Error: ${e.message}');
      }
    }
    throw Exception('Failed to complete request: ${e.message}');
  }
}

class TokenInterceptor extends Interceptor {
  final ApiService _apiService;

  TokenInterceptor(this._apiService);

  @override
  Future<void> onError(
      DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401 &&
        err.response?.data['code'] == 'token_not_valid') {
      try {
        await _apiService.refreshToken(
            _apiService._dio.options.headers['Authorization'].split(' ').last);
        final opts = Options(
          method: err.requestOptions.method,
          headers: err.requestOptions.headers,
        );
        final cloneReq = await _apiService._dio.request(
          err.requestOptions.path,
          options: opts,
          data: err.requestOptions.data,
          queryParameters: err.requestOptions.queryParameters,
        );
        return handler.resolve(cloneReq);
      } catch (e) {
        return handler.next(err);
      }
    }
    return handler.next(err);
  }
}
