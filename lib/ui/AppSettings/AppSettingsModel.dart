import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';


class AppSettingsModel {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();

  /// Initialization and disposal methods.

  void initState(BuildContext context) {}

  void dispose() {
    unfocusNode.dispose();
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
