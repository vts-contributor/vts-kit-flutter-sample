import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:sample/utils/dynamic_link.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  final _dynamicLinkHandler = DynamicLinkHandler.shared;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print(context.router.currentPath);
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 50,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: CustomButton(
                        onPressed: () =>
                            _dynamicLinkHandler.generateLink(context),
                        child: const Text('Generate Link',
                            textAlign: TextAlign.center),
                      ),
                    ),
                    // Expanded(
                    //   child: CustomButton(
                    //     onPressed: () => _dynamicLinkHandler.generateQrCode(context),
                    //     child: const Text('Generate QrCode',
                    //         textAlign: TextAlign.center),
                    //   ),
                    // ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
