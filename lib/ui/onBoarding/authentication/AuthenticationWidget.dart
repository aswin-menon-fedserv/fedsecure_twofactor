// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, use_build_context_synchronously, sort_child_properties_last, deprecated_member_use, library_private_types_in_public_api

import 'dart:convert';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:fedsecure/hive_Database/HiveHelper.dart';
import 'package:fedsecure/ui/onBoarding/authentication/AuthenticationModel.dart';
import 'package:fedsecure/ui/onBoarding/authentication/DeviceAuthWidget.dart';
import 'package:fedsecure/utils/RSAHelper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:pointycastle/asymmetric/api.dart';

class AuthenticationWidget extends StatefulWidget {
  const AuthenticationWidget({Key? key}) : super(key: key);

  @override
  _AuthenticationWidgetState createState() => _AuthenticationWidgetState();
}

class _AuthenticationWidgetState extends State<AuthenticationWidget> {
  late AuthenticationModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  var param = '';
  var appID,
      deviceId,
      deviceModel,
      deviceVersion,
      deviceFCMid = null,
      encryptedDeviceId,
      encryptedDeviceIdBase64,
      first10encryptedDeviceIdBase64,
      networkStatus_stored,
      mobileNumber_stored;


  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _model = AuthenticationModel();

    _model.textController ??= TextEditingController();
    _model.textFieldFocusNode ??= FocusNode();

    init();

