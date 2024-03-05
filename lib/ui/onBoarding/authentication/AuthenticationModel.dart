import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AuthenticationModel {
  ///  State fields for stateful widgets in this page.

  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {}

  void dispose() {
    textFieldFocusNode?.dispose();
    textController?.dispose();
  }

bool isValidMobile(String? mobileNumber) {
  // Check if mobileNumber is not null and matches the format
  return mobileNumber != null && (RegExp(r'^[0-9]{10}$').hasMatch(mobileNumber) || RegExp(r'^[0-9]{12}$').hasMatch(mobileNumber));
}

void showToast(String message) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: Color.fromARGB(255, 198, 206, 198),
    textColor: Color(0xFF00468F),
    fontSize: 16.0,
  );

}
}