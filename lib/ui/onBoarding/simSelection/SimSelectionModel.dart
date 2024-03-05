import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';


class SimSelectionModel {
  /// Initialization and disposal methods.

  void initState(BuildContext context) {}

  void dispose() {}

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

void dialog_two(BuildContext context){showDialog(
  context: context,
  barrierDismissible: false,
  builder: (BuildContext context) {
    return AlertDialog(
      backgroundColor:Color(0xFF00468F),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.zero,
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            'assets/images/Icon_2.png', 
            width: 150,
            height: 180, 
            fit: BoxFit.contain, 
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  },
);
}

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
