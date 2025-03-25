import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';

///网络请求与返回信息打印拦截器
class PrintLogInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    debugPrint("\nrequest-------------->");
    options.headers.forEach((key, value) {
      debugPrint("请求头信息：$key : ${value.toString()}");
    });
    debugPrint("path:${options.uri}");
    debugPrint("method:${options.method}");
    try {
      debugPrint("data:${jsonEncode(options.data)}");
    } catch (e) {
      debugPrint("data:${options.data}");
    }

    debugPrint("queryParameters:${options.queryParameters.toString()}");
    debugPrint("<--------------request\n");
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    debugPrint("\nresponse-------------->");
    debugPrint("path:${response.realUri}");
    debugPrint("headers:${response.headers.toString()}");
    debugPrint("statusMessage:${response.statusMessage}");
    debugPrint("statusCode:${response.statusCode}");
    debugPrint("extra:${response.extra.toString()}");
    try {
      debugPrint("data:${jsonEncode(response.data)}");
    } catch (e) {
      debugPrint("data:${response.data}");
    }
    debugPrint("<--------------response\n");
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    debugPrint("\nonError-------------->");
    debugPrint("error:${err.toString()}");
    debugPrint("<--------------onError\n");
    showToast("error:${err.toString()}");
    super.onError(err, handler);
  }
}
