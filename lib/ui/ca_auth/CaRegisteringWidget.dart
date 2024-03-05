// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last

import 'package:fedsecure/ui/ca_auth/CaRegisteringModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CaRegisteringWidget extends StatefulWidget {
  const CaRegisteringWidget({super.key});

  @override
  State<CaRegisteringWidget> createState() => _CaRegisteringWidgetState();
}

class _CaRegisteringWidgetState extends State<CaRegisteringWidget> {
  late CaRegisteringModel _model;
  static const platform = MethodChannel('com.federal.fedsecure/root');
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = CaRegisteringModel();

    _model.textController1 ??= TextEditingController();
    _model.textFieldFocusNode1 ??= FocusNode();

    _model.textController2 ??= TextEditingController();
    _model.textFieldFocusNode2 ??= FocusNode();

    _model.textController3 ??= TextEditingController();
    _model.textFieldFocusNode3 ??= FocusNode();
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
                      color: Color(0xFFFAFAFA),
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
                                  color: Color(0xFFFAFAFA),
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
                                    color: Color(0xFFFAFAFA),
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
              height: 460,
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
                    padding: EdgeInsetsDirectional.fromSTEB(35, 30, 0, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          'Add Account',
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
                    padding: EdgeInsetsDirectional.fromSTEB(18, 25, 18, 0),
                    child: Container(
                      width: double.infinity,
                      height: 350,
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
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      20, 20, 20, 0),
                                  child: TextFormField(
                                    controller: _model.textController1,
                                    focusNode: _model.textFieldFocusNode1,
                                    textInputAction: TextInputAction.done,
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      labelText: 'Provisioning URL',
                                      labelStyle: TextStyle(
                                        fontFamily: 'Roboto',
                                        color: Color(0xFFFAFAFA),
                                        fontSize: 15,
                                      ),
                                      hintStyle: TextStyle(
                                        fontSize:
                                            15, // Assuming labelMedium is 15
                                      ),
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(
                                              0xFFCCCCCC), // Assuming alternate is a gray color
                                          width: 1,
                                        ),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0xFFF99300),
                                          width: 1,
                                        ),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      contentPadding:
                                          EdgeInsetsDirectional.fromSTEB(
                                        5,
                                        0,
                                        0,
                                        0,
                                      ),
                                      /* ... other decoration properties */
                                    ),
                                    style: TextStyle(
                                      fontFamily: 'Readex Pro',
                                      color: Color(0xFFFAFAFA),
                                      fontSize: 15,
                                    ),
                                    textAlign: TextAlign.start,
                                    keyboardType: TextInputType.text,
                                    cursorColor: Color(0xFFFAFAFA),
                                    //validator: _model.textController1Validator.asValidator(context),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      20, 20, 20, 0),
                                  child: TextFormField(
                                    controller: _model.textController2,
                                    focusNode: _model.textFieldFocusNode2,
                                    textInputAction: TextInputAction.done,
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      labelText: 'User Identifier',
                                      labelStyle: TextStyle(
                                        fontFamily: 'Roboto',
                                        color: Color(0xFFFAFAFA),
                                        fontSize: 15,
                                      ),
                                      hintStyle: TextStyle(
                                        fontSize:
                                            15, // Assuming labelMedium is 15
                                      ),
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(
                                              0xFFCCCCCC), // Assuming alternate is a gray color
                                          width: 1,
                                        ),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0xFFF99300),
                                          width: 1,
                                        ),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      contentPadding:
                                          EdgeInsetsDirectional.fromSTEB(
                                        5,
                                        0,
                                        0,
                                        0,
                                      ),
                                      // ... other decoration properties
                                    ),
                                    style: TextStyle(
                                      fontFamily: 'Readex Pro',
                                      color: Color(0xFFFAFAFA),
                                      fontSize: 15,
                                    ),
                                    textAlign: TextAlign.start,
                                    keyboardType: TextInputType.number,
                                    cursorColor: Color(0xFFFAFAFA),
                                    //validator: _model.textController2Validator.asValidator(context),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      20, 20, 20, 0),
                                  child: TextFormField(
                                    controller: _model.textController3,
                                    focusNode: _model.textFieldFocusNode3,
                                    textInputAction: TextInputAction.done,
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      labelText: 'Activation Code',
                                      labelStyle: TextStyle(
                                        fontFamily:
                                            'Roboto', // Assuming you want 'Roboto'
                                        color: Color(0xFFFAFAFA),
                                        fontSize: 15,
                                      ),
                                      hintStyle: TextStyle(
                                        fontSize:
                                            15, // Assuming labelMedium is 15
                                      ),
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(
                                              0xFFCCCCCC), // Assuming alternate is a gray color
                                          width: 1,
                                        ),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0xFFF99300),
                                          width: 1,
                                        ),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      contentPadding:
                                          EdgeInsetsDirectional.fromSTEB(
                                        5,
                                        0,
                                        0,
                                        0,
                                      ),
                                      // ... other decoration properties
                                    ),
                                    style: TextStyle(
                                      fontFamily:
                                          'Readex Pro', // Assuming you want 'Readex Pro'
                                      color: Color(0xFFFAFAFA),
                                      fontSize: 15,
                                    ),
                                    textAlign: TextAlign.start,
                                    keyboardType: TextInputType.number,
                                    cursorColor: Color(0xFFFAFAFA),
                                    // validator: _model.textController3Validator.asValidator(context),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 35, 0, 0),
                            child: ElevatedButton(
                              onPressed: () async {
                                print('Button pressed ...');


                                try {
                                  await platform
                                      .invokeMethod('startAuth', '6546464');
                                } on PlatformException catch (e) {
                                  // Handle potential platform exceptions
                                  // print("Error: ${e.message}");
                                }
                              },
                              child: Text(
                                'Submit',
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
          ],
        ),
      ),
    );
  }
}
