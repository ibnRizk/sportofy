import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/foundation.dart';

import '../../injection_container.dart';
import '../error/exceptions.dart';
import '../utils/extension.dart';
import '../utils/log_utils.dart';
import 'status_code.dart';

abstract class DioConsumer {
  Future<dynamic> get(String path, {Map<String, dynamic>? queryParameters});

  Future<dynamic> post(
    String path, {
    FormData? formData,
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParameters,
  });

  Future<dynamic> put(
    String path, {
    FormData? formData,
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParameters,
  });

  Future<dynamic> delete(String path, {Map<String, dynamic>? queryParameters});

  void updateCountryIdParameter(int countryId);

  void updateLanguageCodeHeader();
  void updateDeviceTokenHeader();
  void updateDeviceTypeHeader();
}

abstract class ApiConstants {
  static const String live = 'https://api.sub.seedsflow.net';
  static const String dev = 'https://sub.seedsflow.net/dev';
  static const String staging = 'https://canshopp.com';
  static const String baseUrl = staging;
  static const String portal = 'portal';
  static const String doctors = 'doctors';
  static const String version = 'v1';
}

class DioConsumerImpl implements DioConsumer {
  final Dio client;

  DioConsumerImpl({required this.client}) {
    (client.httpClientAdapter as IOHttpClientAdapter).createHttpClient = () {
      final client = HttpClient();
      // client.findProxy = (uri) {
      // Proxy all request to localhost:8888.
      // Be aware, the proxy should went through you running device,
      // not the host platform.
      //   return 'PROXY https://doctor-app-production.up.railway.app';
      // };

      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };

    Map<String, String> header = {
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.acceptLanguageHeader:
          sharedPreferences.getLanguageCode().name,
      'device-lang': sharedPreferences.getLanguageCode().name,
      'device-token': '',
      'device-type': '',
    };

    client.options
      ..baseUrl = ApiConstants.baseUrl
      //..responseType = ResponseType.plain
      ..contentType = 'application/json'
      ..queryParameters = {
        // 'country_id': '${sharedPreferences.getCountryId() ?? 1}',
      }
      ..headers = header;
    client.interceptors.add(appInterceptors);
    if (kDebugMode) {
      client.interceptors.add(logInterceptor);
    }
  }

  Future<void> _handleAccessTokenHeader() async {
    final String? accessToken = await secureStorage.getAccessToken();
    if (accessToken != null && accessToken.isNotEmpty) {
      client.options.headers[HttpHeaders.authorizationHeader] =
          'Bearer $accessToken';
    } else {
      client.options.headers.remove(HttpHeaders.authorizationHeader);
    }
  }

  @override
  void updateCountryIdParameter(int countryId) {
    client.options.queryParameters['country_id'] = countryId.toString();
  }

  @override
  void updateLanguageCodeHeader() {
    client.options.headers[HttpHeaders.acceptLanguageHeader] =
        sharedPreferences.getLanguageCode().name;
    client.options.headers['device-lang'] =
        sharedPreferences.getLanguageCode().name;
  }

  @override
  void updateDeviceTokenHeader() {
    client.options.headers['device-token'] = tokenFCM;
  }

  @override
  void updateDeviceTypeHeader() {
    client.options.headers['device-type'] =
        Platform.isAndroid ? 'android' : 'ios';
  }

  @override
  Future get(String path, {Map<String, dynamic>? queryParameters}) async {
    try {
      Log.i('[GET][$path], params: ${queryParameters.toString()}');
      await _handleAccessTokenHeader();
      updateLanguageCodeHeader();
      final response = await client.get(path, queryParameters: queryParameters);
      Log.i('[GET][$path], response: ${response.data.toString()}');
      return response.data;
    } on SocketException {
      throw InternetConnectionException(message: 'No internet connection');
    } on DioException catch (error) {
      _handleDioError(error);
    } catch (error) {
      throw ServerException(message: error.toString());
    }
  }

  @override
  Future post(
    String path, {
    FormData? formData,
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      Log.i(
          '[POST][$path], formData: ${formData?.toPrint}, body: ${body.toString()}, params: ${queryParameters.toString()}');
      await _handleAccessTokenHeader();
      updateLanguageCodeHeader();
      final response = await client.post(
        path,
        queryParameters: queryParameters,
        data: formData ?? body,
      );
      Log.i('[POST][$path], response: ${response.data.toString()}');
      return response.data;
    } on SocketException {
      throw InternetConnectionException(message: 'No internet connection');
    } on DioException catch (error) {
      _handleDioError(error);
    } catch (error) {
      throw ServerException(message: error.toString());
    }
  }

  @override
  Future put(
    String path, {
    FormData? formData,
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      Log.i(
          '[PUT][$path], formData: ${formData?.toPrint}, body: ${body.toString()}, params: ${queryParameters.toString()}');
      await _handleAccessTokenHeader();
      final response = await client.put(
        path,
        queryParameters: queryParameters,
        data: formData ?? body,
      );
      Log.i('[PUT][$path], response: ${response.data.toString()}');
      return response.data;
    } on SocketException {
      throw InternetConnectionException(message: 'No internet connection');
    } on DioException catch (error) {
      _handleDioError(error);
    } catch (error) {
      throw ServerException(message: error.toString());
    }
  }

  @override
  Future delete(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      await _handleAccessTokenHeader();
      final response = await client.delete(
        path,
        queryParameters: queryParameters,
      );
      Log.i('[DELETE][$path], response: ${response.data.toString()}');
      return response.data;
    } on SocketException {
      throw InternetConnectionException(message: 'No internet connection');
    } on DioException catch (error) {
      _handleDioError(error);
    } catch (error) {
      throw ServerException(message: error.toString());
    }
  }

  void _handleDioError(DioException error) {
    if (error.response?.statusCode == StatusCode.unauthorized) {
      throw UnauthorizedException(
        message:
            error.response?.data['message'] ?? error.response?.data.toString(),
      );
    }
    if (error.response?.statusCode == StatusCode.updateRegisterApprovedUser) {
      throw UpdateRegisterApprovedUserException(
        message:
            error.response?.data['message'] ?? error.response?.data.toString(),
      );
    }
    if (error.type == DioExceptionType.unknown) {
      throw InternetConnectionException(message: 'No internet connection');
    }
    throw ServerException(
      message:
          error.response?.data['message'] ?? error.response?.data.toString(),
    );
  }
}
