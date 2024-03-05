// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:convert';

import 'package:fedsecure/hive_Database/HiveHelper.dart';
import 'package:fedsecure/ui/Messages/ViewMessageModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class ViewMessageWidget extends StatefulWidget {
  int? messageID;
  String? message;
  String? messageTime;

  ViewMessageWidget(
      {this.messageID, this.message, this.messageTime, super.key});

  @override
  State<ViewMessageWidget> createState() => _ViewMessageWidgetState();
}

class _ViewMessageWidgetState extends State<ViewMessageWidget> {
  late ViewMessageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  var mobile_num, deviceID, param = '';

  @override
  void initState() {
    print(widget.messageID);
    super.initState();
    _model = ViewMessageModel();

    init();
  }

  Future<void> init() async {
    mobile_num = await HiveHelper.getData('mobileNumber_stored');
    deviceID = await HiveHelper.getData('deviceId_stored');

    callparam();
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
        backgroundColor: Color(0xFFFAFAFA),
        body: SafeArea(
          top: true,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                width: double.infinity,
                height: 40,
                decoration: BoxDecoration(
                  color: Color(0xFFFAFAFA),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(
                            context); // This will navigate back to the previous page
                      },
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(15, 0, 0, 0),
                        child: Icon(
                          Icons.arrow_back_rounded,
                          color: Colors.black,
                          size: 24,
                        ),
                      ),
                    ),

                    // Padding(
                    //   padding: EdgeInsetsDirectional.fromSTEB(15, 0, 0, 0),
                    //   child: Text(
                    //     'Message',
                    //     style: TextStyle(
                    //       fontFamily: 'Roboto',
                    //       color: Color(0xFF383C48),
                    //       fontSize: 16,
                    //       fontWeight: FontWeight.w500,
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),
              Flexible(
  child: Padding(
    padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
    child: Column(
      children: [
        Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Container(
                constraints: BoxConstraints(minHeight: 50),
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 216, 216, 216),
                ),
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Text(
                    '${widget.message}',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      color: Color(0xFF333333),
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 10), // Add some space between the message and the time
        Text(
          '${widget.messageTime}',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'Roboto',
            color: Color(0xFF333333),
            fontSize: 10,
            fontWeight: FontWeight.normal,
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
    );
  }

  void callparam() {
    param = '$mobile_num~$deviceID~${widget.messageID}';

    String AlertApp = "AlertApp";
    String adapfunction = "userViewedMsgID";
    String encryptkey = "";

    List<String> valuesList = [AlertApp, adapfunction, param, encryptkey];
    print(valuesList);
    // Convert the list to a JSON string
    String jsonString = jsonEncode(valuesList);
    print("js- $jsonString");

    if (!jsonString.isEmpty) {
      calluserViewedMsgID(jsonString);
    } else {
      print(jsonString);
    }
  }

  Future calluserViewedMsgID(String requestJS) async {
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

        // String msg = responseParamString['statusdesc'];

        // if (responseParamString['status'] == true) {
        //   _model.showToast(msg);
        // } else {
        //   _model.showToast(msg);
        //   print('API call was successful, but status is not true');
        // }
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
