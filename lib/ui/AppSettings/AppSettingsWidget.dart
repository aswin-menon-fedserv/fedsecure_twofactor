// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'dart:convert';
import 'dart:io';

import 'package:fedsecure/hive_Database/HiveHelper.dart';
import 'package:fedsecure/ui/AppSettings/AppSettingsModel.dart';
import 'package:fedsecure/ui/Profile/ProfilePageWidget.dart';
import 'package:fedsecure/ui/onBoarding/mpin/SetMPINWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class AppSettingsWidget extends StatefulWidget {
  const AppSettingsWidget({Key? key}) : super(key: key);

  @override
  _AppSettingsWidgetState createState() => _AppSettingsWidgetState();
}

class _AppSettingsWidgetState extends State<AppSettingsWidget> {
  late AppSettingsModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  bool isOTPEnabled = false;
  var mobile_num, deviceID, param = '',login_pinChk;

  @override
  void initState() {
    super.initState();
    _model = AppSettingsModel();

    init();
  }

  Future<void> init() async {
    mobile_num = await HiveHelper.getData('mobileNumber_stored');
    deviceID = await HiveHelper.getData('deviceId_stored');
    login_pinChk = HiveHelper.getData('PIN_stored');

    paramcall();
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

    return GestureDetector(
      onTap: () => _model.unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(_model.unfocusNode)
          : FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Colors.white,
        body: SafeArea(
          top: true,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                width: double.infinity,
                height: 42,
                decoration: BoxDecoration(
                  color: Color(0xFFFFFFFF),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(15, 0, 0, 0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Icon(
                          Icons.arrow_back_rounded,
                          color: Color(0xFF57636C),
                          size: 24,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(15, 0, 0, 0),
                      child: Text(
                        'App Settings',
                        style: Theme.of(context).textTheme.bodyText2!.merge(
                              const TextStyle(
                                fontFamily: 'Roboto',
                                color: Color(0xFF383C48),
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                thickness: 1,
                color: Color(0xFFF2F2F2),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                  child: Container(
                    width: double.infinity,
                    height: 100,
                    decoration: BoxDecoration(
                      color: Color(0xFFFFFFFF),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: ListView(
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    10, 5, 10, 5),
                                child: Container(
                                  width: double.infinity,
                                  height: 42,
                                  decoration: BoxDecoration(
                                    color: Color(0xFFFFFFFF),
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          // Add your click handling logic here
                                          // For example, you can add a function call to handle the logout action
                                          Navigator.push(
                                            context,
                                            PageRouteBuilder(
                                              pageBuilder: (context, animation,
                                                      secondaryAnimation) =>
                                                  ProfileWidget(),
                                              transitionsBuilder: (context,
                                                  animation,
                                                  secondaryAnimation,
                                                  child) {
                                                var begin = Offset(1.0, 0.0);
                                                var end = Offset.zero;
                                                var curve = Curves.ease;

                                                var tween = Tween(
                                                        begin: begin, end: end)
                                                    .chain(CurveTween(
                                                        curve: curve));
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
                                        },
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(0),
                                                child: Icon(
                                                  Icons.person,
                                                  color: Theme.of(context)
                                                      .textTheme
                                                      .subtitle1
                                                      ?.color,
                                                  size: 25,
                                                )),
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(12, 0, 0, 0),
                                              child: Text(
                                                'Profile',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyText2!
                                                    .merge(
                                                      const TextStyle(
                                                        fontFamily: 'Roboto',
                                                        color:
                                                            Color(0xFF2D2D2D),
                                                      ),
                                                    ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Align(
                                                alignment:
                                                    AlignmentDirectional(1, 0),
                                                child: Icon(
                                                  Icons.arrow_forward_ios_sharp,
                                                  color: Color(0xFF828BA0),
                                                  size: 24,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Divider(
                                        thickness: 1,
                                        color: Color(0xFFF2F2F2),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    10, 5, 10, 5),
                                child: Container(
                                  width: double.infinity,
                                  height: 42,
                                  decoration: BoxDecoration(
                                    color: Color(0xFFFFFFFF),
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          // Add your click handling logic here
                                          // For example, you can add a function call to handle the logout action
                                          if (login_pinChk.isNotEmpty) {
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
                                                    .chain(CurveTween(
                                                        curve: curve));
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
                                        },
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(0),
                                              child: Image.asset(
                                                'assets/images/changepin_icon.png',
                                                width: 27,
                                                height: 25,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(12, 0, 0, 0),
                                              child: Text(
                                                'Change PIN',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyText2!
                                                    .merge(
                                                      const TextStyle(
                                                        fontFamily: 'Roboto',
                                                        color:
                                                            Color(0xFF2D2D2D),
                                                      ),
                                                    ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Align(
                                                alignment:
                                                    AlignmentDirectional(1, 0),
                                                child: Icon(
                                                  Icons.arrow_forward_ios_sharp,
                                                  color: Color(0xFF828BA0),
                                                  size: 24,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Divider(
                                        thickness: 1,
                                        color: Color(0xFFF2F2F2),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              // Padding(
                              //   padding: EdgeInsetsDirectional.fromSTEB(
                              //       10, 5, 10, 5),
                              //   child: Container(
                              //     width: double.infinity,
                              //     height: 42,
                              //     decoration: BoxDecoration(
                              //       color: Color(0xFFFFFFFF),
                              //     ),
                              //     child: Column(
                              //       mainAxisSize: MainAxisSize.max,
                              //       mainAxisAlignment: MainAxisAlignment.center,
                              //       children: [
                              //         Row(
                              //           mainAxisSize: MainAxisSize.max,
                              //           mainAxisAlignment:
                              //               MainAxisAlignment.start,
                              //           crossAxisAlignment:
                              //               CrossAxisAlignment.center,
                              //           children: [
                              //             ClipRRect(
                              //               borderRadius:
                              //                   BorderRadius.circular(0),
                              //               child: Image.asset(
                              //                 'assets/images/encrypt_msg.png',
                              //                 width: 27,
                              //                 height: 25,
                              //                 fit: BoxFit.cover,
                              //               ),
                              //             ),
                              //             Padding(
                              //               padding:
                              //                   EdgeInsetsDirectional.fromSTEB(
                              //                       12, 0, 0, 0),
                              //               child: Text(
                              //                 'Encrypt Message',
                              //                 style: Theme.of(context)
                              //                     .textTheme
                              //                     .bodyText2!
                              //                     .merge(
                              //                       const TextStyle(
                              //                         fontFamily: 'Roboto',
                              //                         color: Color(0xFF2D2D2D),
                              //                       ),
                              //                     ),
                              //               ),
                              //             ),
                              //             Expanded(
                              //               child: Align(
                              //                 alignment:
                              //                     AlignmentDirectional(1, 0),
                              //                 child: Icon(
                              //                   Icons.arrow_forward_ios_sharp,
                              //                   color: Color(0xFF828BA0),
                              //                   size: 24,
                              //                 ),
                              //               ),
                              //             ),
                              //           ],
                              //         ),
                              //         Divider(
                              //           thickness: 1,
                              //           color: Color(0xFFF2F2F2),
                              //         ),
                              //       ],
                              //     ),
                              //   ),
                              // ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    10, 5, 10, 5),
                                child: Container(
                                  width: double.infinity,
                                  height: 65,
                                  decoration: BoxDecoration(
                                    color: Color(0xFFFFFFFF),
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(0),
                                            child: Image.asset(
                                              'assets/images/encrypt_msg.png',
                                              width: 27,
                                              height: 25,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    12, 0, 0, 0),
                                            child: Text(
                                              'Enable/Disable Message',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText2!
                                                  .merge(
                                                    const TextStyle(
                                                      fontFamily: 'Roboto',
                                                      color: Color(0xFF2D2D2D),
                                                    ),
                                                  ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Align(
                                              alignment:
                                                  AlignmentDirectional(1, 0),
                                              child: Transform.scale(
                                                scale:
                                                    0.6, // Adjust scale as needed
                                                child: Switch(
                                                  value: isOTPEnabled,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      isOTPEnabled = value;
                                                      paramupdate(value);
                                                    });
                                                  },
                                                  activeColor: Colors.blue,
                                                  inactiveThumbColor:
                                                      Colors.grey,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Divider(
                                        thickness: 1,
                                        color: Color(0xFFF2F2F2),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    10, 5, 10, 5),
                                child: Container(
                                  width: double.infinity,
                                  height: 42,
                                  decoration: BoxDecoration(
                                    color: Color(0xFFFFFFFF),
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          // Add your click handling logic here
                                          // For example, you can add a function call to handle the logout action
                                          handleLogout();
                                        },
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.login_outlined,
                                              color: Color(0xCC57636C),
                                              size: 25,
                                            ),
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(12, 0, 0, 0),
                                              child: Text(
                                                'Logout',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyText2!
                                                    .merge(
                                                      const TextStyle(
                                                        fontFamily: 'Roboto',
                                                        color:
                                                            Color(0xFF2D2D2D),
                                                      ),
                                                    ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Align(
                                                alignment:
                                                    AlignmentDirectional(1, 0),
                                                child: Icon(
                                                  Icons.arrow_forward_ios,
                                                  color: Color(0xFF828BA0),
                                                  size: 24,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Divider(
                                        thickness: 1,
                                        color: Color(0xFFF2F2F2),
                                      ),
                                    ],
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
              ),
            ],
          ),
        ),
      ),
    );
  }

  void paramcall() {
    param = '$mobile_num~$deviceID';

    String AlertApp = "AlertApp";
    String adapfunction = "viewSmsStatus";
    String encryptkey = "";

    List<String> valuesList = [AlertApp, adapfunction, param, encryptkey];
    print(valuesList);
    // Convert the list to a JSON string
    String jsonString = jsonEncode(valuesList);
    print("js- $jsonString");

    if (!jsonString.isEmpty) {
      callviewSmsStatus(jsonString);
    } else {
      print(jsonString);
    }
  }

  void paramupdate(bool AletType) {
    if (AletType == true) {
      param = '$mobile_num~$deviceID~Y';
    } else {
      param = '$mobile_num~$deviceID~N';
    }

    String AlertApp = "AlertApp";
    String adapfunction = "updateSms";
    String encryptkey = "";

    List<String> valuesList = [AlertApp, adapfunction, param, encryptkey];
    print(valuesList);
    // Convert the list to a JSON string
    String jsonString = jsonEncode(valuesList);
    print("js- $jsonString");

    if (!jsonString.isEmpty) {
      callupdateSms(jsonString);
    } else {
      print(jsonString);
    }
  }

  Future callviewSmsStatus(String requestJS) async {
    // Decode the requestJS parameter

    // Construct the URL with the decoded parameter
    final url = Uri.parse(
        'https://may-i-lozthqfyea-el.a.run.app/fedsecureapp/mobilebanking/invoke?adapter=AlertApp&procedure=requestparam&parameters=$requestJS');

    // Make the API call
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
    );

    print("url-  $url");

    // Check if the request was successful
    if (response.statusCode == 200) {
      // Extract JSON response by removing the prefix and suffix
      String responseBody =
          response.body.replaceFirst("/*-secure-", "").replaceFirst("*/", "");

      // Parse the JSON
      Map<String, dynamic> jsonResponse = json.decode(responseBody);

      print(jsonResponse);

      if (jsonResponse['isSuccessful'] == true) {
        var responseParamString = jsonResponse['responseParam'];

        print(responseParamString);

        String msg = responseParamString['statusDesc'];

        if (responseParamString['status'] == true) {
          //_model.showToast(msg);

          if (responseParamString['smsStatus'] == "Y") {
            setState(() {
              isOTPEnabled = true;
            });
          } else if (responseParamString['smsStatus'] == "N") {
            setState(() {
              isOTPEnabled = false;
            });
          }
        } else {
          //_model.showToast(msg);
          print('API call was successful, but status is not true');
        }
      } else {
        print('API call was not successful');
      }
    } else {
      // If the server did not return a 200 OK response,
      // throw an exception.
      throw Exception('Failed to load data');
    }
  }

  Future callupdateSms(String requestJS) async {
    // Decode the requestJS parameter

    // Construct the URL with the decoded parameter
    final url = Uri.parse(
        'https://may-i-lozthqfyea-el.a.run.app/fedsecureapp/mobilebanking/invoke?adapter=AlertApp&procedure=requestparam&parameters=$requestJS');

    // Make the API call
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
    );

    print("url-  $url");

    // Check if the request was successful
    if (response.statusCode == 200) {
      // Extract JSON response by removing the prefix and suffix
      String responseBody =
          response.body.replaceFirst("/*-secure-", "").replaceFirst("*/", "");

      // Parse the JSON
      Map<String, dynamic> jsonResponse = json.decode(responseBody);

      print(jsonResponse);

      if (jsonResponse['isSuccessful'] == true) {
        var responseParamString = jsonResponse['responseParam'];

        print(responseParamString);

        String msg = responseParamString['statusDesc'];

        if (responseParamString['status'] == true) {
          //_model.showToast(msg);

          if (responseParamString['smsStatus'] == "Y") {
            setState(() {
              isOTPEnabled = true;
            });
          } else if (responseParamString['smsStatus'] == "N") {
            setState(() {
              isOTPEnabled = false;
            });
          }
        } else {
          //_model.showToast(msg);
          print('API call was successful, but status is not true');
        }
      } else {
        print('API call was not successful');
      }
    } else {
      // If the server did not return a 200 OK response,
      // throw an exception.
      throw Exception('Failed to load data');
    }
  }

  Future<void> handleLogout() async {
    //await HiveHelper.clearAllData();
    // Exits the app
    if (Platform.isAndroid) {
      SystemNavigator.pop();
    } else if (Platform.isIOS) {
      exit(0);
    }
  }
}
