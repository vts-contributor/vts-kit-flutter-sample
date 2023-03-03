import 'package:sample/main.dart';
import 'package:sample/routes/routes.gr.dart';

class RoutesHandler {
  RoutesHandler._();
  static final RoutesHandler shared = RoutesHandler._();
  final String errorPath = "error";
  void redirectRoute(String path) {
    try {
      appRouter.pushNamed(
        path,
        includePrefixMatches: true,
        onFailure: (failure) {
          redirectToErrorPage();
        },
      );
    } on Exception catch (exception) {
      print(exception);
      redirectToErrorPage();
    }
  }

  void redirectToErrorPage() {
    appRouter.pushNamed(errorPath);
  }
}
