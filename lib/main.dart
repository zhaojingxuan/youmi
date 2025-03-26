import 'package:flutter/material.dart';
import 'package:youmi/http/dio_instance.dart';
import 'package:youmi/youmi_app.dart';

void main() {
  // DioInstance.instance().initDio(baseUrl: "http://youmi.clipdrama.com/");
  DioInstance.instance().initDio(baseUrl: "https://testapi.clipdrama.com/");
  // DioInstance.instance().initDio(baseUrl: "https://api.clipdrama.com/");
  runApp(const YoumiApp());
}
