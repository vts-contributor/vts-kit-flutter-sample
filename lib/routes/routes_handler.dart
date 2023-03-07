import 'package:sample/main.dart';

class RoutesHandler {
  RoutesHandler._();
  static final RoutesHandler shared = RoutesHandler._();
  final String errorPath = "error";
  void redirectRoute(String path) {
    print("Redirect Path - Deep link: " + path);
    try {
      if (path.isNotEmpty) {
        appRouter.navigateNamed(
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
}