    networkStatus_stored = HiveHelper.getData('networkStatus_stored');
    appID = HiveHelper.getData('appID_stored');
    deviceFCMid = HiveHelper.getData('mobile_fcm');
  }

  Future<void> init() async {
    var deviceInfo = await getDeviceInfo();
    deviceId = deviceInfo['deviceId'];
    deviceModel = deviceInfo['model'];
    deviceVersion = deviceInfo['version'];

    if (deviceId != null) {
      var rsaHelper = RSAHelper();
      var secureRandom = rsaHelper.exampleSecureRandom();
      var keyPair = rsaHelper.generateRSAKeyPair(secureRandom);
      print(deviceId);
      print(deviceId);
      var deviceIdBytes = utf8.encode(deviceId);
      encryptedDeviceIdBase64 = rsaHelper.rsaEncryptToBase64(
          keyPair.publicKey as RSAPublicKey, Uint8List.fromList(deviceIdBytes));
      //print('Encrypted Device ID in Base64: $encryptedDeviceIdBase64');

      first10encryptedDeviceIdBase64 = encryptedDeviceIdBase64.substring(0, 10).replaceAll(new RegExp(r'[^\w\s]+'), '');
      print('Encrypted Device ID: LOTZA $first10encryptedDeviceIdBase64');

      HiveHelper.saveData('encryptedDeviceId_stored',
          "FBALERT $first10encryptedDeviceIdBase64");
      HiveHelper.saveData(
          'encryptedDeviceIdSMS_stored', "$first10encryptedDeviceIdBase64");

      HiveHelper.saveData('deviceId_stored', deviceId);
      HiveHelper.saveData('deviceModel_stored', deviceModel);
    }
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
                  decoration: const BoxDecoration(
                    color: Color(0xFFFFFFFF),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                25, 50, 0, 0),
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
                  decoration: const BoxDecoration(
                    color: Color(0xFFFAFAFA),
                  ),
                ),
              ),
            ],
          ),
          Container(
            width: double.infinity,
            height: 450,
            decoration: BoxDecoration(
              color: Color(0xCBFFFFFF),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(30, 30, 0, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        'Mobile Number',
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
                  padding: EdgeInsetsDirectional.fromSTEB(30, 0, 0, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        'Authentication',
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
                  padding: EdgeInsetsDirectional.fromSTEB(18, 25, 18, 0),
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
                          padding: EdgeInsetsDirectional.fromSTEB(22, 40, 0, 0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Text(
                                'Enter Your Mobile Number',
                                style: TextStyle(
                                  fontFamily: 'Roboto',
                                  color: Color(0xFFFAFAFA),
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Expanded(
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    20, 10, 20, 0),
                                child: TextFormField(
                                  controller: _model.textController,
                                  focusNode: _model.textFieldFocusNode,
                                  textInputAction: TextInputAction.done,
                                  obscureText: false,
                                  maxLength: 13,
                                  maxLengthEnforcement:
                                      MaxLengthEnforcement.enforced,
                                  decoration: InputDecoration(
                                    labelText:
                                        'Mobile Number(including country code)',
                                    labelStyle: TextStyle(
                                      fontFamily: 'Roboto',
                                      color: Color(0xFFFAFAFA),
                                      fontSize: 10,
                                    ),
                                    alignLabelWithHint: false,
                                    hintStyle: TextStyle(
                                      fontFamily: 'Roboto',
                                      color: Color(0xFFFAFAFA),
                                      fontSize: 10,
                                    ),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0xFFE0E3E7),
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(0),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0xFFF99300),
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(0),
                                    ),
                                    errorBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0xFFFF5963),
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(0),
                                    ),
                                    focusedErrorBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0xFFFF5963),
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(0),
                                    ),
                                    contentPadding:
                                        EdgeInsetsDirectional.fromSTEB(
                                            5, 0, 0, 0),
                                    counterText:
                                        '', // Set counterText to an empty string
                                  ),
                                  style: TextStyle(
                                    fontFamily: 'Readex Pro',
                                    color: Color(0xFFFAFAFA),
                                    fontSize: 15,
                                  ),
                                  textAlign: TextAlign.start,
                                  keyboardType: TextInputType.number,
                                  cursorColor: Color(0xFFFAFAFA),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 45, 0, 40),
                          child: ElevatedButton(
                            onPressed: isLoading
                                ? null
                                : () async {
                                    setState(() {
                                      isLoading = true;
                                    });

                                    if (_model.textController != null &&
                                        _model.isValidMobile(
                                            _model.textController?.text)) {
                                      // Simulate an asynchronous task (you can replace it with your logic)
                                      await Future.delayed(
                                          Duration(seconds: 2));

                                      var mobNo = _model.textController?.text;
                                      if (mobNo != null && mobNo.length == 10) {
                                        mobNo = "91" + mobNo;
                                      }

                                      param =
                                          '$appID~$mobNo~$deviceModel~$deviceVersion~$deviceId~$deviceFCMid~$first10encryptedDeviceIdBase64';

                                      String AlertApp = "AlertApp";
                                      String adapfunction = "AppActivation";
                                      String encryptkey = "";

                                      List<String> valuesList = [
                                        AlertApp,
                                        adapfunction,
                                        param,
                                        encryptkey
                                      ];
                                      print(valuesList);
                                      // Convert the list to a JSON string
                                      String jsonString =
                                          jsonEncode(valuesList);
                                      print("js- $jsonString");

                                      if (!jsonString.isEmpty) {
                                        callAppActivation(jsonString);
                                      } else {
                                        print(jsonString);
                                      }
                                    } else {
                                      // Show Flutter toast for invalid mobile number
                                      Fluttertoast.showToast(
                                        msg:
                                            "Please enter a valid mobile number",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.BOTTOM,
                                        backgroundColor: Colors.white,
                                        textColor: Color(0xFF00387D),
                                      );
                                    }

                                    setState(() {
                                      isLoading = false;
                                    });
                                  },
                            child: isLoading
                                ? CircularProgressIndicator()
                                : Text(
                                    'Proceed',
                                    style: TextStyle(
                                      fontFamily: 'Roboto',
                                      color: Colors.white,
                                    ),
                                  ),
                            style: ElevatedButton.styleFrom(
                              primary: Color(0xFFF99300),
                              onPrimary: Colors.white,
                              minimumSize: Size(250, 45),
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
                              elevation: 3,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(45),
                              ),
                              side: BorderSide(
                                color: Colors.transparent,
                                width: 1,
                              ),
                            ),
                          ),
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
    );
  }

  Future callAppActivation(String requestJS) async {
    // Decode the requestJS parameter
    String decodedRequestJS = Uri.decodeFull(requestJS);

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

      Map<String, dynamic> jsonResponse = json.decode(responseBody);

      if (jsonResponse['isSuccessful'] == true) {
        var responseParamString = jsonResponse['responseParam'];

        print(responseParamString);

        String msg = responseParamString['statusdesc'];

        if (responseParamString['status'] == true) {
          _model.showToast(msg);

          String mobNumber = responseParamString['mobileNumber'];
          String custID = responseParamString['customerID'];

          HiveHelper.saveData('mobileNumber_stored', mobNumber);
          HiveHelper.saveData('customerID_stored', custID);

          Navigator.pop(context);
          Navigator.push(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) =>
                  DeviceAuthWidget(),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                var begin = Offset(1.0,
                    0.0); // Change this to modify the direction of the slide
                var end = Offset.zero;
                var curve = Curves.ease;
                var tween = Tween(begin: begin, end: end)
                    .chain(CurveTween(curve: curve));
                var offsetAnimation = animation.drive(tween);
                return SlideTransition(
                  position: offsetAnimation,
                  child: child,
                );
              },
              transitionDuration: Duration(
                  milliseconds: 500), // Customize the duration of the animation
            ),
          );
        } else {
          _model.showToast(msg);
          print('API call was successful, but status is not true');
        }
      }
    } else {
      // If the server did not return a 200 OK response,
      // throw an exception.
      throw Exception('Failed to load data');
    }
  }

