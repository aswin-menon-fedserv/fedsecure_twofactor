import 'package:flutter/material.dart';

class SetMPINModel  {
  ///  State fields for stateful widgets in this page.

  final formKey2 = GlobalKey<FormState>();
  final formKey1 = GlobalKey<FormState>();
  // State field(s) for PinCode widget.
  TextEditingController? pinCodeController;
  String? Function(BuildContext, String?)? pinCodeControllerValidator;
  String? _pinCodeControllerValidator(BuildContext context, String? val) {
    print('fjbjb');
    if (val == null || val.isEmpty) {
      return 'Field is required';
    }
    if (val.length < 4) {
      return 'Requires 4 characters.';
    }
    return null;
  }

  // State field(s) for REnterPinCode widget.
  TextEditingController? rEnterPinCode;
  String? Function(BuildContext, String?)? rEnterPinCodeValidator;
  String? _rEnterPinCodeValidator(BuildContext context, String? val) {
print(rEnterPinCode!.text.toString());
  print(val);
  print("ddcccc");

    if (val == null || val.isEmpty) {
      return 'Field is required';
    }
    if (val.length < 4) {
      return 'Requires 4 characters.';
    }
    return null;
  }

  /// Initialization and disposal methods.

  void initState(BuildContext context) {
    pinCodeController = TextEditingController();
    pinCodeControllerValidator = _pinCodeControllerValidator;
    rEnterPinCode = TextEditingController();
    rEnterPinCodeValidator = _rEnterPinCodeValidator;
  }

  void dispose() {
    pinCodeController?.dispose();
    rEnterPinCode?.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
