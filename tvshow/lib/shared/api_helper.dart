import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:tvshow/config/config.dart';
import 'package:tvshow/shared/response_server.dart';

class ApiHelper {
  late Dio _dio;

  ApiHelper(Dio dio) {
    _dio = dio;
    _dio.interceptors.add(PrettyDioLogger(
      request: true,
      requestBody: true,
      requestHeader: true,
      responseBody: true,
    ));
  }
  Future<dynamic> request(String method, String path,
      {required String contentType,
      Map<String, dynamic>? queryParams,
      dynamic content}) async {
    late Response responseJson;

    var _data = content;

    try {
      if (method == 'POST') {
        responseJson =
            await _dio.post(path, data: _data, queryParameters: queryParams);
      } else if (method == 'PUT') {
        responseJson =
            await _dio.put(path, data: _data, queryParameters: queryParams);
      } else if (method == 'DELETE') {
        responseJson = await _dio.delete(path, queryParameters: queryParams);
      } else if (method == 'PATCH') {
        responseJson =
            await _dio.patch(path, queryParameters: queryParams, data: _data);
      } else {
        responseJson = await _dio.get(path,
            queryParameters: queryParams,
            options: Options(contentType: contentType));
      }

      if (responseJson.statusCode! >= 200 && responseJson.statusCode! <= 300) {
        return ResponseServer(
            data: responseJson.data,
            header: responseJson.headers,
            statusCode: responseJson.statusCode);
      }
    } on DioError catch (e) {
      throw e;
    }
  }
}
