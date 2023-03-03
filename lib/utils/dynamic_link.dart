import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_branch_sdk/flutter_branch_sdk.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:sample/main.dart';
import 'package:sample/routes/routes_handler.dart';
import 'package:share_plus/share_plus.dart';

class DynamicLinkHandler {
  DynamicLinkHandler._();
  static final DynamicLinkHandler shared = DynamicLinkHandler._();

  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

  BranchContentMetaData metadata = BranchContentMetaData();
  BranchUniversalObject? buo;
  BranchLinkProperties lp = BranchLinkProperties();
  BranchEvent? eventStandart;
  BranchEvent? eventCustom;
  StreamSubscription<Map>? streamSubscription;
  StreamController<String> controllerData = StreamController<String>();
  StreamController<String> controllerInitSession = StreamController<String>();

  void dispose() {
    controllerData.close();
    controllerInitSession.close();
    streamSubscription?.cancel();
  }

  // Initial deeplink
  void initDeepLinkData() {
    // metadata = BranchContentMetaData()
    //   ..addCustomMetadata('path', 'bottomNavBar/settings');
    //--optional Custom Metadata

    buo = BranchUniversalObject(
        canonicalIdentifier: 'flutter/branch',
        //parameter canonicalUrl
        //If your content lives both on the web and in the app, make sure you set its canonical URL
        // (i.e. the URL of this piece of content on the web) when building any BUO.
        // By doing so, we’ll attribute clicks on the links that you generate back to their original web page,
        // even if the user goes to the app instead of your website! This will help your SEO efforts.
        canonicalUrl: 'https://flutter.dev',
        title: 'Flutter Branch Plugin',
        contentDescription: 'Flutter Branch Description',
        contentMetadata: metadata,
        publiclyIndex: true,
        locallyIndex: true,
        expirationDateInMilliSec: DateTime.now()
            .add(const Duration(days: 365))
            .millisecondsSinceEpoch);

    lp = BranchLinkProperties(
      channel: 'facebook',
      feature: 'sharing',
      //parameter alias
      //Instead of our standard encoded short url, you can specify the vanity alias.
      // For example, instead of a random string of characters/integers, you can set the vanity alias as *.app.link/devonaustin.
      // Aliases are enforced to be unique** and immutable per domain, and per link - they cannot be reused unless deleted.
      stage: 'new share',
      campaign: 'campaign',

      //tags: ['one', 'two', 'three'],
    );
  }

  //Listen to dynamic link when user tap on it!
  void listenDynamicLinks() async {
    streamSubscription = FlutterBranchSdk.initSession().listen((data) {
      print('listenDynamicLinks - DeepLink Data: $data');
      controllerData.sink.add((data.toString()));
      if (data.containsKey('+clicked_branch_link') &&
          data['+clicked_branch_link'] == true) {
        final path = data['path'].toString();
        RoutesHandler.shared.redirectRoute(path);
      }
    }, onError: (error) {
      print('InitSesseion error: ${error.toString()}');
    });
  }

  void generateLink(BuildContext context, String path) async {
    BranchResponse response = await FlutterBranchSdk.getShortUrl(
      buo: buo!,
      linkProperties: lp..addControlParam("path", path),
    );

    if (response.success) {
      showGeneratedLink(context, response.result);
    } else {
      showSnackBar(
          message: 'Error : ${response.errorCode} - ${response.errorMessage}');
    }
  }

  void shareLink(BuildContext context, String path) async {
    BranchResponse response = await FlutterBranchSdk.getShortUrl(
      buo: buo!,
      linkProperties: lp..addControlParam("path", path),
    );
    if (response.success) {
      Share.share(response.result);
    } else {
      showSnackBar(
          message: 'Error : ${response.errorCode} - ${response.errorMessage}');
    }
  }

  void showGeneratedLink(BuildContext context, String url) async {
    showModalBottomSheet(
        isDismissible: true,
        isScrollControlled: true,
        context: context,
        builder: (_) {
          return Container(
            padding: const EdgeInsets.all(12),
            height: 500,
            child: Column(
              children: <Widget>[
                const Center(
                    child: Text(
                  'Link created',
                  style: TextStyle(
                      color: Colors.blue, fontWeight: FontWeight.bold),
                )),
                const SizedBox(
                  height: 10,
                ),
                Text(url),
                QrImage(
                  data: url,
                  version: QrVersions.auto,
                  size: 300,
                ),
                const SizedBox(
                  height: 10,
                ),
                IntrinsicWidth(
                  stepWidth: 300,
                  child: CustomButton(
                      onPressed: () async {
                        await Clipboard.setData(ClipboardData(text: url));
                        Navigator.pop(context);
                      },
                      child: const Center(child: Text('Copy link'))),
                ),
                const SizedBox(
                  height: 10,
                ),
                IntrinsicWidth(
                  stepWidth: 300,
                  child: CustomButton(
                      onPressed: () {
                        FlutterBranchSdk.handleDeepLink(url);
                        Navigator.pop(context);
                      },
                      child: const Center(child: Text('Handle deep link'))),
                ),
              ],
            ),
          );
        });
  }

  void showSnackBar({required String message, int duration = 1}) {
    scaffoldMessengerKey.currentState!.removeCurrentSnackBar();
    scaffoldMessengerKey.currentState!.showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: duration),
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  const CustomButton({Key? key, required this.onPressed, required this.child})
      : super(key: key);

  final GestureTapCallback onPressed;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 50,
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 2),
        child: ElevatedButton(
          onPressed: onPressed,
          child: child,
        ));
  }
}

class CustomButton2 extends StatelessWidget {
  const CustomButton2(
      {Key? key,
      required this.onPressed,
      required this.icon,
      required this.iconColor,
      required this.label})
      : super(key: key);
  final Function()? onPressed;
  final Icon icon;
  final Widget label;
  final MaterialStateProperty<Color?>? iconColor;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ButtonStyle(
        backgroundColor:
            MaterialStateProperty.all<Color>(Theme.of(context).primaryColor),
        iconColor: iconColor,
      ),
      onPressed: onPressed,
      icon: icon,
      label: label,
    );
  }
}
