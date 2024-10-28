import 'package:dio/dio.dart';

const _baseUrl = 'http://167.71.7.159/api/tasky/';

// global variable
final Dio dio = Dio(BaseOptions(baseUrl: _baseUrl));
