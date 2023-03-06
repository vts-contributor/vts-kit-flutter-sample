import 'package:sample/main.dart';

class RoutesHandler {
  RoutesHandler._();
  static final RoutesHandler shared = RoutesHandler._();
  final String errorPath = "error";
  void redirectRoute(String path) {
    print("Redirect Path - Deep link: " + path);
    try {
      if (path.isNotEmpty) {
        appRouter.pushNamed(
          path,
          includePrefixMatches: true,
          onFailure: (failure) {
            redirectToErrorPage();
          },
        );
      } else {
        appRouter.pushNamed('/');
      }
    } on Exception catch (exception) {
      print(exception);
      redirectToErrorPage();
    }
  }

  void redirectToErrorPage() {
    appRouter.pushNamed(errorPath);
  }
}
