import 'package:flutter/material.dart';
import 'package:sample/pages/errors/components/app_bar_error.dart';
import 'package:sample/pages/errors/components/bottom_button.dart';
import 'package:sample/pages/errors/components/fade_animation.dart';
import 'package:sample/pages/errors/components/my_lottie_widget.dart';
import 'package:sample/pages/errors/components/top_two_text_error.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ErrorPage extends StatefulWidget {
  const ErrorPage({super.key});

  @override
  State<ErrorPage> createState() => _ErrorPageState();
}

class _ErrorPageState extends State<ErrorPage> {
  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    var size = MediaQuery.of(context).size;
    var leftPadding = 15.0;
    return Scaffold(
      appBar: const ErrorAppBar(),
      body: Container(
        margin: const EdgeInsets.all(10),
        width: size.width,
        height: size.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// 404 TEXT - PAGE NOT FOUND TEXT
            Padding(
              padding: EdgeInsets.only(left: leftPadding),
              child: TopTwoTextError(
                textTheme: textTheme,
              ),
            ),

            /// LOTTIE
            Align(
              alignment: Alignment.center,
              child: FadeAnimation(
                delay: 1.5,
                child: GestureDetector(
                  onTap: () {
                    // Navigator.pushReplacement(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => const SecondScreen()));
                  },
                  child: MyLottie(
                    size: size,
                    picNum: '1',
                  ),
                ),
              ),
            ),

            /// BOTTOM TEXT
            Padding(
              padding: EdgeInsets.only(left: leftPadding, top: 30),
              child: FadeAnimation(
                delay: 1,
                child: Text(
                  AppLocalizations.of(context)!.errorText,
                  style: textTheme.headlineSmall,
                ),
              ),
            ),

            ///
            Expanded(child: Container()),

            /// Go HOME BUTTON
            // Padding(
            //   padding: const EdgeInsets.only(bottom: 10),
            //   child: FadeAnimation(
            //     delay: 0.5,
            //     child: Align(
            //       alignment: Alignment.bottomCenter,
            //       child: BottomButton(
            //         size: size,
            //         textTheme: textTheme.headline5,
            //         btnColor: Theme.of(context).primaryColor,
            //         page: const FirstScreen(),
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
