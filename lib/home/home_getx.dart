import 'package:get/get.dart';
import 'package:flutter_core/bases/bases.dart';
import 'package:sample/model/model.dart';

class HomeGetx extends GetxController {
  static const tag = 'HomeGetx';
  Rx<RxData<Info>> dataObx = RxData<Info>.init().obs;
  final Repository repo = Repository();

  void getData() async {
    dataObx.value = RxData.loading();
    //TODO get data from repo and remove delayed
    await Future.delayed(const Duration(seconds: 3));
    try {
      // return data
      dataObx.value = RxData.succeed(Info("VTS"));
      // //or return empty
      // dataObx.value = RxData.empty();
      // //or throw socket exception
      // throw const SocketException("assuming no connection");
    } catch (e) {
      dataObx.value = RxData.failed(e);
    }
  }
}
