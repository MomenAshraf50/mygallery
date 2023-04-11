import 'package:dio/dio.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import '/core/error/exceptions.dart';
import '/core/network/remote/api_endpoints.dart';

abstract class DioHelper {
  Future<dynamic> post({
    String? base,
    required String url,
    dynamic data,
    dynamic query,
    String? token,
    ProgressCallback? progressCallback,
    CancelToken? cancelToken,
    int? timeOut,
    bool isMultipart = false,
  });

  Future<dynamic> get({
    String? base,
    required String url,
    dynamic data,
    dynamic query,
    String? token,
    CancelToken? cancelToken,
    int? timeOut,
    bool isMultipart = false,
  });



}

class DioImpl extends DioHelper {
  final Dio dio = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      receiveDataWhenStatusError: true,
      connectTimeout: const Duration(milliseconds: 20000),
    ),
  );

  @override
  Future post({
    String? base,
    required String url,
    dynamic data,
    dynamic query,
    String? token,
    ProgressCallback? progressCallback,
    CancelToken? cancelToken,
    int? timeOut,
    bool isMultipart = false,
  }) async {
    if (timeOut != null) {
      dio.options.connectTimeout = Duration(milliseconds: timeOut);
    }

    if (base != null) {
      dio.options.baseUrl = base;
    } else {
      dio.options.baseUrl = baseUrl;
    }

    dio.options.headers = {
      if (isMultipart) 'Content-Type': 'multipart/form-data',
      if (!isMultipart) 'Content-Type': 'application/json',
      if (!isMultipart) 'Accept': 'application/json',
      'Accept-Language': 'en',
      if (token != null)
        'Authorization': 'Bearer $token'
    };
    dio.options.extra = {
      'Token': token
    };

    if (url.contains('??')) {
      url = url.replaceAll('??', '?');
    }

    debugPrint('URL => ${dio.options.baseUrl + url}');
    debugPrint('Header => ${dio.options.headers.toString()}');
    debugPrint('Body => $data');
    debugPrint('Query => $query');

    return await request(
      () async => await dio.post(
        url,
        data: data,
        queryParameters: query,
        onSendProgress: progressCallback,
        cancelToken: cancelToken,
        // onSendProgress: (int count, int total) {
        //   debugPrint(total.toString());
        //   debugPrint(count.toString());
        // },
      ),
    );
  }

  @override
  Future get({
    String? base,
    required String url,
    dynamic data,
    dynamic query,
    String? token,
    CancelToken? cancelToken,
    int? timeOut,
    bool isMultipart = false,
  }) async {
    if (timeOut != null) {
      dio.options.connectTimeout = Duration(milliseconds: timeOut);
    }

    if (base != null) {
      dio.options.baseUrl = base;
    } else {
      dio.options.baseUrl = baseUrl;
    }
    dio.options.headers = {
      if (isMultipart) 'Content-Type': 'multipart/form-data',
      if (!isMultipart) 'Content-Type': 'application/json',
      if (!isMultipart) 'Accept': 'application/json',
      'Accept-Language': 'en',
      if (token != null)
        'Authorization': 'Bearer $token'
    };

    if (url.contains('??')) {
      url = url.replaceAll('??', '?');
    }

    debugPrint('URL => ${dio.options.baseUrl + url}');
    debugPrint('Header => ${dio.options.headers.toString()}');
    debugPrint('Body => $data');
    debugPrint('Query => $query');

    return await request(
      () async => await dio.get(
        url,
        queryParameters: query,
        cancelToken: cancelToken,
      ),
    );
  }




}

extension on DioHelper {
  Future request(Future<Response> Function() request) async {
    try {
      final r = await request.call();
      debugPrint("Response => ${r.data}");
      return r;
    } on DioError catch (e) {
      debugPrint("Error Message => ${e.message}");
      debugPrint("Error => ${e.error.toString()}");

      if (e.response != null) {
        debugPrint("Error Response => ${e.response}");
        debugPrint("Error Response Message => ${e.response!.statusMessage}");
        debugPrint("Error Response Status Code => ${e.response!.statusCode}");
        debugPrint("Error Response Data => ${e.response!.data}");

        if (e.response!.data is Map &&
            e.response!.data.toString().isNotEmpty &&
            e.response!.data['Response'] != null) {
          debugPrint(
              "Error Response Data Message => ${e.response!.data['Response']}");
        }

        throw ServerException(
          // error: e.response!.statusMessage!,
          // code: e.response!.statusCode!,
          message: e.response!.data['Response'],
          // e.response!.data is Map && e.response!.data.toString().isNotEmpty
          //     ? e.response!.data['Response'] ?? e.response!.statusMessage
          //     : e.response!.data,
        );
      } else {
        throw ServerException(
          // error: e.error.toString(),
          // code: 500,
          message: e.message!,
        );
      }
    } catch (e) {
      throw Exception();
    }
  }
}
