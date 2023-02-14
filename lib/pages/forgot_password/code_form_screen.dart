import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:pinput/pinput.dart';
import 'package:sample/constants/colors.dart';
import 'package:sample/routes/routes.gr.dart';
import 'package:sample/widgets/default_button.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CodeFormScreen extends StatefulWidget {
  const CodeFormScreen({super.key});

  @override
  State<CodeFormScreen> createState() => _CodeFormScreenState();
}

class _CodeFormScreenState extends State<CodeFormScreen> {
  final controller = TextEditingController();
  final focusNode = FocusNode();
  String? keyCode;
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
                SizedBox(height: 20.h),
                Text(
                  AppLocalizations.of(context)!.verifyCode,
                  style: const TextStyle(
                    fontSize: 25,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  AppLocalizations.of(context)!.verifyCodeDes,
                  textAlign: TextAlign.center,
                ),
                buildPinPut(),
                SizedBox(height: 4.h),
                DefaultButton(
                  width: double.infinity,
                  text: AppLocalizations.of(context)!.continueStr.toUpperCase(),
                  press: () {
                    context.pushRoute(const ResetPassRouter());
                  },
                ),
                SizedBox(height: 10.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.notReceiveMail,
                      style: const TextStyle(fontSize: 13),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Text(
                        AppLocalizations.of(context)!.sendAnotherCode,
                        style: TextStyle(
                            fontSize: 13, color: AppColors.colorFC6011),
                      ),
                    ),
                  ],
                ),
              ],
            )),
          ),
        )),
      ),
    );
  }

  Widget buildPinPut() {
    final defaultPinTheme = PinTheme(
      width: 60,
      height: 64,
      textStyle: GoogleFonts.poppins(
          fontSize: 20, color: const Color.fromRGBO(70, 69, 66, 1)),
      decoration: BoxDecoration(
        color: AppColors.colorE1E4E8,
        borderRadius: BorderRadius.circular(10),
      ),
    );
    final cursor = Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        width: 21,
        height: 1,
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: const Color.fromRGBO(137, 146, 160, 1),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 40),
      child: Pinput(
        length: 6,
        controller: controller,
        focusNode: focusNode,
        defaultPinTheme: defaultPinTheme,
        separator: const SizedBox(width: 10),
        focusedPinTheme: defaultPinTheme.copyWith(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            // ignore: prefer_const_literals_to_create_immutables
            boxShadow: [
              const BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.05999999865889549),
                offset: Offset(0, 3),
                blurRadius: 16,
              ),
            ],
          ),
        ),
        showCursor: true,
        cursor: cursor,
      ),
    );
  }
}
