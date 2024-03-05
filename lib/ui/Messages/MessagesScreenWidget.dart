// ignore_for_file: prefer_const_constructors

import 'dart:convert';
import 'dart:io';
import 'package:fedsecure/ui/Messages/MessagesScreenModel.dart';
import 'package:fedsecure/ui/Messages/ViewMessageWidget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

import '../../hive_Database/HiveHelper.dart';
import '../onBoarding/authentication/DeviceAuthWidget.dart';
import 'package:device_info_plus/device_info_plus.dart';

import 'model_class.dart';

class MessagesScreenWidget extends StatefulWidget {
  String name;
  MessagesScreenWidget(this.name, {Key? key}) : super(key: key);

  @override
  _MessagesScreenWidgetState createState() => _MessagesScreenWidgetState();
}

class _MessagesScreenWidgetState extends State<MessagesScreenWidget> {
  late MessagesScreenModel _model;
  List<Messages>? messages;
  List<Messages>? txn;
  bool messageStatus = false;
  var param = '';
  var mobNo,
      time,
      count,
      appID,
      deviceId,
      deviceModel,
      deviceVersion,
      deviceFCMid = null,
      encryptedDeviceId,
      encryptedDeviceIdBase64,
      first10encryptedDeviceIdBase64,
      networkStatus_stored,
      mobileNumber_stored;

  var sms_encrypted =
      'FEDALRT YWhzamVrd2xhb3Npcm13bm6NmlDr/amhmITMKkyTNoXcpf4Ti+6JLksgvcmTuYET';

  bool isLoading = false;

  bool loader = true;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  bool txnState = false;

  @override
  void initState() {
    super.initState();
    _model = MessagesScreenModel();
    messages = [];
    txn = [];
    print("hiiiiiiiiiii");
    init();
  }

