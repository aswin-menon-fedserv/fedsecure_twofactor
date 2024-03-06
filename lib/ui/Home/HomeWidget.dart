// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_import, library_private_types_in_public_api, use_full_hex_values_for_flutter_colors

import 'dart:convert';

import 'package:fedsecure/hive_Database/HiveHelper.dart';
import 'package:fedsecure/ui/AppSettings/AppSettingsWidget.dart';
import 'package:fedsecure/ui/Home/HomeModel.dart';
import 'package:fedsecure/ui/Messages/MessagesScreenWidget.dart';
import 'package:fedsecure/ui/ca_auth/CaRegisteringWidget.dart';
import 'package:fedsecure/utils/Webview/WebViewWidget.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart'
    as smooth_page_indicator;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({Key? key}) : super(key: key);

  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  late HomeModel _model;
  static const platform = MethodChannel('com.federal.fedsecure/root');
  final scaffoldKey = GlobalKey<ScaffoldState>();

  final TextEditingController _controller = TextEditingController();

  Map<String, String> textValues = {
    "txtName": "Welcome To Fedsecure",
  };

  var mobile_num, param = '';

  @override
  void initState() {
    super.initState();
    _model = HomeModel();

    init();
    
  }

  Future<void> init() async {
    mobile_num = await HiveHelper.getData('mobileNumber_stored');

    setState(() {
      _controller.text = textValues["txtName"]!;
    });

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

    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Color(0xFFFAFAFA),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(),
              child: Stack(
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: Container(
                          width: double.infinity,
                          height: 100,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.fill,
                              image: Image.asset(
                                'assets/images/banner.png',
                              ).image,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          width: double.infinity,
                          height: 100,
                          decoration: BoxDecoration(
                            color: Color(0xCBFFFFFF),
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(0),
                              bottomRight: Radius.circular(0),
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    width: double.infinity,
                    height: double.infinity,
                    decoration: BoxDecoration(),
                    child: Container(
                      width: double.infinity,
                      height: double.infinity,
                      decoration: BoxDecoration(
                        color: Color(0x00FFFFFF),
                      ),
                      child: Stack(
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        25, 50, 0, 0),
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
                                          color: Color(0x00FFFFFF),
                                          image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: Image.asset(
                                              'assets/images/pattern_head_rev.png',
                                            ).image,
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Container(
                            width: double.infinity,
                            height: double.infinity,
                            decoration: BoxDecoration(
                              color: Color(0x00FFFFFF),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Expanded(
                                  child: Container(
                                    width: double.infinity,
                                    height: 100,
                                    decoration: BoxDecoration(
                                      color: Color(0x00FFFFFF),
                                    ),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  25, 0, 0, 0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Text(
                                                'Hello..',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge
                                                    ?.copyWith(
                                                      fontFamily: 'Roboto',
                                                      color: Color(0xFFF99300),
                                                      fontSize: 23,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        // Padding(
                                        //   padding:
                                        //       EdgeInsetsDirectional.fromSTEB(
                                        //           25, 0, 0, 25),
                                        //   child:
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.85,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.08,
                                          child: Row(
                                            // mainAxisSize: MainAxisSize.max,
                                            children: [
                                              SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.80,
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.12,
                                                child: AutoSizeText(
                                                  maxLines: 1,
                                                  textValues["txtName"]!,
                                                  style: TextStyle(
                                                    fontFamily: 'Roboto',
                                                    color: Color(0xFF00387D),
                                                    fontSize: 22,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ),
                                              // Padding(
                                              //   padding: EdgeInsetsDirectional
                                              //       .fromSTEB(10, 0, 0, 0),
                                              //   child: Icon(
                                              //     Icons.edit_outlined,
                                              //     color: Color(0xFF00387D),
                                              //     size: 24,
                                              //   ),
                                              // ),
                                            ],
                                          ),
                                        ),
                                        // ),
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    width: double.infinity,
                                    height: 100,
                                    decoration: BoxDecoration(
                                      color: Color(0x00FFFFFF),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          15, 0, 15, 0),
                                      child: Container(
                                        width: double.infinity,
                                        height: 500,
                                        child: Stack(
                                          children: [
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(0, 0, 0, 40),
                                              child: PageView(
                                                controller: _model
                                                        .pageViewController ??=
                                                    PageController(
                                                        initialPage: 0),
                                                scrollDirection:
                                                    Axis.horizontal,
                                                children: [
                                                  ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                    child: Image.asset(
                                                      'assets/images/Slider_image.png',
                                                      width: 300,
                                                      height: 200,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                  ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                    child: Image.asset(
                                                      'assets/images/Slider_image_two.png',
                                                      width: 300,
                                                      height: 200,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                  ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                    child: Image.asset(
                                                      'assets/images/Slider_image.png',
                                                      height: 200,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Align(
                                              alignment:
                                                  AlignmentDirectional(0, 1),
                                              child: Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(16, 0, 0, 16),
                                                child: smooth_page_indicator
                                                    .SmoothPageIndicator(
                                                  controller: _model
                                                          .pageViewController ??=
                                                      PageController(
                                                          initialPage: 0),
                                                  count: 3,
                                                  axisDirection:
                                                      Axis.horizontal,
                                                  onDotClicked: (i) async {
                                                    await _model
                                                        .pageViewController!
                                                        .animateToPage(
                                                      i,
                                                      duration: Duration(
                                                          milliseconds: 500),
                                                      curve: Curves.ease,
                                                    );
                                                  },
                                                  effect: smooth_page_indicator
                                                      .SlideEffect(
                                                    spacing: 8,
                                                    radius: 16,
                                                    dotWidth: 10,
                                                    dotHeight: 10,
                                                    dotColor:
                                                        Color(0xFF4C4B39EF),
                                                    activeDotColor:
                                                        Color(0xFF4B39EF),
                                                    paintStyle:
                                                        PaintingStyle.fill,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
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
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    width: double.infinity,
                    height: 140,
                    decoration: BoxDecoration(
                      color: Color(0xFFFFFFFF),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
                          child: GestureDetector(
                            onTap: () async {
                              // Add your click/tap functionality here
                              print('Container clicked ...');


                              try {
                                await platform
                                    .invokeMethod('startAuth', '6546464');
                              } on PlatformException catch (e) {
                                // Handle potential platform exceptions
                                // print("Error: ${e.message}");
                              }
                               // Navigator.push(
                               //              context,
                               //              PageRouteBuilder(
                               //                pageBuilder: (context, animation,
                               //                        secondaryAnimation) =>
                               //                    CaRegisteringWidget(),
                               //                transitionsBuilder: (context,
                               //                    animation,
                               //                    secondaryAnimation,
                               //                    child) {
                               //                  var begin = Offset(1.0, 0.0);
                               //                  var end = Offset.zero;
                               //                  var curve = Curves.ease;
                               //
                               //                  var tween = Tween(
                               //                          begin: begin, end: end)
                               //                      .chain(CurveTween(
                               //                          curve: curve));
                               //                  var offsetAnimation =
                               //                      animation.drive(tween);
                               //
                               //                  return SlideTransition(
                               //                    position: offsetAnimation,
                               //                    child: child,
                               //                  );
                               //                },
                               //                transitionDuration:
                               //                    Duration(milliseconds: 500),
                               //              ),
                               //            );
                            },
                            child: Container(
                              width: double.infinity,
                              height: 60,
                              decoration: BoxDecoration(
                                color: Color(0xFFFFFFFF),
                                borderRadius: BorderRadius.circular(
                                    6), // Add this line for corner radius
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage(
                                      'assets/images/highlight_blue_bg.png'),
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.asset(
                                      'assets/images/auth_lock_bg.png',
                                      width: 28,
                                      height: 32,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Text(
                                    'TWO-FACTOR AUTHENTICATION (2FA)',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1
                                        ?.copyWith(
                                          fontFamily: 'Roboto',
                                          color: Color(0xFF0451A3),
                                          fontSize: 10,
                                          fontWeight: FontWeight.w500,
                                        ),
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios,
                                    color: Color(0xFF0452A3),
                                    size: 20,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      height: 100,
                      decoration: BoxDecoration(
                        color: Color(0xFFFFFFFF),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: Image.asset(
                            'assets/images/banner_blue_bg.png',
                          ).image,
                        ),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(0),
                          bottomRight: Radius.circular(0),
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                      ),
                      child: Stack(
                        alignment: AlignmentDirectional(1, 1),
                        children: [
                          Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Expanded(
                                child: Container(
                                  width: double.infinity,
                                  height: 100,
                                  decoration: BoxDecoration(),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          // Your onTap logic goes here
                                          print('Button pressed ...');
                                          Navigator.push(
                                            context,
                                            PageRouteBuilder(
                                              pageBuilder: (context, animation,
                                                      secondaryAnimation) =>
                                                  MessagesScreenWidget(
                                                      'Messages'),
                                              transitionsBuilder: (context,
                                                  animation,
                                                  secondaryAnimation,
                                                  child) {
                                                var begin = Offset(1.0,
                                                    0.0); // Change this to modify the direction of the slide
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
                                              transitionDuration: Duration(
                                                  milliseconds:
                                                      500), // Customize the duration of the animation
                                            ),
                                          );
                                        },
                                        child: Container(
                                          width: 90,
                                          height: 100,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              fit: BoxFit.fill,
                                              image: Image.asset(
                                                'assets/images/bg_messages.png',
                                              ).image,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: 70,
                                        height: 70,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            fit: BoxFit.fill,
                                            image: Image.asset(
                                              'assets/images/footer_line.png',
                                            ).image,
                                          ),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          // Your onTap logic goes here
                                          print('Button pressed ...');

                                          Navigator.push(
                                            context,
                                            PageRouteBuilder(
                                              pageBuilder: (context, animation,
                                                      secondaryAnimation) =>
                                                  MessagesScreenWidget('OTP'),
                                              // OTPScreenWidget(),
                                              transitionsBuilder: (context,
                                                  animation,
                                                  secondaryAnimation,
                                                  child) {
                                                var begin = Offset(1.0,
                                                    0.0); // Change this to modify the direction of the slide
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
                                              transitionDuration: Duration(
                                                  milliseconds:
                                                      500), // Customize the duration of the animation
                                            ),
                                          );
                                        },
                                        child: Container(
                                          width: 90,
                                          height: 100,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              fit: BoxFit.fill,
                                              image: Image.asset(
                                                'assets/images/bg_otp.png',
                                              ).image,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                width: double.infinity,
                                height: 50,
                                decoration: BoxDecoration(),
                                child: // Generated code for this Stack Widget...
                                    Align(
                                  alignment: AlignmentDirectional(0, 0),
                                  child: Stack(
                                    alignment: AlignmentDirectional(0, 0),
                                    children: [
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            45, 0, 45, 0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Expanded(
                                              child: Container(
                                                width: 50,
                                                height: 100,
                                                decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                    fit: BoxFit.fill,
                                                    image: Image.asset(
                                                      'assets/images/orange_curve_bg.png',
                                                    ).image,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          // Handle tap action here
                                          print('Image tapped!');
                                          Navigator.push(
                                            context,
                                            PageRouteBuilder(
                                              pageBuilder: (context, animation,
                                                      secondaryAnimation) =>
                                                  MessagesScreenWidget(
                                                      'Messages'),
                                              transitionsBuilder: (context,
                                                  animation,
                                                  secondaryAnimation,
                                                  child) {
                                                const begin = Offset(0.0, 1.0);
                                                const end = Offset.zero;
                                                const curve = Curves.ease;
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
                                            ),
                                          );
                                        },
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          child: Image.asset(
                                            'assets/images/img_message.png',
                                            width: 27,
                                            height: 27,
                                            fit: BoxFit.fill,
                                            alignment: Alignment(0, 0),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          GestureDetector(
                            onTap: () {
                              // Add your click functionality here
                              print('Container clicked!');
                              const url =
                                  'https://www.federalbank.co.in/fed-alert'; // Replace with your URL
                              launch(url);
                              //  Navigator.push(
                              //               context,
                              //               PageRouteBuilder(
                              //                 pageBuilder: (context, animation,
                              //                         secondaryAnimation) =>
                              //                     WebViewWidget(),
                              //                 transitionsBuilder: (context,
                              //                     animation,
                              //                     secondaryAnimation,
                              //                     child) {
                              //                   const begin = Offset(0.0, 1.0);
                              //                   const end = Offset.zero;
                              //                   const curve = Curves.ease;
                              //                   var tween = Tween(
                              //                           begin: begin, end: end)
                              //                       .chain(CurveTween(
                              //                           curve: curve));
                              //                   var offsetAnimation =
                              //                       animation.drive(tween);
                              //                   return SlideTransition(
                              //                     position: offsetAnimation,
                              //                     child: child,
                              //                   );
                              //                 },
                              //               ),
                              //             );
                            },
                            child: Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 0, 25, 25),
                              child: Container(
                                width: 45,
                                height: 45,
                                decoration: BoxDecoration(
                                  color: Color(0xFFDDEBF9),
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                  child: Image.asset(
                                    'assets/images/img_question.png',
                                    fit: BoxFit.contain,
                                  ),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Handle floating action button press
          print('Floating action button pressed!');
          Navigator.push(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) =>
                  AppSettingsWidget(),
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
        },
        backgroundColor: Colors.transparent,
        mini: true, // Set mini to true to reduce the size
        shape: CircleBorder(), // Make the FloatingActionButton circular
        child: Padding(
          padding: EdgeInsets.all(5.0), // Adjust padding as needed
          child: Image.asset(
              'assets/images/Settings.png'), // Replace 'assets/your_image.png' with the path to your image asset
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
    );
  }

  void paramcall() {
    param = '$mobile_num';
    String AlertApp = "AlertApp";
    String adapfunction = "profiledetails";
    String encryptkey = "";
    List<String> valuesList = [AlertApp, adapfunction, param, encryptkey];
    print(valuesList);
    // Convert the list to a JSON string
    String jsonString = jsonEncode(valuesList);
    print("js- $jsonString");

    if (!jsonString.isEmpty) {
      callProfileDetails(jsonString);
    } else {
      print(jsonString);
    }
  }

  Future<void> callProfileDetails(String requestJS) async {
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
        var responseParam = jsonResponse['responseParam'];

        print(responseParam);

        bool status = responseParam['status'];

        if (status) {
          var result = responseParam['result'];

          if (result is List && result.isNotEmpty) {
            // If result is a non-empty list, proceed with data extraction
            Map<String, dynamic> data = result.first;

            String email = data['EMAIL'];
            String name = data['NAME'];
            String mobileno = data['MOBILENO'];

            await HiveHelper.saveData('name_stored', name);
            await HiveHelper.saveData('email_stored', email);
            await HiveHelper.saveData('profile_mobileno_stored', mobileno);

            if (name != null && name.isNotEmpty) {
              setState(() {
                textValues["txtName"] = name;
              });
            }
          } else {
            // Handle case where result is empty or not a list
            print('No valid data found in the result field');
          }
        } else {
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
}
