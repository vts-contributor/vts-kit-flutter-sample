part of 'network.dart';

InterceptorsWrapper get interceptors =>
    InterceptorsWrapper(onRequest: onRequestHandle, onError: onErrorHandle);

void onRequestHandle(
    RequestOptions options, RequestInterceptorHandler handler) {
  //Truong hop headers chua co content type thi mac dinh la json
  if (!options.headers.containsKey(Headers.contentTypeHeader)) {
    options.headers[Headers.contentTypeHeader] = Headers.jsonContentType;
  }
  //Token sau khi dang nhap duoc cache trong Profile
  options.headers['authorization'] = '${Profile.token?.type} ${Profile.token?.access}';
  handler.next(options);
}

void onErrorHandle(DioError error, ErrorInterceptorHandler handler) async {
  final response = error.response;
  if (response != null) {
    //TODO handle 403 refresh token
    //TODO handle server response error (http status not success)
  }
  handler.next(error);
}
