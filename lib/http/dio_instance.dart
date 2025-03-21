import 'package:dio/dio.dart';
import 'package:youmi/global/global_info.dart';
import 'package:youmi/http/http_method.dart';
import 'package:youmi/http/interceptor/print_log_interceptor.dart';
import 'package:youmi/http/interceptor/rsp_interceptor.dart';

class DioInstance {
  static DioInstance? _instance;
  DioInstance._();
  static DioInstance instance() {
    return _instance ??= DioInstance._();
  }

  final _dio = Dio();
  final _defaultTime = Duration(seconds: 30);

  void initDio({
    required String baseUrl,
    String? httpMethod = HttpMethod.GET,
    Duration? connectTimeout,
    Duration? receiveTimeout,
    Duration? sendTimeout,
    ResponseType? responseType = ResponseType.json,
    String? contentType,
  }) {
    _dio.options = BaseOptions(
      method: httpMethod,
      baseUrl: baseUrl,
      connectTimeout: connectTimeout ?? _defaultTime,
      receiveTimeout: receiveTimeout ?? _defaultTime,
      sendTimeout: sendTimeout ?? _defaultTime,
      responseType: responseType,
      contentType: contentType,
    );
    _dio.interceptors.add(PrintLogInterceptor());
    _dio.interceptors.add(ResponseInterceptor());
  }

  Future<Response> get(
      {required String path,
      Map<String, dynamic>? param,
      Options? options,
      CancelToken? cancelToken}) async {
    return _dio.get(path,
        queryParameters: param,
        options: options ??
            Options(
              method: HttpMethod.GET,
              receiveTimeout: _defaultTime,
              sendTimeout: _defaultTime,
              headers: {
                "Accept-Language": GlobalInfo.info.getLanguageCode(),
                "token": GlobalInfo.info.getToken(),
                "device-brand": GlobalInfo.info.getDeviceBrand(),
              },
            ),
        cancelToken: cancelToken);
  }

  Future<Response> post(
      {required String path,
      Object? data,
      Map<String, dynamic>? queryParameters,
      Options? options,
      CancelToken? cancelToken}) async {
    return _dio.post(
      path,
      queryParameters: queryParameters,
      data: data,
      cancelToken: cancelToken,
      options: options ??
          Options(
            method: HttpMethod.POST,
            receiveTimeout: _defaultTime,
            sendTimeout: _defaultTime,
            headers: {
              "Accept-Language": GlobalInfo.info.getLanguageCode(),
              "token": GlobalInfo.info.getToken(),
              "device-brand": GlobalInfo.info.getDeviceBrand(),
            },
          ),
    );
  }
}