// Future callAppActivation(String requestJS) async {
//     // Decode the requestJS parameter
//     String decodedRequestJS = Uri.decodeFull(requestJS);

//     // Construct the URL with the decoded parameter
//     final url = Uri.parse(
//         'https://may-i-lozthqfyea-el.a.run.app/fedsecureapp/mobilebanking/invoke?adapter=AlertApp&procedure=requestparam&parameters=$requestJS');

//     // Make the API call
//     final response = await http.post(
//       url,
//       headers: {'Content-Type': 'application/json'},
//     );

//     print("url-  $url");

//     // Check if the request was successful
//     if (response.statusCode == 200) {
//       // Extract JSON response by removing the prefix and suffix
//       String responseBody =
//           response.body.replaceFirst("/*-secure-", "").replaceFirst("*/", "");

//       // Parse the JSON
//       Map<String, dynamic> jsonResponse = json.decode(responseBody);

//       print(jsonResponse);

//       if (jsonResponse['isSuccessful'] == true) {
//         String responseParamString = jsonResponse['responseParam'];

// // Parse the 'responseParam' string
//         Map<String, dynamic> responseParamMap =
//             json.decode(responseParamString);

//         String msg = responseParamMap['statusdesc'];

  // if (responseParamMap['status'] == true) {
  //   _model.showToast(msg);

  //   String mobNumber = responseParamMap['mobileNumber'];
  //   String custID = responseParamMap['customerID'];

  //   HiveHelper.saveData('mobileNumber_stored', mobNumber);
  //   HiveHelper.saveData('customerID_stored', custID);

  //   Navigator.push(
  //     context,
  //     PageRouteBuilder(
  //       pageBuilder: (context, animation, secondaryAnimation) =>
  //           DeviceAuthWidget(),
  //       transitionsBuilder:
  //           (context, animation, secondaryAnimation, child) {
  //         var begin = Offset(1.0, 0.0);
  //         var end = Offset.zero;
  //         var curve = Curves.ease;

  //         var tween = Tween(begin: begin, end: end)
  //             .chain(CurveTween(curve: curve));
  //         var offsetAnimation = animation.drive(tween);

  //         return SlideTransition(
  //           position: offsetAnimation,
  //           child: child,
  //         );
  //       },
  //       transitionDuration: Duration(milliseconds: 500),
  //     ),
  //   );
  // } else {
  //   _model.showToast(msg);
  //   print('API call was successful, but status is not true');
  // }
//       } else {
//         print('API call was not successful');
//       }
//     } else {
//       // If the server did not return a 200 OK response,
//       // throw an exception.
//       throw Exception('Failed to load data');
//     }
//   }

  Future<Map<String, String?>> getDeviceInfo() async {
    var deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      var iosDeviceInfo = await deviceInfo.iosInfo;
      return {
        'deviceId': iosDeviceInfo.identifierForVendor, // unique ID on iOS
        'model': iosDeviceInfo.model, // device model on iOS
        'version': iosDeviceInfo.systemVersion // iOS version
      };
    } else if (Platform.isAndroid) {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      return {
        'deviceId': androidDeviceInfo.androidId, // unique ID on Android
        'model': androidDeviceInfo.model, // device model on Android
        'version': androidDeviceInfo.version.release // Android version
      };
    }
    return {'deviceId': null, 'model': null, 'version': null};
  }
}
