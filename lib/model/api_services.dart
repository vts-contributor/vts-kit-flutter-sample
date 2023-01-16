import 'package:sample/network/response_json.dart';
import 'package:sample/network/network.dart';
import 'package:dio/dio.dart';

class ApiServices {
  static String baseHost = "http://domain";

  static AppResponseJson jsonParser(Response response) =>
      AppResponseJson.fromResponse(response);

//TODO define function to get data, use get/post from network
}