  Future<void> init() async {
    deviceId = HiveHelper.getData('deviceId_stored');
    mobNo = HiveHelper.getData('mobileNumber_stored');
    final now = DateTime.now();
    time = DateFormat('dd-MMM-yy hh.mm.ss.SSSSSSSSS a').format(now);
    count = 0;
    param = '$mobNo~$deviceId~$time~$count';

    String AlertApp = "AlertApp";
    String adapfunction = "refreshSms";
    String encryptkey = "";
    print(param);
    List<String> valuesList = [
      AlertApp,
      adapfunction,
      param,
      encryptkey,
    ];
    print(valuesList);
    // Convert the list to a JSON string
    String jsonString = jsonEncode(valuesList);
    print("js- $jsonString");
    callNotificationList(jsonString);
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(15, 0, 0, 0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(
                          Icons.arrow_back_rounded,
                          color: const Color(0xFF57636C),
                          size: 24,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(15, 0, 0, 0),
                      child: Text(
                        widget.name,
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          color: Color(0xFF383C48),
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
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
              loader == true
                  ? CircularProgressIndicator()
                  : messageStatus == true
                      ? Expanded(
                          child: Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                              child:
                                  // widget.name=='Messages'?
                                  messages!.length <= 0
                                      ? Center(
                                          child: Container(
                                          child: Text("No data avalable"),
                                        ))
                                      : Container(
                                          width: double.infinity,
                                          height: 100,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                          ),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Expanded(
                                                  child: buildMessageListView(
                                                      messages!)),
                                              // parseStringToListOfMaps()
                                            ],
                                          ),
                                        )
                              // :Container(
                              //   width: double.infinity,
                              //   height: 100,
                              //   decoration: BoxDecoration(
                              //     color: Colors.white,
                              //   ),
                              //   child: Column(
                              //     mainAxisSize: MainAxisSize.max,
                              //     children: [
                              //       Expanded(child: buildMessageListView(txn!)),
                              //       // parseStringToListOfMaps()
                              //     ],
                              //   ),
                              // ),
                              ),
                        )
                      : Center(
                          child: Container(
                          child: Text("No data avalable"),
                        ))
            ],
          ),
        ),
      ),
    );
  }

  ListView buildMessageListView(List<Messages> message) {
    return ListView(
      reverse: true,
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      children: messages!.map((message) {
        return Padding(
          padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
          child: GestureDetector(
            onTap: () {
              if (message.message != null && message.messageId != null) {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        ViewMessageWidget(
                            message: message.message,
                            messageID: message.messageId,
                            messageTime: message.messagetime),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                      var begin = Offset(1.0, 0.0);
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
                    transitionDuration: Duration(milliseconds: 500),
                  ),
                );
              }

              ///

              // if(messages.messageId!=null)
              // {
              //   // ViewMessageWidget(messages![0].messageId);
              // }
            },
            child: Container(
              width: double.infinity,
              height: 75,
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(15, 0, 15, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 45,
                              height: 45,
                              decoration: BoxDecoration(
                                color: Color(0xFF1B6CBE),
                                shape: BoxShape.circle,
                              ),
                              alignment: AlignmentDirectional(0, 0),
                              child: Image.asset(
                                'assets/images/fedicon.png',
                                width: 24,
                                height: 24,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ],
                        ),
                        Expanded(
                          child: Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        widget.name == 'OTP'
                                            ? 'AD-FEDOTP'
                                            : 'AD-FEDBNK',
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontFamily: 'Roboto',
                                          color: Color(0xFF383C48),
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      // 'Sep 16, 12:31'
                                      message.messagetime.toString(),
                                      style: TextStyle(
                                        fontFamily: 'Roboto',
                                        color: Color(0xFFBFBFBF),
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                                SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    mainAxisSize: MainAxisSize
                                        .min, // Set to min to keep the content on a single line
                                    children: [
                                      Text(
                                        // 'Federal Bank Online Loan Application and is ...',
                                        message.message.toString(),
                                        style: TextStyle(
                                          fontFamily: 'Roboto',
                                          color: Color(0xFF65686D),
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(4, 0, 0, 0),
                              child: Container(
                                width: 5,
                                height: 5,
                                decoration: BoxDecoration(
                                  color: Color(0xFF1B6CBE),
                                  shape: BoxShape.circle,
                                ),
                                alignment: AlignmentDirectional(0, 0),
                              ),
                            ),
                          ],
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
        );
      }).toList(),
    );
  }

  Future callNotificationList(String requestJS) async {
    // Decode the requestJS parameter
    String decodedRequestJS = Uri.decodeFull(requestJS);

    // Construct the URL with the decoded parameter
    final url = Uri.parse(
        'https://may-i-lozthqfyea-el.a.run.app/fedsecureapp/mobilebanking/invoke?adapter=AlertApp&procedure=requestparam&parameters=$requestJS');
    print(url);
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
      print(jsonResponse);

      print(jsonResponse['responseParam']['status']);

      print(jsonResponse['responseParam']['messages']);

      if (jsonResponse['responseParam']['status']) {
        print("truee");
        setState(() {
          messageStatus = true;
        });
        NotificationTXN bankMessage = NotificationTXN.fromJson(jsonResponse);
        if (bankMessage.responseParam!.messages!.length > 0) {
          // Accessing the populated list of messages
          setState(() {
            if (widget.name == 'OTP') {
              print("OTP...........");
              if (messages != null || messages!.isNotEmpty) {
                messages!.clear();
              }
              messages = bankMessage.responseParam!.messages!
                  .where((element) => element.category == 'OTP')
                  .toList();
              print(txn!.length);
            } else {
              if (messages != null || messages!.isNotEmpty) {
                messages!.clear();
              }
              messages = bankMessage.responseParam!.messages;
// Now the messages are sorted in ascending order based on their messagetime
              print(messages); // Or use the sorted messages as needed
              print("Sorted messages based on messagetime: $messages");
            }
            txn = bankMessage.responseParam!.messages!
                .where((element) => element.category == 'OTP')
                .toList();
            print(txn!.length);

            if (txn!.length > 0) {
              setState(() {
                txnState = true;
              });
            } else {
              setState(() {
                txnState = false;
              });
            }
          });

          print(messages);
          print('fffffffff');
          print(messages != null);

          for (Messages msg in messages!) {
            print(
                "Message ID: ${msg.messageId}, Category: ${msg.category}, Message: ${msg.message}");
          }
        } else {
          print("length is Zero");
          setState(() {
            messageStatus = false;
          });
        }
      } else {
        // If the server did not return a 200 OK response,
        // throw an exception.
        setState(() {
          messageStatus = false;
        });
        print("messageStatus false");
        print(messageStatus);
      }
    } else {
      throw Exception('Failed to load data');
    }
    Future.delayed(Duration(seconds: 6));
    setState(() {
      loader = false;
    });
  }
  // Future<Map<String, String?>> getDeviceInfo() async {
  //   var deviceInfo = DeviceInfoPlugin();
  //   if (Platform.isIOS) {
  //     var iosDeviceInfo = await deviceInfo.iosInfo;
  //     return {
  //       'deviceId': iosDeviceInfo.identifierForVendor, // unique ID on iOS
  //       'model': iosDeviceInfo.model, // device model on iOS
  //       'version': iosDeviceInfo.systemVersion // iOS version
  //     };
  //   } else if (Platform.isAndroid) {
  //     var androidDeviceInfo = await deviceInfo.androidInfo;
  //     return {
  //       'deviceId': androidDeviceInfo.androidId, // unique ID on Android
  //       'model': androidDeviceInfo.model, // device model on Android
  //       'version': androidDeviceInfo.version.release // Android version
  //     };
  //   }
  //   return {'deviceId': null, 'model': null, 'version': null};
  // }
// ListView buildListView(List<Messages> items) {
//   return ListView(
//     padding: EdgeInsets.zero,
//     scrollDirection: Axis.horizontal,
//     children: items.map((item) {
//       return Padding(
//         padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
//         child: Container(
//           width: 100,
//           height: double.infinity,
//           decoration: BoxDecoration(
//             color: item.category == 'TXN'
//                 ? Color(0xFF034B9C)
//                 : Color(0xFFC0D5ED),
//             borderRadius: BorderRadius.circular(30),
//           ),
//           alignment: AlignmentDirectional(0, 0),
//           child: Text(
//             item.message.toString(),
//             style: TextStyle(
//               fontFamily: 'Roboto',
//               color: item.category == 'TXN'
//                   ? Color(0xFFFAFAFA)
//                   : Color(0xFF034B9C),
//               fontSize: 12,
//               fontWeight: FontWeight.w500,
//             ),
//           ),
//         ),
//       );
//     }).toList(),
//   );
//
//
// }
}
