// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api, prefer_const_literals_to_create_immutables, sort_child_properties_last, deprecated_member_use, use_build_context_synchronously

import 'dart:convert';

import 'package:fedsecure/hive_Database/HiveHelper.dart';
import 'package:fedsecure/ui/onBoarding/mpin/SetMPINWidget.dart';
import 'package:fedsecure/ui/onBoarding/simSelection/SimSelectionModel.dart';
import 'package:fedsecure/utils/alerts/SmsLoadingWidget.dart';
import 'package:flutter/material.dart';
import 'package:telephony/telephony.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

onBackgroundMessage(SmsMessage message) {
  debugPrint("onBackgroundMessage called");
}

class SimSelectionWidget extends StatefulWidget {
  const SimSelectionWidget({Key? key}) : super(key: key);

  @override
  _SimSelectionWidgetState createState() => _SimSelectionWidgetState();
}

class _SimSelectionWidgetState extends State<SimSelectionWidget> {
  late SimSelectionModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  String activeSim = '';
  var mobile_num, msgString, param = '';
  String _message = "";
  final telephony = Telephony.instance;

  final SmsSendStatusListener listener = (SendStatus status) {
    // Handle the status

    print(status);
  };

  bool loading = false;

  @override
  void initState() {
    super.initState();
    _model = SimSelectionModel();

    init();
  }

  Future<void> initPlatformState() async {}
  // Platform messages may fail, so we use a try/catch PlatformException.
  // If the widget was removed from the tree while the asynchronous platform
  // message was in flight, we want to discard the reply rather than calling
  // setState to update our non-existent appearance.

  //   final bool? result = await telephony.requestPhoneAndSmsPermissions;
  //
  //   if (result != null && result) {
  //     telephony.listenIncomingSms(
  //         onNewMessage: onMessage, onBackgroundMessage: onBackgroundMessage);
  //   }
  //   if (!mounted) return;
  // }

  Future<void> init() async {
    mobile_num = await HiveHelper.getData('mobileNumber_stored');
    msgString = await HiveHelper.getData('encryptedDeviceId_stored');
  }

  onMessage(SmsMessage message) async {
    setState(() {
      _message = message.body ?? "Error reading message body.";
    });
  }

