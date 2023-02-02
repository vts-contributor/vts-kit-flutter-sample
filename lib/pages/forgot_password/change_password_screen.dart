import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:sample/constants/colors.dart';
import 'package:sample/constants/pattern_constants.dart';

import 'package:sample/widgets/default_button.dart';
import 'package:sample/widgets/text_field_edit.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  GlobalKey<FormState> _keyForm = GlobalKey();
  TextEditingController _passwordController = new TextEditingController();
  TextEditingController _rePasswordController = new TextEditingController();
  bool _showPass = true;
  bool _showRePass = true;
  bool _check = true;
  @override
  Widget build(BuildContext context) {
    return KeyboardDismisser(
        child: Scaffold(
      body: SafeArea(
          child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
              child: Column(
            children: [
              SizedBox(height: 40.h),
              Text(
                AppLocalizations.of(context)!.resetPassword,
                style: const TextStyle(
                  fontSize: 25,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20.h),
              changePassForm(context),
              SizedBox(height: 20.h),
              DefaultButton(
                width: double.infinity,
                text: AppLocalizations.of(context)!.continueStr.toUpperCase(),
                press: () {
                  if (_keyForm.currentState!.validate() && _check) {
                    setState(() {});
                  }
                },
              ),
            ],
          )),
        ),
      )),
    ));
  }

  Widget textNewPassword(BuildContext context,
      {Function(String?)? onSave,
      TextEditingController? controllerText,
      Function(String?)? onChange,
      Widget? suffixIcon,
      bool? obscureText}) {
    return TextFieldEdit(
      controllerText: _passwordController,
      suffixIcon: suffixIcon,
      textInputAction: TextInputAction.done,
      hint: AppLocalizations.of(context)!.enterNewPassword,
      validatePassword: (value) {
        RegExp regex = RegExp(PatternConstants.patternPassword);
        if (value == null || value.isEmpty) {
          return AppLocalizations.of(context)!.kPassNullError;
        }
        // else if (!regex.hasMatch(value)) {
        //   return kPassError;
        // }
        return null;
      },
      obscureText: obscureText,
    );
  }

  Widget textFieldRePassword(BuildContext context,
      {Function(String?)? onSave,
      TextEditingController? controllerText,
      Function(String?)? onChange,
      Widget? suffixIcon,
      bool? obscureText}) {
    return TextFieldEdit(
      controllerText: _rePasswordController,
      suffixIcon: suffixIcon,
      textInputAction: TextInputAction.done,
      hint: AppLocalizations.of(context)!.reEnterPassword,
      validatePassword: (value) {
        if (value == null || value.isEmpty) {
          _check = false;
          return AppLocalizations.of(context)!.kPassNullError;
        }
        if (value != _passwordController.text) {
          _check = false;
          return AppLocalizations.of(context)!.kMatchPassError;
        } else {
          _check = true;
        }
      },
      obscureText: obscureText,
    );
  }

  Form changePassForm(BuildContext context) {
    return Form(
      key: _keyForm,
      child: Column(
        children: [
          SizedBox(height: 10.h),
          textNewPassword(context,
              controllerText: _passwordController,
              suffixIcon: InkWell(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: _showPass
                      ? Icon(
                          Icons.visibility,
                          color: AppColors.kPrimaryColor,
                        )
                      : Icon(Icons.visibility_off,
                          color: AppColors.kPrimaryColor),
                ),
                onTap: () {
                  setState(() {
                    _showPass = !_showPass;
                  });
                },
              ),
              obscureText: _showPass),
          SizedBox(height: 20.h),
          textFieldRePassword(context,
              controllerText: _rePasswordController,
              suffixIcon: InkWell(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: _showRePass
                      ? Icon(
                          Icons.visibility,
                          color: AppColors.kPrimaryColor,
                        )
                      : Icon(Icons.visibility_off,
                          color: AppColors.kPrimaryColor),
                ),
                onTap: () {
                  setState(() {
                    _showRePass = !_showRePass;
                  });
                },
              ),
              obscureText: _showRePass),
        ],
      ),
    );
  }
}
