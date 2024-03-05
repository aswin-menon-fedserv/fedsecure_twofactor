// ignore_for_file: library_private_types_in_public_api, prefer_const_literals_to_create_immutables, prefer_const_constructors, sort_child_properties_last

import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:fedsecure/hive_Database/HiveHelper.dart';
import 'package:fedsecure/services/ApiConstants.dart';
import 'package:fedsecure/services/ApiService.dart';
import 'package:fedsecure/ui/onBoarding/authentication/DeviceAuthModel.dart';
import 'package:fedsecure/ui/onBoarding/simSelection/SimSelectionWidget.dart';
import 'package:fedsecure/utils/RSAHelper.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pointycastle/asymmetric/api.dart';

class DeviceAuthWidget extends StatefulWidget {
  const DeviceAuthWidget({Key? key}) : super(key: key);

  @override
  _DeviceAuthWidgetState createState() => _DeviceAuthWidgetState();
}

class _DeviceAuthWidgetState extends State<DeviceAuthWidget> {
  late DeviceAuthModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  var appID,
      deviceId,
      deviceModel,
      encryptedDeviceId,
      encryptedDeviceIdBase64,
      first10encryptedDeviceIdBase64,
      networkStatus_stored,
      mobileNumber_stored;

  @override
  void initState() {
    super.initState();
    _model = DeviceAuthModel();

    networkStatus_stored = HiveHelper.getData('networkStatus_stored');
    appID = HiveHelper.getData('appID_stored');
    mobileNumber_stored = HiveHelper.getData('mobileNumber_stored');

    print("vals-  $networkStatus_stored, $appID, $mobileNumber_stored");
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
                    color: Color(0xFFFFFFFF),
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
                                color: Color(0xFFFFFFFF),
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
                                  color: Color(0xFFFFFFFF),
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
                    padding: EdgeInsetsDirectional.fromSTEB(35, 25, 0, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          'Device',
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
                                  'Please ensure to turn off your Wi-Fi and \nswitch to mobile data as per the NPCI \nguidelines for UPI device authentication.',
                                  textAlign: TextAlign.start,
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
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(0),
                                  child: Image.asset(
                                    'assets/images/auth_one.png',
                                    width: 28,
                                    height: 28,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      15, 0, 0, 0),
                                  child: Text(
                                    'We need to send an SMS from the mobile \nnumber linked to your bank account. \nStandard operator charges will apply.',
                                    textAlign: TextAlign.start,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText2
                                        ?.copyWith(
                                          fontFamily: 'Readex Pro',
                                          color: Color(0xFFFAFAFA),
                                          fontSize: 10,
                                        ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: 250,
                                  height: 1,
                                  decoration: BoxDecoration(
                                    color: Color(0xCBFFFFFF),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(0),
                                  child: Image.asset(
                                    'assets/images/auth_two.png',
                                    width: 28,
                                    height: 28,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      15, 0, 0, 0),
                                  child: Text(
                                    'To ensure a secure mobile banking \nexperience, please keep your registered \nSIM card inserted in the device while \nconducting transactions via FedMobile.',
                                    textAlign: TextAlign.start,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText2
                                        ?.copyWith(
                                          fontFamily: 'Readex Pro',
                                          color: Color(0xFFFAFAFA),
                                          fontSize: 10,
                                        ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 30, 0, 25),
                            child: ElevatedButton(
                              onPressed: () {
                                print('Button pressed ...');

                                Navigator.pop(
                                    context); // Close the current widget
                                Navigator.push(
                                  context,
                                  PageRouteBuilder(
                                    pageBuilder: (context, animation,
                                            secondaryAnimation) =>
                                        SimSelectionWidget(),
                                    transitionsBuilder: (context, animation,
                                        secondaryAnimation, child) {
                                      var begin = Offset(1.0,
                                          0.0); // Change this to modify the direction of the slide
                                      var end = Offset.zero;
                                      var curve = Curves.ease;
                                      var tween = Tween(begin: begin, end: end)
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
                              },
                              child: Text(
                                'Proceed',
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
}
