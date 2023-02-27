import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_core/extensions/extensions.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:sample/constants/colors.dart';
import 'package:sample/helper/helper.dart';
import 'package:sample/pages/login/login_controller.dart';
import 'package:sample/routes/routes.gr.dart';
import 'package:sample/theme/theme.dart';
import 'package:sample/theme/theme_getx_controller.dart';
import 'package:sample/widgets/default_button.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  GlobalKey<_LoginScreenState> loginKey = GlobalKey();
  GlobalKey<FormState> _signInKeyForm = GlobalKey();

  TextEditingController _emailController = new TextEditingController();

  TextEditingController _passwordController = TextEditingController();

  late final LoginController _loginController =
      LoginController(viewKey: loginKey);
  final imagePath = "assets/images/viettel_logo.png";
  final ThemeGetX themeGetX = Get.find<ThemeGetX>(tag: ThemeGetX.tag);
  late StreamSubscription<bool> keyboardSubscription;
  bool _showPass = true;
  bool _visibleKeyboard = false;
  bool _loginTap = false;
  bool _switchValue = false;
  String message = "";
  int? segmentedControlGroupValue = 0;
  ///////////////////////

  @override
  initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);
    keyboardSubscription =
        KeyboardVisibilityController().onChange.listen((isVisible) {
      _visibleKeyboard = isVisible;
    });

    _loginController.initState();
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
    print(context.router.currentPath);
    return KeyboardDismisser(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
            maintainBottomViewPadding: true,
            child: SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: SingleChildScrollView(
                  reverse: true,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          changeThemeBtn(context),
                          changeLanguageBtn(context),
                        ],
                      ),
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
                      const SizedBox(height: 10),
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
                      const SizedBox(height: 20),
                      DefaultButton(
                          text:
                              AppLocalizations.of(context)!.logIn.toUpperCase(),
                          width: double.infinity,
                          press: () {
                            context.router.replaceAll([const BottomNavBar()]);
                          }),
                      const SizedBox(height: 10),
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
        imagePath,
        fit: BoxFit.fitWidth,
        height: 150,
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
              color: Theme.of(context).primaryColor,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Helpers.shared.textFieldPassword(context,
              controllerText: _passwordController,
              hint: AppLocalizations.of(context)!.password,
              prefixIcon: Icon(
                Icons.key,
                color: Theme.of(context).primaryColor,
              ),
              suffixIcon: InkWell(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: _showPass
                      ? Icon(
                          Icons.visibility,
                          color: Theme.of(context).primaryColor,
                        )
                      : Icon(Icons.visibility_off,
                          color: Theme.of(context).primaryColor),
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

  Widget changeLanguageBtn(BuildContext context) {
    return Obx(() {
      String language =
          _loginController.languageGetX.localeGetx.value.toString();
      if (language == "vi") {
        segmentedControlGroupValue = 0;
      } else {
        segmentedControlGroupValue = 1;
      }
      return CupertinoSlidingSegmentedControl(
        backgroundColor: AppColors.colorDADCE6,
        thumbColor: Theme.of(context).primaryColor,
        groupValue: segmentedControlGroupValue,
        children: {
          0: Text(
            "Tiếng Việt",
            style: TextStyle(
                color: segmentedControlGroupValue == 1
                    ? Colors.black
                    : Colors.white,
                fontWeight: FontWeight.w500),
          ),
          1: Text(
            "English",
            style: TextStyle(
                color: segmentedControlGroupValue == 1
                    ? Colors.white
                    : Colors.black,
                fontWeight: FontWeight.w500),
          ),
        },
        onValueChanged: (i) async {
          segmentedControlGroupValue = i;

          if (segmentedControlGroupValue == 0) {
            _loginController.languageGetX.localeGetx.value = const Locale('vi');
            _loginController.saveCacheToDisk();
          } else if (segmentedControlGroupValue == 1) {
            _loginController.languageGetX.localeGetx.value = const Locale('en');
            _loginController.saveCacheToDisk();
          }
        },
      );
    });
  }

  Widget changeThemeBtn(BuildContext context) {
    return Obx(
      () {
        ThemeData? theme = themeGetX.themeGetx.value;
        if (theme.isNotNull) {
          if (theme == primaryTheme) {
            _switchValue = true;
          } else if (theme == secondaryTheme) {
            _switchValue = false;
          }
        } else {
          _switchValue = true;
        }
        return CupertinoSwitch(
          activeColor: AppColors.kPrimaryColor,
          //thumbColor: CupertinoColors.activeOrange,
          trackColor: AppColors.color1f89de,
          value: _switchValue,
          onChanged: (value) async {
            setState(() {
              _switchValue = value;
            });
            if (value == true) {
              themeGetX.themeGetx.value = primaryTheme;
              _loginController.toggleSelectTheme("primary_theme");
            } else {
              themeGetX.themeGetx.value = secondaryTheme;
              _loginController.toggleSelectTheme("secondary_theme");
            }
          },
        );
      },
    );
  }
}
