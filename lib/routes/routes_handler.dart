import 'dart:io';

import 'package:sample/main.dart';

class RoutesHandler {
  RoutesHandler._();
  static final RoutesHandler shared = RoutesHandler._();
  final String errorPath = "error";
  void redirectRoute(String path) {
    path = convertPath(path);
    print("Redirect Path - Deep link: " + path);
    try {
      if (path.isNotEmpty) {
        appRouter.pushNamed(
          path,
          includePrefixMatches: true,
          onFailure: (failure) => redirectRoute(path),
        );
      } else {
        appRouter.pushNamed('/');
      }
    } catch (e) {
      print(e);
      redirectToErrorPage();
    }
  }

  void redirectToErrorPage() {
    appRouter.pushNamed(errorPath);
  }

  String convertPath(String path) {
    String convertPath = path.replaceAll('(', '');
    String convertPath2 = convertPath.replaceAll(')', '');
    String convertPath3 = convertPath2.trim();
    return convertPath3;
  }
}
