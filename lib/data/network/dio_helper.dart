import 'package:bookia_118/data/local/shared_keys.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'end_points.dart';

class DioHelper {
  static final Dio _dio = Dio(
    BaseOptions(
      baseUrl: EndPoints.baseUrl,
      receiveDataWhenStatusError: true,
    ),
  );

  static const FlutterSecureStorage storage =  FlutterSecureStorage();

  static Future<Response> get({
    required endPoint,
    Map<String, dynamic>? params,
    Map<String, dynamic>? body,
    Map<String ,dynamic>? headers ,
    bool? withToken = false ,
  }) async {
    try {
      // this step because some endpoints needs the token ⤵
      if(withToken ?? false) {
        String? token = await storage.read(key: SharedKeys.token) ;
        _dio.options.headers.addAll({
          "Authorization" : "Bearer $token"
        });
      }
      _dio.options.headers.addAll(headers ?? {}) ;
      return await _dio.get(
        endPoint,
        queryParameters: params,
        data: body,
      );
    } catch (e) {
      rethrow;
    }
  }



  static Future<Response> post({
    required endPoint,
    Map<String, dynamic>? params,
    Map<String, dynamic>? body,
    Map<String ,dynamic>? headers ,
    bool? withToken = false ,
  }) async {
    try {
      if(withToken ?? false) {
        String? token = await storage.read(key: SharedKeys.token) ;
        _dio.options.headers.addAll({
          "Authorization" : "Bearer $token"
        });
      }
      _dio.options.headers.addAll(headers ?? {}) ;
      return await _dio.post(
        endPoint,
        queryParameters: params,
        data: body,
      );
    } catch (e) {
      rethrow;
    }
  }





  static Future<Response> put({
    required endPoint,
    Map<String, dynamic>? params,
    Map<String, dynamic>? body,
    Map<String ,dynamic>? headers ,
    bool? withToken = false ,
  }) async {
    try {
      if(withToken ?? false) {
        String? token = await storage.read(key: SharedKeys.token) ;
        _dio.options.headers.addAll({
          "Authorization" : "Bearer $token"
        });
      }
      _dio.options.headers.addAll(headers ?? {}) ;
      return await _dio.put(
        endPoint,
        queryParameters: params,
        data: body,
      );
    } catch (e) {
      rethrow;
    }
  }



  static Future<Response> patch({
    required endPoint,
    Map<String, dynamic>? params,
    Map<String, dynamic>? body,
    Map<String ,dynamic>? headers ,
    bool? withToken = false ,
  }) async {
    try {
      if(withToken ?? false) {
        String? token = await storage.read(key: SharedKeys.token) ;
        _dio.options.headers.addAll({
          "Authorization" : "Bearer $token"
        });
      }
      _dio.options.headers.addAll(headers ?? {}) ;
      return await _dio.patch(
        endPoint,
        queryParameters: params,
        data: body,
      );
    } catch (e) {
      rethrow;
    }
  }


  static Future<Response> delete({
    required endPoint,
    Map<String, dynamic>? params,
    Map<String, dynamic>? body,
    Map<String ,dynamic>? headers ,
    bool? withToken = false ,
  }) async {
    try {
      if(withToken ?? false) {
        String? token = await storage.read(key: SharedKeys.token) ;
        _dio.options.headers.addAll({
          "Authorization" : "Bearer $token"
        });
      }
      _dio.options.headers.addAll(headers ?? {}) ;
      return await _dio.delete(
        endPoint,
        queryParameters: params,
        data: body,
      );
    } catch (e) {
      rethrow;
    }
  }







}
