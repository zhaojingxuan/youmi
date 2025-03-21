import 'package:dio/dio.dart';
import 'package:youmi/http/model/base_model.dart';
import 'package:oktoast/oktoast.dart';

class ResponseInterceptor extends Interceptor {
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // TODO: implement onResponse
    // super.onResponse(response, handler);
    if (response.statusCode == 200) {
      try {
        var rsp = BaseModel.fromJson(response.data);
        if (rsp.code == 1) {
          if (rsp.data == null) {
            handler.next(
                Response(requestOptions: response.requestOptions, data: true));
          } else {
            handler.next(Response(
                requestOptions: response.requestOptions, data: rsp.data));
          }
        } else if (response.statusCode == 1001) {
          handler.reject(DioException(
              requestOptions: response.requestOptions, message: "未登录"));
          showToast("请先登录");
        } else {
          showToast(rsp.message ?? '网络错误');
        }
      } catch (e) {
        handler.reject(DioException(
            requestOptions: response.requestOptions, message: "$e"));
      }
    } else {
      handler.reject(DioException(requestOptions: response.requestOptions));
      // showToast('${response.statusCode}:${response.statusMessage}');
    }
  }
}
