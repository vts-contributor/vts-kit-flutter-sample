import 'package:dio/dio.dart';
import 'package:flutter_core/network/response_json.dart';

class AppResponseJson extends JsonResponse {
  AppResponseJson({content, errorCode, errorMessage})
      : super(
            content: content, errorCode: errorCode, errorMessage: errorMessage);

  factory AppResponseJson.fromResponse(Response response){
    AppResponseJson responseJson = AppResponseJson();
    //TODO parse json
    return responseJson;
  }
}
