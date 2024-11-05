import 'package:bookia_118/data/local/shared_keys.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'end_points.dart';

class DioHelper {
// Singleton instance of Dio
  static final Dio _dio = Dio(
    BaseOptions(
      baseUrl: EndPoints.baseUrl,
      receiveDataWhenStatusError: true,
    ),
  )..interceptors.add(PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseHeader: false,
      responseBody: true,
      compact: false,
    )); // Adding logger interceptor here

  static const FlutterSecureStorage storage = FlutterSecureStorage();

  static Future<Response> get({
    required endPoint,
    Map<String, dynamic>? params,
    Map<String, dynamic>? body,
    Map<String, dynamic>? headers,
    bool? withToken = false,
  }) async {
    try {
      await _setTokenIfRequired(withToken);
      // this step because some endpoints needs the token ⤵
      // if (withToken ?? false) {
      //   String? token = await storage.read(key: SharedKeys.token);
      //   _dio.options.headers.addAll({"Authorization": "Bearer $token"});
      // }
      _dio.options.headers.addAll(headers ?? {});
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
    Map<String, dynamic>? headers,
    bool? withToken = false,
  }) async {
    try {
      await _setTokenIfRequired(withToken);
      // if (withToken ?? false) {
      //   String? token = await storage.read(key: SharedKeys.token);
      //   _dio.options.headers.addAll({
      //     "Authorization": "Bearer $token",
      //   });
      // }
      _dio.options.headers.addAll(headers ?? {});
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
    Map<String, dynamic>? headers,
    bool? withToken = false,
  }) async {
    try {
      await _setTokenIfRequired(withToken);
      _dio.options.headers.addAll(headers ?? {});
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
    Map<String, dynamic>? headers,
    bool? withToken = false,
  }) async {
    try {
      await _setTokenIfRequired(withToken);
      _dio.options.headers.addAll(headers ?? {});
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
    Map<String, dynamic>? headers,
    bool? withToken = false,
  }) async {
    try {
      await _setTokenIfRequired(withToken);
      _dio.options.headers.addAll(headers ?? {});
      return await _dio.delete(
        endPoint,
        queryParameters: params,
        data: body,
      );
    } catch (e) {
      rethrow;
    }
  }

  static Future<void> _setTokenIfRequired(bool? withToken) async {
    if (withToken == true) {
      String? token = await storage.read(key: SharedKeys.token);
      _dio.options.headers['Authorization'] = "Bearer $token";
    }
  }
}
