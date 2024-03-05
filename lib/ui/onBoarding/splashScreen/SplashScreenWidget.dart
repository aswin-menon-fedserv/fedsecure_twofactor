// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, library_private_types_in_public_api

import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:fedsecure/hive_Database/HiveHelper.dart';
import 'package:fedsecure/ui/Home/HomeWidget.dart';
import 'package:fedsecure/ui/onBoarding/authentication/AuthenticationWidget.dart';
import 'package:fedsecure/ui/onBoarding/mpin/LoginWidget.dart';
import 'package:fedsecure/ui/onBoarding/splashScreen/SplashScreenModel.dart';
import 'package:flutter/material.dart';

class SplashScreenWidget extends StatefulWidget {
  const SplashScreenWidget({Key? key}) : super(key: key);

  @override
  _SplashScreenWidgetState createState() => _SplashScreenWidgetState();
}

class _SplashScreenWidgetState extends State<SplashScreenWidget> {
  late SplashScreenModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  var networkStatus, LoginStatus = "", appID, login_StatusChk;

  @override
  void initState() {
    super.initState();
    _model = SplashScreenModel();
    init();

 login_StatusChk = HiveHelper.getData('log_Status');

 print('log status  : $login_StatusChk');

    Future.delayed(Duration(seconds: 3), () {
      if (login_StatusChk == 'true') {
        Navigator.of(context).pop();
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => LoginWidget()));

        // FlutterNativeSplash.remove();
      } else {
        Navigator.of(context).pop();
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => AuthenticationWidget()));
      }
    });
  }

  Future<void> init() async {
    //LoginStatus = await HiveHelper.getData('LoginStatus_stored');

    networkStatus = await getNetworkStatus();
    HiveHelper.saveData('networkStatus_stored', networkStatus);

    if (Platform.isAndroid) {
      appID = "11";
      print('Running on Android');
    } else if (Platform.isIOS) {
      appID = "12";
      print('Running on iOS');
    } else {
      print('Running on neither Android nor iOS');
    }
    HiveHelper.saveData('appID_stored', appID);
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
      child: WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          key: scaffoldKey,
          backgroundColor: Color(0xFF00468F),
          body: SafeArea(
            top: true,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: Container(
                    width: double.infinity,
                    height: 100,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Color(0xFF004E98), // start color
                          Color(0xFF00387D), // middle color
                          Color(0xFF004E98), // end color
                        ],
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(0),
                              child: Image.asset(
                                'assets/images/splash_logo.png',
                                width: 80,
                                height: 84,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 24, 0, 0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 200,
                                height: 2,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                    colors: [
                                      Color.fromRGBO(217, 217, 217,
                                          0.0), // rgba(217, 217, 217, 0.00) at 0%
                                      Color.fromRGBO(255, 255, 255,
                                          0.9), // rgba(255, 255, 255, 0.90) at 50.42%
                                      Color.fromRGBO(217, 217, 217,
                                          0.0), // rgba(217, 217, 217, 0.00) at 100%
                                    ],
                                    stops: [
                                      0.0,
                                      0.5042,
                                      1.0
                                    ], // Stops at respective percentages
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Fed',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                      fontFamily: 'Roboto',
                                      color: Color(0xFFFAFAFA),
                                      fontSize: 28,
                                      letterSpacing: 1.4,
                                      fontWeight: FontWeight.w500,
                                    ),
                              ),
                              Text(
                                'Secure',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                      fontFamily: 'Roboto',
                                      color: Color(0xFFF99300),
                                      fontSize: 28,
                                      letterSpacing: 1.4,
                                      fontWeight: FontWeight.w500,
                                    ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 30, 0, 0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width:
                                    150, // Specify the width of the progress bar.
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(
                                      5), // Set the corner radius here
                                  child: LinearProgressIndicator(
                                    backgroundColor: Color(0xFF335D91),
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      Color(
                                          0xFFF99300), // Color of the progress bar (#F99300)
                                    ),
                                    // value: 0.5, // Uncomment and set a value to indicate progress (0.0 to 1.0)
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
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<String> getNetworkStatus() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      // Connected to a mobile network or wifi
      return 'Y';
    } else {
      // Not connected to the internet
      return 'N';
    }
  }
}
