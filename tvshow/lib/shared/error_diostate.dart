import 'package:dio/dio.dart';

dynamic errorDioState(DioError e) {
  String messageDefault = 'Koneksi Terputus.\nSilahkan coba beberapa saat lagi';

  switch (e.type) {
    case DioErrorType.connectTimeout:
    case DioErrorType.sendTimeout:
    case DioErrorType.receiveTimeout:
      return e.response?.statusMessage ?? messageDefault;

    case DioErrorType.response:
      if (e.response?.statusCode == 404) {
        String? _message = '';
        if (e.response?.statusMessage == null) {
          _message = 'Not Found';
        } else {
          _message = e.response?.statusMessage;
        }
        return _message;
      }
      if (e.response?.statusCode == 502) {
        return 'forbiden access';
      }
      if (e.response?.statusCode == 500) {
        return e.response?.statusMessage ?? 'Internal Server Error';
      }
      if (e.response?.statusCode == 401) {
        return 'Session Expired';
      }
      if (e.response?.statusCode == 413) {
        return e.response?.statusMessage ?? "";
      }
      if (e.response?.statusCode == 400) {
        if (e.response?.data['messages'] != null) {
          if (e.response?.data['messages']['error'] != null) {
            return e.response?.data['messages']['error'];
          } else {
            return e.response?.data['messages'] != null
                ? e.response?.data['messages']
                : "400 Bad Request";
          }
        } else {
          return "400 Bad Request";
        }
      }

      return messageDefault;
    case DioErrorType.cancel:
      return 'Cancel';
    case DioErrorType.other:
      return 'Maaf, sedang mengalami gangguan ';
  }
}
