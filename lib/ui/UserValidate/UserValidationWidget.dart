// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api, sort_child_properties_last, deprecated_member_use, prefer_const_literals_to_create_immutables

import 'package:fedsecure/ui/UserValidate/UserValidationModel.dart';
import 'package:flutter/material.dart';

class UserValidationWidget extends StatefulWidget {
  const UserValidationWidget({Key? key}) : super(key: key);

  @override
  _UserValidationWidgetState createState() => _UserValidationWidgetState();
}

class _UserValidationWidgetState extends State<UserValidationWidget> {
  late UserValidationModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  int selectedMethodId = 1;

  @override
  void initState() {
    super.initState();
    _model = UserValidationModel();

    _model.textController1 ??= TextEditingController();
    _model.textFieldFocusNode1 ??= FocusNode();

    _model.textController2 ??= TextEditingController();
    _model.textFieldFocusNode2 ??= FocusNode();

    _model.textController3 ??= TextEditingController();
    _model.textFieldFocusNode3 ??= FocusNode();

    _model.textController4 ??= TextEditingController();
    _model.textFieldFocusNode4 ??= FocusNode();

    _model.textController5 ??= TextEditingController();
    _model.textFieldFocusNode5 ??= FocusNode();

    _model.textController6 ??= TextEditingController();
    _model.textFieldFocusNode6 ??= FocusNode();
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
        backgroundColor: Color(0xFFF1F4F8),
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
                      color: Colors.white,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(25, 40, 0, 0),
                              child: Container(
                                width: 25,
                                height: 25,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                ),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Icon(
                                    Icons.keyboard_backspace,
                                    color: Color(0xFF00387D),
                                    size: 24,
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
                                    color: Colors.white,
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
              height: 560,
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
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(35, 20, 0, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            'User Validation',
                            style: TextStyle(
                              fontFamily: 'Roboto',
                              color: Color(0xFF00387D),
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          buildPaymentMethod(
                              1, 'assets/images/card_icon.png', 'Debit Card'),
                          buildPaymentMethod(2,
                              'assets/images/netbank_icon.png', 'Net Banking'),
                          buildPaymentMethod(3, 'assets/images/token_icon.png',
                              'Branch Token'),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(18, 20, 18, 0),
                      child: Expanded(
                        child: selectedMethodId == 1
                            ? firstContainer()
                            : selectedMethodId == 2
                                ? secondContainer()
                                : selectedMethodId == 3
                                    ? ThirdContainer()
                                    : Container(), // Empty container for default/no selection
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildPaymentMethod(int id, String iconPath, String title) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedMethodId = id;
        });
        // You can use selectedMethodId here if needed
      },
      child: Container(
        width: 78,
        height: 86,
        decoration: BoxDecoration(
          color: Color(0x00FFFFFF),
          image: DecorationImage(
            fit: BoxFit.contain,
            image: AssetImage(
              selectedMethodId == id
                  ? 'assets/images/shape_select.png'
                  : 'assets/images/shape_white.png',
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
                iconPath,
                width: 28,
                height: 35,
                fit: BoxFit.contain,
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 3, 0, 0),
              child: Text(
                title,
                style: TextStyle(
                  fontFamily: 'Roboto',
                  color: Color(0xFF383C48),
                  fontSize: 7,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget firstContainer() {
    // Replace with the code for your first container
    return Container(
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
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(22, 20, 0, 0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  'Enter the 16 Digit Debit Card Number',
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    color: Color(0xFFFAFAFA),
                    fontSize: 12,
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
                  padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
                  child: TextFormField(
                    controller: _model.textController1,
                    focusNode: _model.textFieldFocusNode1,
                    textInputAction: TextInputAction.done,
                    obscureText: false,
                    decoration: InputDecoration(
                      labelText: 'Enter the 16 Digit Debit Card Number',
                      labelStyle: TextStyle(
                        fontFamily: 'Roboto',
                        color: Color(0xFFB3C5DA),
                        fontSize: 10,
                      ),
                      alignLabelWithHint: false,
                      hintStyle: TextStyle(
                        fontFamily: 'Roboto',
                        color: Color(0xFFB3C5DA),
                        fontSize: 10,
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(
                              0xFFB3C5DA), // Replace with the alternate color
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
                      errorBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color:
                              Color(0xFFB3C5DA), // Replace with the error color
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      focusedErrorBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color:
                              Color(0xFFB3C5DA), // Replace with the error color
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      contentPadding:
                          EdgeInsetsDirectional.fromSTEB(5, 0, 0, 0),
                    ),
                    style: TextStyle(
                      fontFamily: 'Readex Pro',
                      color: Color(0xFFFAFAFA),
                      fontSize: 12,
                    ),
                    textAlign: TextAlign.start,
                    keyboardType: TextInputType.number,
                    cursorColor: Color(0xFFFAFAFA),
                    // validator: _model.textController1Validator.asValidator(context),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(22, 20, 0, 0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  'Valid Upto/ExpiryDate(MM/YY)',
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    color: Color(0xFFFAFAFA),
                    fontSize: 12,
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
                  padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
                  child: TextFormField(
                    controller: _model.textController2,
                    focusNode: _model.textFieldFocusNode2,
                    textInputAction: TextInputAction.done,
                    obscureText: false,
                    decoration: InputDecoration(
                      labelText: 'Enter in (MM/YY) format',
                      labelStyle: TextStyle(
                        fontFamily: 'Roboto',
                        color: Color(0xFFB3C5DA),
                        fontSize: 10,
                      ),
                      alignLabelWithHint: false,
                      hintStyle: TextStyle(
                        fontFamily: 'Roboto',
                        color: Color(0xFFB3C5DA),
                        fontSize: 10,
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(
                              0xFFB3C5DA), // Replace with the actual 'alternate' color
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
                      errorBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(
                              0xFFB3C5DA), // Replace with the actual 'error' color
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      focusedErrorBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(
                              0xFFB3C5DA), // Replace with the actual 'error' color
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      contentPadding:
                          EdgeInsetsDirectional.fromSTEB(5, 0, 0, 0),
                    ),
                    style: TextStyle(
                      fontFamily: 'Readex Pro',
                      color: Color(0xFFFAFAFA),
                      fontSize: 12,
                    ),
                    textAlign: TextAlign.start,
                    keyboardType: TextInputType.number,
                    cursorColor: Color(0xFFFAFAFA),
                    // validator: _model.textController2Validator.asValidator(context),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(22, 20, 0, 0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  'Debit Card PIN(ATM PIN)',
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    color: Color(0xFFFAFAFA),
                    fontSize: 12,
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
                  padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
                  child: TextFormField(
                    controller: _model.textController3,
                    focusNode: _model.textFieldFocusNode3,
                    textInputAction: TextInputAction.done,
                    obscureText: false,
                    decoration: InputDecoration(
                      labelText: 'Enter your 4 Digit ATM PIN',
                      labelStyle: TextStyle(
                        fontFamily: 'Roboto',
                        color: Color(0xFFB3C5DA),
                        fontSize: 10,
                      ),
                      alignLabelWithHint: false,
                      hintStyle: TextStyle(
                        fontFamily: 'Roboto',
                        color: Color(0xFFB3C5DA),
                        fontSize: 10,
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(
                              0xFFB3C5DA), // Replace with the actual 'alternate' color
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
                      errorBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(
                              0xFFB3C5DA), // Replace with the actual 'error' color
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      focusedErrorBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(
                              0xFFB3C5DA), // Replace with the actual 'error' color
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      contentPadding:
                          EdgeInsetsDirectional.fromSTEB(5, 0, 0, 0),
                    ),
                    style: TextStyle(
                      fontFamily: 'Readex Pro',
                      color: Color(0xFFFAFAFA),
                      fontSize: 12,
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
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 20),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    print('Button pressed ...');
                  },
                  child: Text(
                    'Continue',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      color: Colors.white,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xFFF99300), // Button background color
                    onPrimary: Colors.white, // Text color
                    minimumSize: Size(250, 45),
                    padding: EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
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
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget secondContainer() {
    // Replace with the code for your second container
    return Container(
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
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(22, 20, 0, 0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  'Enter Netbanking User ID',
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    color: Color(0xFFFAFAFA),
                    fontSize: 12,
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
                  padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
                  child: TextFormField(
                    controller: _model.textController4,
                    focusNode: _model.textFieldFocusNode4,
                    textInputAction: TextInputAction.done,
                    obscureText: false,
                    decoration: InputDecoration(
                      labelText: 'Enter Netbanking User ID',
                      labelStyle: TextStyle(
                        fontFamily: 'Roboto',
                        color: Color(0xFFB3C5DA),
                        fontSize: 10,
                      ),
                      alignLabelWithHint: false,
                      hintStyle: TextStyle(
                        fontFamily: 'Roboto',
                        color: Color(0xFFB3C5DA),
                        fontSize: 10,
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(
                              0xFFB3C5DA), // Replace with the alternate color
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
                      errorBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color:
                              Color(0xFFB3C5DA), // Replace with the error color
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      focusedErrorBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color:
                              Color(0xFFB3C5DA), // Replace with the error color
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      contentPadding:
                          EdgeInsetsDirectional.fromSTEB(5, 0, 0, 0),
                    ),
                    style: TextStyle(
                      fontFamily: 'Readex Pro',
                      color: Color(0xFFFAFAFA),
                      fontSize: 12,
                    ),
                    textAlign: TextAlign.start,
                    keyboardType: TextInputType.number,
                    cursorColor: Color(0xFFFAFAFA),
                    // validator: _model.textController1Validator.asValidator(context),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(22, 20, 0, 0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  'Enter Netbanking Password',
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    color: Color(0xFFFAFAFA),
                    fontSize: 12,
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
                  padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
                  child: TextFormField(
                    controller: _model.textController5,
                    focusNode: _model.textFieldFocusNode5,
                    textInputAction: TextInputAction.done,
                    obscureText: false,
                    decoration: InputDecoration(
                      labelText: 'Enter Netbanking Password here',
                      labelStyle: TextStyle(
                        fontFamily: 'Roboto',
                        color: Color(0xFFB3C5DA),
                        fontSize: 10,
                      ),
                      alignLabelWithHint: false,
                      hintStyle: TextStyle(
                        fontFamily: 'Roboto',
                        color: Color(0xFFB3C5DA),
                        fontSize: 10,
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(
                              0xFFB3C5DA), // Replace with the actual 'alternate' color
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
                      errorBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(
                              0xFFB3C5DA), // Replace with the actual 'error' color
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      focusedErrorBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(
                              0xFFB3C5DA), // Replace with the actual 'error' color
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      contentPadding:
                          EdgeInsetsDirectional.fromSTEB(5, 0, 0, 0),
                    ),
                    style: TextStyle(
                      fontFamily: 'Readex Pro',
                      color: Color(0xFFFAFAFA),
                      fontSize: 12,
                    ),
                    textAlign: TextAlign.start,
                    keyboardType: TextInputType.number,
                    cursorColor: Color(0xFFFAFAFA),
                    // validator: _model.textController2Validator.asValidator(context),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 20),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    print('Button pressed ...');
                  },
                  child: Text(
                    'Continue',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      color: Colors.white,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xFFF99300), // Button background color
                    onPrimary: Colors.white, // Text color
                    minimumSize: Size(250, 45),
                    padding: EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
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
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget ThirdContainer() {
    // Replace with the code for your second container
    return Container(
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
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(22, 20, 0, 0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  'Enter Branch Token Number',
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    color: Color(0xFFFAFAFA),
                    fontSize: 12,
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
                  padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
                  child: TextFormField(
                    controller: _model.textController6,
                    focusNode: _model.textFieldFocusNode6,
                    textInputAction: TextInputAction.done,
                    obscureText: false,
                    decoration: InputDecoration(
                      labelText: 'Enter Branch Token Number here',
                      labelStyle: TextStyle(
                        fontFamily: 'Roboto',
                        color: Color(0xFFB3C5DA),
                        fontSize: 10,
                      ),
                      alignLabelWithHint: false,
                      hintStyle: TextStyle(
                        fontFamily: 'Roboto',
                        color: Color(0xFFB3C5DA),
                        fontSize: 10,
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(
                              0xFFB3C5DA), // Replace with the alternate color
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
                      errorBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color:
                              Color(0xFFB3C5DA), // Replace with the error color
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      focusedErrorBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color:
                              Color(0xFFB3C5DA), // Replace with the error color
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      contentPadding:
                          EdgeInsetsDirectional.fromSTEB(5, 0, 0, 0),
                    ),
                    style: TextStyle(
                      fontFamily: 'Readex Pro',
                      color: Color(0xFFFAFAFA),
                      fontSize: 12,
                    ),
                    textAlign: TextAlign.start,
                    keyboardType: TextInputType.number,
                    cursorColor: Color(0xFFFAFAFA),
                    // validator: _model.textController1Validator.asValidator(context),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 20),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    print('Button pressed ...');
                  },
                  child: Text(
                    'Continue',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      color: Colors.white,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xFFF99300), // Button background color
                    onPrimary: Colors.white, // Text color
                    minimumSize: Size(250, 45),
                    padding: EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}
