import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:sample/constants/colors.dart';
import 'package:sample/helper/helper.dart';
import 'package:sample/routes/routes.gr.dart';
import 'package:sample/widgets/default_button.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EmailFormScreen extends StatefulWidget {
  const EmailFormScreen({super.key});

  @override
  State<EmailFormScreen> createState() => _EmailFormScreenState();
}

class _EmailFormScreenState extends State<EmailFormScreen> {
  GlobalKey<FormState> _emailKeyForm = GlobalKey();
  TextEditingController _emailController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return KeyboardDismisser(
      child: Scaffold(
        appBar: AppBar(),
        body: SafeArea(
            child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
                child: Column(
              children: [
                SizedBox(height: 10.h),
                Text(
                  AppLocalizations.of(context)!.forgetPassword,
                  style: const TextStyle(
                    fontSize: 28,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10.h),
                Text(
                  AppLocalizations.of(context)!.forgetPasswordDes,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 5.h),
                emailTextFrom(context),
                SizedBox(height: 20.h),
                DefaultButton(
                  width: double.infinity,
                  text: AppLocalizations.of(context)!.send.toUpperCase(),
                  press: () {
                    context.pushRoute(const CodeFormRouter());
                  },
                ),
              ],
            )),
          ),
        )),
      ),
    );
  }

  Form emailTextFrom(BuildContext context) {
    return Form(
      key: _emailKeyForm,
      child: Column(
        children: [
          Helpers.shared.textFieldEmail(
            context,
            controllerText: _emailController,
            prefixIcon: Icon(
              Icons.mail,
              color: AppColors.kPrimaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
