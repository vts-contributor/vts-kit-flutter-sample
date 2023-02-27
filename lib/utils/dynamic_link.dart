import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_branch_sdk/flutter_branch_sdk.dart';
import 'package:sample/main.dart';
import 'package:sample/pages/notifications/notification_service.dart';
import 'package:sample/routes/routes.gr.dart';

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
  static const imageURL =
      'https://raw.githubusercontent.com/RodrigoSMarques/flutter_branch_sdk/master/assets/branch_logo_qrcode.jpeg';

  void dispose() {
    controllerData.close();
    controllerInitSession.close();
    streamSubscription?.cancel();
  }

  // Initial deeplink
  void initDeepLinkData() {
    metadata = BranchContentMetaData()
      ..addCustomMetadata('custom_string', 'hello from other side!!!!');
    // ..addCustomMetadata('custom_number', 12345)
    // ..addCustomMetadata('custom_bool', true)
    // ..addCustomMetadata('custom_list_number', [1, 2, 3, 4, 5])
    // ..addCustomMetadata('custom_list_string', ['a', 'b', 'c'])
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
        //imageUrl: imageURL,
        contentDescription: 'Flutter Branch Description',
        /*
        contentMetadata: BranchContentMetaData()
          ..addCustomMetadata('custom_string', 'abc')
          ..addCustomMetadata('custom_number', 12345)
          ..addCustomMetadata('custom_bool', true)
          ..addCustomMetadata('custom_list_number', [1, 2, 3, 4, 5])
          ..addCustomMetadata('custom_list_string', ['a', 'b', 'c']),
         */
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
      //alias: 'https://branch.io' //define link url,
      stage: 'new share',
      campaign: 'campaign',
      //tags: ['one', 'two', 'three'],
    );
    // ..addControlParam('\$uri_redirect_mode', '1')
    // ..addControlParam('\$ios_nativelink', true)
    // ..addControlParam('\$match_duration', 7200)
    // ..addControlParam('\$always_deeplink', true)
    // ..addControlParam('\$android_redirect_timeout', 750)
    // ..addControlParam('referring_user_id', 'user_id');

    // eventStandart = BranchEvent.standardEvent(BranchStandardEvent.ADD_TO_CART)
    //   //--optional Event data
    //   ..transactionID = '12344555'
    //   ..currency = BranchCurrencyType.BRL
    //   ..revenue = 1.5
    //   ..shipping = 10.2
    //   ..tax = 12.3
    //   ..coupon = 'test_coupon'
    //   ..affiliation = 'test_affiliation'
    //   ..eventDescription = 'Event_description'
    //   ..searchQuery = 'item 123'
    //   ..adType = BranchEventAdType.BANNER
    //   ..addCustomData(
    //       'Custom_Event_Property_Key1', 'Custom_Event_Property_val1')
    //   ..addCustomData(
    //       'Custom_Event_Property_Key2', 'Custom_Event_Property_val2');

    // eventCustom = BranchEvent.customEvent('Custom_event')
    //   ..addCustomData(
    //       'Custom_Event_Property_Key1', 'Custom_Event_Property_val1')
    //   ..addCustomData(
    //       'Custom_Event_Property_Key2', 'Custom_Event_Property_val2');
  }

  //Listen to dynamic link when user tap on it!
  void listenDynamicLinks() async {
    streamSubscription = FlutterBranchSdk.initSession().listen((data) {
      print('listenDynamicLinks - DeepLink Data: $data');
      controllerData.sink.add((data.toString()));
      if (data.containsKey('+clicked_branch_link') &&
          data['+clicked_branch_link'] == true) {
        if (data['path'] != null) {
          appRouter.navigateNamed(data['path']);
        }
      }
    }, onError: (error) {
      print('InitSesseion error: ${error.toString()}');
    });
  }

  void generateLink(BuildContext context) async {
    BranchResponse response = await FlutterBranchSdk.getShortUrl(
      buo: buo!,
      linkProperties: lp,
    );
    if (response.success) {
      showGeneratedLink(context, response.result);
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
            height: 200,
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
