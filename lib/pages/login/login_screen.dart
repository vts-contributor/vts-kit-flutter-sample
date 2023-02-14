import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:provider/provider.dart';
import 'package:sample/constants/colors.dart';
import 'package:sample/helper/helper.dart';
import 'package:sample/provider/localeProvider.dart';
import 'package:sample/routes/routes.gr.dart';
import 'package:sample/widgets/default_button.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  GlobalKey<FormState> _signInKeyForm = GlobalKey();

  TextEditingController _emailController = new TextEditingController();

  TextEditingController _passwordController = TextEditingController();
  late StreamSubscription<bool> keyboardSubscription;
  bool _showPass = true;
  bool _visibleKeyboard = false;
  bool _loginTap = false;
  String message = "";

  int? segmentedControlGroupValue = 0;
  Future<void> _loadCacheLocalization() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      segmentedControlGroupValue =
          (prefs.getInt('segmentedControlGroupValue') ?? 0);
      if (segmentedControlGroupValue == 0) {
        context.read<LocaleProvider>().setLocale(const Locale("vi"));
      } else {
        context.read<LocaleProvider>().setLocale(const Locale("en"));
      }
    });
  }

  Future<void> _saveCacheLocalization() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.setInt('segmentedControlGroupValue', segmentedControlGroupValue!);
    });
  }

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);

    //NotificationsController.startListeningNotificationEvents();
    _loadCacheLocalization();
    keyboardSubscription =
        KeyboardVisibilityController().onChange.listen((isVisible) {
      _visibleKeyboard = isVisible;
    });
    // FirebaseMessaging.instance.getInitialMessage().then((value) =>
    //     appRouter.push(const BottomNavBar(children: [UsersRouter()])));
  }

  @override
  void dispose() {
    keyboardSubscription.cancel();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardDismisser(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
            maintainBottomViewPadding: true,
            child: SizedBox(
              width: double.infinity,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 20.w,
                ),
                child: SingleChildScrollView(
                  reverse: true,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 20.h,
                      ),
                      CupertinoSlidingSegmentedControl(
                          backgroundColor: AppColors.colorDADCE6,
                          thumbColor: AppColors.kPrimaryColor,
                          groupValue: segmentedControlGroupValue,
                          children: {
                            0: Container(
                              child: Text(
                                "Tiếng Việt",
                                style: TextStyle(
                                    color: segmentedControlGroupValue == 1
                                        ? Colors.black
                                        : Colors.white,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            1: Container(
                              child: Text(
                                "English",
                                style: TextStyle(
                                    color: segmentedControlGroupValue == 1
                                        ? Colors.white
                                        : Colors.black,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          },
                          onValueChanged: (i) async {
                            segmentedControlGroupValue = i;
                            if (segmentedControlGroupValue == 0) {
                              await _saveCacheLocalization();
                              context
                                  .read<LocaleProvider>()
                                  .setLocale(const Locale("vi"));
                            } else if (segmentedControlGroupValue == 1) {
                              await _saveCacheLocalization();
                              context
                                  .read<LocaleProvider>()
                                  .setLocale(const Locale("en"));
                            }
                          }),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 7,
                      ),
                      _visibleKeyboard ? Container() : buildLogo(),
                      loginWithEmail(context),
                      Visibility(
                        visible: _loginTap,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              message,
                              style: TextStyle(
                                  color: AppColors.colorCC0000,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10.h),
                      Container(
                        alignment: Alignment.centerRight,
                        child: InkWell(
                          child: Text(
                            AppLocalizations.of(context)!.forgetPassword,
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: AppColors.color333333),
                          ),
                          onTap: () {
                            context.pushRoute(const EmailFormRouter());
                          },
                        ),
                      ),
                      SizedBox(height: 20.h),
                      DefaultButton(
                          text:
                              AppLocalizations.of(context)!.logIn.toUpperCase(),
                          width: double.infinity,
                          press: () {
                            context.router.replaceAll([const BottomNavBar()]);
                          }),
                      SizedBox(height: 10.h),
                    ],
                  ),
                ),
              ),
            )),
      ),
    );
  }

  Widget buildLogo() {
    return Center(
      child: Image.asset(
        'assets/images/viettel_logo.png',
        fit: BoxFit.fitWidth,
        height: 150.h,
      ),
    );
  }

  Form loginWithEmail(BuildContext context) {
    return Form(
      key: _signInKeyForm,
      child: Column(
        children: [
          Helpers.shared.textFieldEmail(
            context,
            hint: AppLocalizations.of(context)!.email,
            controllerText: _emailController,
            prefixIcon: Icon(
              Icons.mail,
              color: AppColors.colorDD474C,
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          Helpers.shared.textFieldPassword(context,
              controllerText: _passwordController,
              hint: AppLocalizations.of(context)!.password,
              prefixIcon: Icon(
                Icons.key,
                color: AppColors.colorDD474C,
              ),
              suffixIcon: InkWell(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: _showPass
                      ? Icon(
                          Icons.visibility,
                          color: AppColors.colorDD474C,
                        )
                      : Icon(Icons.visibility_off,
                          color: AppColors.colorDD474C),
                ),
                onTap: () {
                  setState(() {
                    _showPass = !_showPass;
                  });
                },
              ),
              obscureText: _showPass),
        ],
      ),
    );
  }
}