  onSendStatus(SendStatus status) {
    print(status);
    setState(() {
      _message = status == SendStatus.SENT ? "sent" : "delivered";
    });
    print(_message);
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
                        'SIM Card',
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
                        'Selection',
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
                                'Registration for the Application will be \n associated with the mobile number and \n Selected SIM',
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2
                                    ?.copyWith(
                                      color: Color(0xFFFAFAFA),
                                      fontSize: 12,
                                      fontWeight: FontWeight.normal,
                                    ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              GestureDetector(
                                onTap: () => setActiveSim('SIM 1', context),
                                child: Container(
                                  width: 100,
                                  height: 110,
                                  decoration: BoxDecoration(
                                    color: Color(0x00FFFFFF),
                                    image: DecorationImage(
                                      fit: BoxFit.contain,
                                      image: AssetImage(
                                        activeSim == 'SIM 1'
                                            ? 'assets/images/sim_shape_orange.png'
                                            : 'assets/images/sim_shape_blue.png',
                                      ),
                                    ),
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(0),
                                        child: Image.asset(
                                          'assets/images/sim_icon.png',
                                          width: 28,
                                          height: 35,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0, 4, 0, 0),
                                        child: Text(
                                          'SIM 1',
                                          style: TextStyle(
                                            fontFamily: 'Roboto',
                                            color: Color(0xFFFAFAFA),
                                            fontSize: 12,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () => setActiveSim('SIM 2', context),
                                child: Container(
                                  width: 100,
                                  height: 110,
                                  decoration: BoxDecoration(
                                    color: Color(0x00FFFFFF),
                                    image: DecorationImage(
                                      fit: BoxFit.contain,
                                      image: AssetImage(
                                        activeSim == 'SIM 2'
                                            ? 'assets/images/sim_shape_orange.png'
                                            : 'assets/images/sim_shape_blue.png',
                                      ),
                                    ),
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(0),
                                        child: Image.asset(
                                          'assets/images/sim_icon.png',
                                          width: 28,
                                          height: 35,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0, 4, 0, 0),
                                        child: Text(
                                          'SIM 2',
                                          style: TextStyle(
                                            fontFamily: 'Roboto',
                                            color: Color(0xFFFAFAFA),
                                            fontSize: 12,
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
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 35, 0, 25),
                          child: ElevatedButton(
                            onPressed: loading
                                ? null
                                : () async {
                                    setState(() {
                                      loading = true;
                                    });
                                    await Future.delayed(Duration(seconds: 8));
                                    print('Button pressed ..1111.');
                                    setState(() {
                                      loading = false;
                                    });
                                    param = '$mobile_num';
                                    String AlertApp = "AlertApp";
                                    String adapfunction = "checkSmsStatus";
                                    String encryptkey = "";
                                    List<String> valuesList = [
                                      AlertApp,
                                      adapfunction,
                                      param,
                                      encryptkey
                                    ];
                                    print(valuesList);
                                    // Convert the list to a JSON string
                                    String jsonString = jsonEncode(valuesList);
                                    print("js- $jsonString");

                                    if (!jsonString.isEmpty) {
                                      callcheckSmsStatus(jsonString);
                                    } else {
                                      print(jsonString);
                                    }
                                  },
                            child: loading
                                ? CircularProgressIndicator()
                                : Text(
                                    'Proceed',
                                    style: TextStyle(
                                      fontFamily: 'Roboto',
                                      color: Colors.white,
                                    ),
                                  ),
                            style: ElevatedButton.styleFrom(
                              primary:
                                  Color(0xFFF99300), // Button background color
                              onPrimary: Colors.white, // Text color
                              minimumSize: Size(250, 45),
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
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
                        )
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

  // void setActiveSim(String simNumber) {
  //   setState(() {
  //     if (activeSim != simNumber) {
  //       activeSim = simNumber;
  //       print('$simNumber is active');

  //        sendSMS("7506754717", msgString);

  //     }
  //   });
  // }

  void setActiveSim(String simNumber, BuildContext context) {
    setState(() {
      if (activeSim != simNumber) {
        activeSim = simNumber;
        print('$simNumber is active');

        dialog();
        //sendSMS("7506754717", msgString);

        // Simulating SMS sending delay of 5 seconds
        Future.delayed(Duration(seconds: 5), () {
          Navigator.of(context).pop(); // Dismiss the dialog after 5 seconds
        });
      }
    });
  }

  Future<void> sendSMS(String phoneNumber, String message) async {
    telephony.sendSms(
      to: phoneNumber,
      message: message,
      statusListener: onSendStatus,
      // statusListener: listener
    );

    // final Uri uri = Uri(
    //   scheme: 'sms',
    //   path: phoneNumber,
    //   queryParameters: {'body': message},
    // );
    //
    // if (await canLaunch(uri.toString())) {
    //   await launch(uri.toString());
    // } else {
    //   print('Could not launch SMS');
    // }
  }

  Future callcheckSmsStatus(String requestJS) async {
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

        String msg = responseParamString['statusdesc'];

        if (responseParamString['status'] == true) {
          _model.showToast(msg);

          Navigator.pop(context); // Close the current widget
          Navigator.push(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) =>
                  SetMPINWidget(),
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
      } else {
        print('API call was not successful');
      }
    } else {
      // If the server did not return a 200 OK response,
      // throw an exception.
      throw Exception('Failed to load data');
    }
  }

  void dialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Color(0xFF00468F),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.zero,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                'assets/images/Icon.png',
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

    sendSMS("7506754717", msgString);
  }
}
