import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:sample/constants/colors.dart';
import 'package:sample/constants/pattern_constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:sample/widgets/dialog_app.dart';
import 'package:sample/widgets/text_field_edit.dart';

class Helpers {
  Helpers._();
  static final Helpers shared = Helpers._();

  bool _isDialogLoading = false;

  void hideKeyboard(BuildContext context) {
    FocusScope.of(context).unfocus();
  }

  void showDialogProgress(BuildContext context) {
    if (!_isDialogLoading) {
      _isDialogLoading = true;
      showDialog(
        //prevent outside touch
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          //prevent Back button press
          return WillPopScope(
            onWillPop: () {
              return Future<bool>.value(false);
            },
            child: AlertDialog(
              backgroundColor: Colors.transparent,
              elevation: 0,
              content: Center(
                child: SpinKitThreeBounce(
                  color: AppColors.kPrimaryColor,
                ),
              ),
            ),
          );
        },
      );
    }
  }

  void hideDialogProgress(BuildContext context) {
    if (_isDialogLoading) {
      _isDialogLoading = false;
      Navigator.pop(context);
    }
  }

  void showDialogError(
    BuildContext context, {
    String title = '',
    required String message,
    String subMessage = '',
    String okText = '',
    Function()? okFunction,
  }) {
    _baseDialogMessages(context,
        title: title.isNotEmpty ? title : "Lỗi",
        message: message,
        subMessage: subMessage,
        cancelText: '',
        okText: okText.isNotEmpty ? okText : "OK",
        cancelFunction: null,
        okFunction: okFunction);
  }

  void showDialogSuccess(
    BuildContext context, {
    String title = '',
    required String message,
    String subMessage = '',
    String okText = '',
    Function()? okFunction,
  }) {
    _baseDialogMessages(context,
        title: title.isNotEmpty ? title : "Thành công",
        message: message,
        subMessage: subMessage,
        cancelText: '',
        okText: okText.isNotEmpty ? okText : "OK",
        cancelFunction: null,
        okFunction: okFunction);
  }

  void showDialogConfirm(
    BuildContext context, {
    String title = '',
    required String message,
    String subMessage = '',
    String cancelText = '',
    String okText = '',
    Function()? cancelFunction,
    Function()? okFunction,
  }) {
    _baseDialogMessages(context,
        title: title.isNotEmpty ? title : "Xác nhận",
        message: message,
        subMessage: subMessage,
        cancelText: cancelText.isNotEmpty ? cancelText : "Hủy bỏ",
        okText: okText.isNotEmpty ? okText : "Đồng ý",
        cancelFunction: cancelFunction,
        okFunction: okFunction);
  }

  void _baseDialogMessages(
    BuildContext context, {
    required String title,
    required String message,
    String subMessage = '',
    required String cancelText,
    required String okText,
    Function()? cancelFunction,
    Function()? okFunction,
  }) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (ctx) => DialogApp(
            title: title,
            message: message,
            subMessage: subMessage,
            cancelText: cancelText,
            okText: okText,
            cancelFunction: cancelFunction,
            okFunction: okFunction));
  }

  Widget textFieldEmail(BuildContext context,
      {Function(String?)? onSave,
      TextEditingController? controllerText,
      Function(String?)? onChange,
      String? hint,
      Widget? prefixIcon}) {
    return TextFieldEdit(
      onChanged: onChange,
      onSave: onSave,
      controllerText: controllerText,
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.emailAddress,
      hint: hint,
      validatePassword: (value) {
        RegExp regex = new RegExp(PatternConstants.patternEmail);
        if (value == null || value.isEmpty) {
          return AppLocalizations.of(context)!.kEmailNullError;
        }
        // else if (!regex.hasMatch(value)) {
        //   return kInvalidEmailError;
        // }
      },
      prefixIcon: prefixIcon,
      maxLength: 20,
    );
  }

  Widget textFieldPassword(BuildContext context,
      {Function(String?)? onSave,
      TextEditingController? controllerText,
      Function(String?)? onChange,
      Widget? prefixIcon,
      Widget? suffixIcon,
      String? hint,
      bool? obscureText}) {
    return TextFieldEdit(
      onChanged: onChange,
      onSave: onSave,
      controllerText: controllerText,
      textInputAction: TextInputAction.done,
      hint: hint,
      validatePassword: (value) {
        if (value == null || value.isEmpty) {
          return AppLocalizations.of(context)!.kPassNullError;
        }
      },
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      obscureText: obscureText,
      maxLength: 20,
    );
  }
}
