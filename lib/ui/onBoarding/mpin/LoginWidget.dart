// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, sort_child_properties_last, deprecated_member_use, library_private_types_in_public_api, unused_import

import 'package:fedsecure/hive_Database/HiveHelper.dart';
import 'package:fedsecure/ui/Home/HomeWidget.dart';
import 'package:fedsecure/ui/Messages/MessagesScreenWidget.dart';
import 'package:fedsecure/ui/Otp/OTPScreenWidget.dart';
import 'package:fedsecure/ui/UserValidate/UserValidationWidget.dart';
import 'package:fedsecure/ui/onBoarding/authentication/AuthenticationWidget.dart';
import 'package:fedsecure/ui/onBoarding/mpin/LoginModel.dart';
import 'package:fedsecure/ui/onBoarding/mpin/SetMPINWidget.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:flutter/material.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget({Key? key}) : super(key: key);

  @override
  _LoginWidgetState createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  late LoginModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _newpinController = TextEditingController();

  var login_pinChk;

  @override
  void initState() {
    super.initState();
    _model = LoginModel();

    login_pinChk = HiveHelper.getData('PIN_stored');
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
                          'Login',
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
                          'to your account',
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
                    padding: EdgeInsetsDirectional.fromSTEB(18, 25, 18, 25),
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
                              key: _model.formKey,
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
                                  controller: _newpinController,
                                  onChanged: (val) {
                                    _newpinController.text = val;
                                  },
                                  autovalidateMode: AutovalidateMode.always,
                                  // validator: (value) => _model.rEnterPinCodeValidator(value),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 35, 0, 0),
                            child: ElevatedButton(
                              onPressed: () {
                                print('Button pressed ...');

                                String enterPin =
                                    _newpinController.text.toString();
                                if (enterPin.isNotEmpty) {
                                  if (enterPin == login_pinChk) {
                                    HiveHelper.saveData('log_Status', "true");

                                    Navigator.pop(
                                        context); // Close the current widget
                                    Navigator.push(
                                      context,
                                      PageRouteBuilder(
                                        pageBuilder: (context, animation,
                                                secondaryAnimation) =>
                                            HomeWidget(),
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
                                    showToast(
                                        "Wrong pin! please enter your pin");

                                    _newpinController.clear();
                                  }
                                } else {
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
                                EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    if (login_pinChk.isNotEmpty) {
                                      Navigator.pop(context);
                                      Navigator.push(
                                        context,
                                        PageRouteBuilder(
                                          pageBuilder: (context, animation,
                                                  secondaryAnimation) =>
                                              SetMPINWidget(),
                                          transitionsBuilder: (context,
                                              animation,
                                              secondaryAnimation,
                                              child) {
                                            var begin = Offset(1.0, 0.0);
                                            var end = Offset.zero;
                                            var curve = Curves.ease;

                                            var tween = Tween(
                                                    begin: begin, end: end)
                                                .chain(
                                                    CurveTween(curve: curve));
                                            var offsetAnimation =
                                                animation.drive(tween);

                                            return SlideTransition(
                                              position: offsetAnimation,
                                              child: child,
                                            );
                                          },
                                          transitionDuration:
                                              Duration(milliseconds: 500),
                                        ),
                                      );
                                    } else {
                                      Navigator.pop(context);
                                      Navigator.push(
                                        context,
                                        PageRouteBuilder(
                                          pageBuilder: (context, animation,
                                                  secondaryAnimation) =>
                                              AuthenticationWidget(),
                                          transitionsBuilder: (context,
                                              animation,
                                              secondaryAnimation,
                                              child) {
                                            var begin = Offset(1.0, 0.0);
                                            var end = Offset.zero;
                                            var curve = Curves.ease;

                                            var tween = Tween(
                                                    begin: begin, end: end)
                                                .chain(
                                                    CurveTween(curve: curve));
                                            var offsetAnimation =
                                                animation.drive(tween);

                                            return SlideTransition(
                                              position: offsetAnimation,
                                              child: child,
                                            );
                                          },
                                          transitionDuration:
                                              Duration(milliseconds: 500),
                                        ),
                                      );
                                    }
                                    print("Forgot MPIN clicked!");
                                  },
                                  child: Text(
                                    'Forgot MPIN',
                                    style: TextStyle(
                                      fontFamily: 'Roboto',
                                      color: Color(0xFFFAFAFA),
                                      fontSize: 13,
                                      fontWeight: FontWeight.normal,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                ),
                              ],
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
}
