import 'package:flutter/material.dart';
import 'package:flutter_core/difference_screens/difference_screens.dart';
import 'package:flutter_core/bases/bases.dart';
import 'package:flutter_core/extensions/extensions.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app.dart';
import 'home.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with AdaptivePage {
  late final HomeGetx _getx;

  @override
  void initState() {
    _getx = Get.find(tag: HomeGetx.tag);
    super.initState();
    _getx.getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Flutter Demo")),
      body: adaptiveBody(context),
    );
  }

  @override
  Widget landscapeBody(BuildContext context, Size size) {
    return Center(
      child: Wrap(
        children: [
          const Text("Landscape "),
          dataObx(context),
        ],
      ),
    );
  }

  @override
  Widget portraitBody(BuildContext context, Size size) {
    return Center(
      child: Wrap(
        children: [
          const Text("Portrait "),
          dataObx(context),
        ],
      ),
    );
  }

  @override
  Widget tabletLandscapeBody(BuildContext context, Size size) {
    // optional
    return landscapeBody(context, size);
  }

  @override
  Widget tabletPortraitBody(BuildContext context, Size size) {
    // optional
    return portraitBody(context, size);
  }

  Widget dataObx(BuildContext context) {
    //TODO define messages in app_en.arb, app_vi.arb and run 'flutter gen-l10n'
    AppLocalizations? appLocalizations = AppLocalizations.of(context);
    return Obx(() {
      final result = _getx.dataObx.value;
      Widget widget;
      switch (result.status) {
        case Status.INIT:
          widget = Container();
          break;
        case Status.LOADING:
          //TODO get loading message from appLocalizations or loading icon
          //Example appLocalizations?.hello
          widget = const Text('LOADING');
          break;
        case Status.SUCCEED:
          widget = Text('${result.data}');
          break;
        case Status.EMPTY:
          //TODO get empty message from appLocalizations
          widget = const Text('EMPTY');
          break;
        case Status.FAILED:
          final String errorMessage =
              result.error?.parseMultiLanguage(context).toString() ?? 'Error';
          widget = Text(errorMessage);
          break;
      }
      return widget;
    });
  }
}
