class ResponseServer {
  final dynamic data;
  final dynamic header;
  final dynamic statusCode;

  ResponseServer({this.data, this.header, this.statusCode});

  @override
  String toString() {
    return 'headers : $header\ncontent : \nstatusCode : $statusCode';
  }
}
