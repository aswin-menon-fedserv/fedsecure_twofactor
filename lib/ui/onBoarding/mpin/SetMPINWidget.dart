// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last, deprecated_member_use

import 'package:fedsecure/hive_Database/HiveHelper.dart';
import 'package:fedsecure/ui/onBoarding/mpin/LoginWidget.dart';
import 'package:fedsecure/ui/onBoarding/mpin/SetMPINModel.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class SetMPINWidget extends StatefulWidget {
  const SetMPINWidget({Key? key}) : super(key: key);

  @override
  _SetMPINWidgetState createState() => _SetMPINWidgetState();
}

class _SetMPINWidgetState extends State<SetMPINWidget> {
  late SetMPINModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
final _pinController=TextEditingController();
  final _rePinController=TextEditingController();

  @override
  void initState() {
    super.initState();
    _model = SetMPINModel();
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // if (isiOS) {
    //   SystemChrome.setSystemUIOverlayStyle(
    //     SystemUiOverlayStyle(
    //       statusBarBrightness: Theme.of(context).brightness,
    //       systemStatusBarContrastEnforced: true,
    //     ),
    //   );
    // }


    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Color(0xFFFAFAFA),
      body: Stack(
        alignment: AlignmentDirectional(0, 0),
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  width: double.infinity,
                  height: 100,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFFFFF),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(25, 50, 0, 0),
                            child: Container(
                              width: 42,
                              height: 40,
                              decoration: BoxDecoration(
                                color: const Color(0xFFFFFFFF),
                                image: DecorationImage(
                                  fit: BoxFit.contain,
                                  image: Image.asset(
                                    'assets/images/fedicon.png',
                                  ).image,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Expanded(
                              child: Container(
                                width: double.infinity,
                                height: 100,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFFFFFFF),
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: Image.asset(
                                      'assets/images/pattern_head_rev.png',
                                    ).image,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  width: double.infinity,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Color(0xFFFAFAFA),
                  ),
                ),
              ),
            ],
          ),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Color(0xCBFFFFFF),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(35, 30, 0, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          'Set MPIN',
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            color: Color(0xFF00387D),
                            fontSize: 28,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(35, 0, 0, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          'for your account',
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            color: Color(0xFF00387D),
                            fontSize: 28,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(18, 25, 18, 10),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Color(0xFF00468F),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 25),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Enter your MPIN',
                                  style: TextStyle(
                                    fontFamily: 'Roboto',
                                    color: Color(0xFFFAFAFA),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                            child: Form(
                              key: _model.formKey1,
                              autovalidateMode: AutovalidateMode.always,
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    40, 0, 40, 0),
                                child: PinCodeTextField(
                                  autoDisposeControllers: false,
                                  appContext: context,
                                  length: 4,
                                  textStyle: TextStyle(
                                    fontFamily: 'Readex Pro',
                                    color: Color(0xFF262D34),
                                    fontSize: 14,
                                  ),
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  enableActiveFill:
                                      true, // Set this to true to enable the fill color
                                  autoFocus: false,
                                  enablePinAutofill: false,
                                  errorTextSpace: 14,
                                  showCursor: true,
                                  cursorColor: Color(0xFF57636C),
                                  obscureText: true,
                                  obscuringCharacter: '●',
                                  keyboardType: TextInputType.number,
                                  pinTheme: PinTheme(
                                    fieldHeight: 30,
                                    fieldWidth: 30,
                                    borderWidth: 4,
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(8),
                                      bottomRight: Radius.circular(8),
                                      topLeft: Radius.circular(8),
                                      topRight: Radius.circular(8),
                                    ),
                                    shape: PinCodeFieldShape.box,
                                    activeColor: Color(0xFFF1F1F1),
                                    inactiveColor: Color(0xFFF1F1F1),
                                    selectedColor: Color(0xFFF1F1F1),
                                    activeFillColor:
                                        Color(0xFFFAFAFA), // Updated color
                                    inactiveFillColor:
                                        Color(0xFFFAFAFA), // Updated color
                                    selectedFillColor:
                                        Color(0xFFFAFAFA), // Updated color
                                  ),
                                  controller: _pinController,
                                  onChanged: (val) {

                                    _pinController.text=val;


                                  },
                                  autovalidateMode: AutovalidateMode.always,
                                  //validator: _model.pinCodeControllerValidator.asValidator(context),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Re enter your MPIN',
                                  style: TextStyle(
                                    fontFamily: 'Roboto',
                                    color: Color(0xFFFAFAFA),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                            child: Form(
                              key: _model.formKey2,
                              autovalidateMode: AutovalidateMode.always,
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    40, 0, 40, 0),
                                child: PinCodeTextField(
                                  autoDisposeControllers: false,
                                  appContext: context,
                                  length: 4,
                                  textStyle: TextStyle(
                                    fontFamily: 'Readex Pro',
                                    color: Color(0xFF262D34),
                                    fontSize: 14,
                                  ),
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  enableActiveFill:
                                      true, // Set this to true to enable the fill color
                                  autoFocus: false,
                                  enablePinAutofill: false,
                                  errorTextSpace: 14,
                                  showCursor: true,
                                  cursorColor: Color(0xFF57636C),
                                  obscureText: true,
                                  obscuringCharacter: '●',
                                  keyboardType: TextInputType.number,
                                  pinTheme: PinTheme(
                                    fieldHeight: 30,
                                    fieldWidth: 30,
                                    borderWidth: 4,
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(8),
                                      bottomRight: Radius.circular(8),
                                      topLeft: Radius.circular(8),
                                      topRight: Radius.circular(8),
                                    ),
                                    shape: PinCodeFieldShape.box,
                                    activeColor: Color(0xFFF1F1F1),
                                    inactiveColor: Color(0xFFF1F1F1),
                                    selectedColor: Color(0xFFF1F1F1),
                                    activeFillColor:
                                        Color(0xFFFAFAFA), // Updated color
                                    inactiveFillColor:
                                        Color(0xFFFAFAFA), // Updated color
                                    selectedFillColor:
                                        Color(0xFFFAFAFA), // Updated color
                                  ),
                                  controller: _rePinController,
                                  onChanged: (value) {
                                    _rePinController.text=value;

                                  },
                                  autovalidateMode: AutovalidateMode.always,
                                  //validator: _model.rEnterPinCodeValidator.asValidator(context),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 30, 0, 0),
                            child: ElevatedButton(
                              onPressed: () {
                                print('Button pressed ...');

                                String pin = _pinController.text.toString();
                                String rePin = _rePinController.text.toString();

                                if (pin.isNotEmpty && rePin.isNotEmpty) {
                                  if (pin == rePin) {
                                    HiveHelper.saveData('PIN_stored', pin);
                                    showToast("Welcome to fedsecure");
                                    Navigator.pop(
                                        context); // Close the current widget
                                    Navigator.push(
                                      context,
                                      PageRouteBuilder(
                                        pageBuilder: (context, animation,
                                                secondaryAnimation) =>
                                            LoginWidget(),
                                        transitionsBuilder: (context, animation,
                                            secondaryAnimation, child) {
                                          var begin = Offset(1.0,
                                              0.0); // Change this to modify the direction of the slide
                                          var end = Offset.zero;
                                          var curve = Curves.ease;
                                          var tween = Tween(
                                                  begin: begin, end: end)
                                              .chain(CurveTween(curve: curve));
                                          var offsetAnimation =
                                              animation.drive(tween);
                                          return SlideTransition(
                                            position: offsetAnimation,
                                            child: child,
                                          );
                                        },
                                        transitionDuration: Duration(
                                            milliseconds:
                                                500), // Customize the duration of the animation
                                      ),
                                    );
                                  } else {
                                    // Show toast
                                    showToast(
                                        "Entered PINs do not match! Re-enter.");
                                    _pinController.clear();
                                    _rePinController.clear();
                                  }
                                } else {
                                  // Show toast for empty or null PIN
                                  showToast(
                                      "PINs cannot be empty. Please enter PINs.");
                                }
                              },

                              child: Text(
                                'Continue',
                                style: TextStyle(
                                  fontFamily: 'Roboto',
                                  color: Colors.white,
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                primary: Color(
                                    0xFFF99300), // Button background color
                                onPrimary: Colors.white, // Text color
                                minimumSize: Size(250, 45),
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    24, 0, 24, 0),
                                elevation: 3,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(45),
                                    bottomRight: Radius.circular(45),
                                    topLeft: Radius.circular(45),
                                    topRight: Radius.circular(45),
                                  ),
                                ),
                                // You might need to adjust the side property to meet your design
                                side: BorderSide(
                                  color: Colors.transparent,
                                  width: 1,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 20, 0, 25),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Stay safe! Be cautious of phishing emails \nand SMS. Never share your ATM card \ndetails, PINs, OTPs, or passwords with \nanyone.',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: 'Roboto',
                                    color: Color(0xFFFAFAFA),
                                    fontSize: 12,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
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

  //  void callAPI_SetMPIN() {
  //   Map<String, dynamic> requestParams = {
  //     "applicationId": appID_stored,
  //     "usertype": "Federal",
  //     "mobileNumber": mobileNumber_stored,
  //     "deviceID": deviceId_stored,
  //     "mpin": enteredPin,
  //     "authparam": "",
  //     "appid": "FEDSECURE",
  //     "tokenid": "",
  //     "tokenparam": "",
  //   };

  //   ApiService().callablefunc(
  //     ApiConstants.baseUrl_Main,
  //     false,
  //     ApiConstants.setMpin,
  //     requestParams,
  //     (jsonResponse) {
  //       // Extract the response details
  //       String mobilenumber = jsonResponse["mobilenumber"];
  //       String statusdesc =
  //           jsonResponse["statusdesc"] ?? "No description provided";
  //       String status = jsonResponse["status"];

  //       if (status == "true") {
  //         // Perform actions for a true status
  //         if (statusdesc == "MPIN set successfully") {
  //         //  HiveHelper.clearData('ButtonStatus_stored');

  //           Navigator.push(
  //             context,
  //             MaterialPageRoute(builder: (context) => MpinPageWidget()),
  //           );
  //         } else {
  //           // Handle other descriptions for true status if any
  //         }
  //       } else if (status == "false") {
  //         // Perform actions for a false status
  //         if (statusdesc == "Mpin as already been set. Move to login") {
  //           HiveHelper.clearData('ButtonStatus_stored');
  //           Navigator.push(
  //             context,
  //             MaterialPageRoute(builder: (context) => MpinPageWidget()),
  //           );
  //         } else {
  //           // Handle other descriptions for false status if any
  //         }
  //       } else if (status == "Invalid MobileNumber") {
  //         // Navigator.push(
  //         //   context,
  //         //   MaterialPageRoute(builder: (context) => auth()),
  //         // );
  //       } else {
  //         // Handle unexpected status values
  //       }

  //       // Display a toast message with the status description
  //       Fluttertoast.showToast(
  //           msg: statusdesc,
  //           toastLength: Toast.LENGTH_SHORT,
  //           gravity: ToastGravity.BOTTOM,
  //           timeInSecForIosWeb: 1,
  //           backgroundColor: Colors.grey,
  //           textColor: Colors.white,
  //           fontSize: 16.0);
  //     },
  //     (error) {
  //       // Handle the error scenario
  //       // You might want to show an error message to the user
  //     },
  //   );
  // }
}
