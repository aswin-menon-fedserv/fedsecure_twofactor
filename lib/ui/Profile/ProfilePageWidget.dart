// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_string_interpolations

import 'package:fedsecure/hive_Database/HiveHelper.dart';
import 'package:fedsecure/ui/Profile/ProfilePageModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ProfileWidget extends StatefulWidget {
  const ProfileWidget({Key? key}) : super(key: key);

  @override
  _ProfileWidgetState createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {
  late ProfileModel _model;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  // ProfilePageModel? profilepageModel;
  final TextEditingController _controller = TextEditingController();

  Map<String, String> textValues = {
    "txtName": "",
    "txtMobNo": "",
    "txtemailID": ""
  };

  File? _image;
  var mobile_saved, name_saved, email_saved;

  @override
  void initState() {
    super.initState();
    _model = ProfileModel();
    _model.textController ??= TextEditingController();

    init();
  }

  Future<void> init() async {
    setState(() {
      _controller.text = textValues["txtName"]!;
      _controller.text = textValues["txtMobNo"]!;
      _controller.text = textValues["txtemailID"]!;
    });
    File? storedImage = await HiveHelper.getImage('myImage');

    if (storedImage != null && await storedImage.exists()) {
      setState(() {
        _image = storedImage;
      });
    }

    mobile_saved = await HiveHelper.getData('profile_mobileno_stored');
    name_saved = await HiveHelper.getData('name_stored');
    email_saved = await HiveHelper.getData('email_stored');

 if (name_saved != null && name_saved.isNotEmpty) {
     setState(() {
          textValues["txtName"] = name_saved!;
          textValues["txtMobNo"] = mobile_saved!;
          textValues["txtemailID"] = email_saved!;
        });
 }
  }

  @override
  void dispose() {
    _model.dispose();

    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //context.watch<FFAppState>();

    return GestureDetector(
      onTap: () => _model.unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(_model.unfocusNode)
          : FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Color(0xFFEFF5FC),
        body: SafeArea(
          top: true,
          child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              color: Color(0xFFEFF5FC),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Align(
                  alignment: AlignmentDirectional(-1.00, 0.00),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 68,
                        height: 52,
                        decoration: BoxDecoration(),
                        child: IconButton(
                          padding:
                              EdgeInsets.all(0), // Adjust the padding as needed
                          icon: Icon(
                            Icons.arrow_back_rounded,
                            color: Color(0xFF383C48),
                            size: 24,
                          ),
                          onPressed: () async {
                            Navigator.of(context).pop();
                          },
                        ),
                      ),
                      Text(
                        'Profile',
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          color: Color(0xFF383C48),
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Spacer(), // Pushes the following items to the end of the row
                      Text(
                        'Logout',
                        style: TextStyle(
                          fontFamily: 'Noto Sans',
                          color: Color(0xFF383C48),
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.logout, // Default logout icon
                          color: Color(0xFF383C48),
                          size: 24,
                        ),
                        onPressed: () {
                          handleLogout();
                        },
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 0),
                        child: Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            color: Color(0xFFEFFFFF),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: Image.asset(
                                'assets/images/card_1.png',
                              ).image,
                            ),
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(0),
                              bottomRight: Radius.circular(0),
                              topLeft: Radius.circular(15),
                              topRight: Radius.circular(15),
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Align(
                                      alignment:
                                          AlignmentDirectional(0.00, 0.00),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            20, 0, 0, 0),
                                        child: Container(
                                          width: 60,
                                          height: 60,
                                          decoration: BoxDecoration(
                                            color: Color(0x00231A79),
                                            shape: BoxShape.circle,
                                          ),
                                          child: Stack(
                                            children: [
                                              Container(
                                                width: 55,
                                                height: 55,
                                                clipBehavior: Clip.antiAlias,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                ),
                                                child: ClipOval(
                                                  child: _image != null &&
                                                          File(_image!.path)
                                                              .existsSync()
                                                      ? Image.file(
                                                          File(_image!.path),
                                                          fit: BoxFit
                                                              .cover, // You can use BoxFit.cover to fill the circle
                                                          width:
                                                              55, // You can adjust the width and height to your liking
                                                          height: 55,
                                                        )
                                                      : Image.asset(
                                                          'assets/images/account.png',
                                                          fit: BoxFit
                                                              .cover, // You can use BoxFit.cover to fill the circle
                                                          width:
                                                              55, // You can adjust the width and height to your liking
                                                          height: 55,
                                                        ),
                                                ),
                                              ),
                                              Align(
                                                alignment: AlignmentDirectional(
                                                    1.56, 1.39),
                                                child: Container(
                                                  width: 30,
                                                  height: 30,
                                                  decoration: BoxDecoration(
                                                    color: Color(0x00F9F9F9),
                                                    shape: BoxShape.circle,
                                                  ),
                                                  child: IconButton(
                                                    padding: EdgeInsets.all(
                                                        0), // Adjust the padding as needed
                                                    icon: Icon(
                                                      Icons.mode_edit_rounded,
                                                      color: Colors.white,
                                                      size: 15,
                                                    ),
                                                    onPressed: () {
                                                      print(
                                                          'IconButton pressed ...');
                                                      show(context);
                                                    },
                                                    iconSize: 30,
                                                    splashColor:
                                                        Color(0xFFFC9200),
                                                    color: Colors.white,
                                                    highlightColor:
                                                        Color(0xFFFC9200),
                                                    hoverColor:
                                                        Color(0xFFFC9200),
                                                    focusColor:
                                                        Color(0xFFFC9200),
                                                    disabledColor:
                                                        Color(0xFF003E85),
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
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      20, 0, 0, 0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Flexible(
                                        child: Align(
                                          alignment:
                                              AlignmentDirectional(-1.00, 0.00),
                                          child: Text(
                                            // "${textValues["txtName"]!} \n ${textValues["txtMobNo"]!}",
                                            "${textValues["txtName"]!}",
                                            textAlign: TextAlign.start,
                                            maxLines: 4,
                                            style: TextStyle(
                                              fontFamily: 'Roboto',
                                              color: Color(0xFFFEFEFE),
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
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
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      // Padding(
                                      //   padding: EdgeInsetsDirectional.fromSTEB(
                                      //       0, 0, 10, 0),
                                      //   child: Container(
                                      //     width: 45,
                                      //     height: 45,
                                      //     decoration: BoxDecoration(
                                      //       color: Color(0xFF0099FF),
                                      //       shape: BoxShape.circle,
                                      //     ),
                                      //     child: IconButton(
                                      //       padding: EdgeInsets.all(0),
                                      //       icon: Icon(
                                      //         Icons.qr_code_2,
                                      //         color: Colors.white,
                                      //         size: 18,
                                      //       ),
                                      //       onPressed: () async {
                                      //         // await showModalBottomSheet(
                                      //         //   isScrollControlled: true,
                                      //         //   backgroundColor:
                                      //         //       Color(0xFF737373),
                                      //         //   barrierColor: Color(0xFF737373),
                                      //         //   enableDrag: false,
                                      //         //   context: context,
                                      //         //   builder: (context) {
                                      //         //     return GestureDetector(
                                      //         //       onTap: () {
                                      //         //         if (_model.unfocusNode
                                      //         //             .canRequestFocus) {
                                      //         //           FocusScope.of(context)
                                      //         //               .requestFocus(_model
                                      //         //                   .unfocusNode);
                                      //         //         } else {
                                      //         //           FocusScope.of(context)
                                      //         //               .unfocus();
                                      //         //         }
                                      //         //       },
                                      //         //       child: Padding(
                                      //         //         padding: MediaQuery
                                      //         //             .viewInsetsOf(
                                      //         //                 context),
                                      //         //         child: Container(
                                      //         //           height: 600,
                                      //         //           child: ScancodeqrWidget(
                                      //         //               profilepageModel!
                                      //         //                   .userDetails
                                      //         //                   .name
                                      //         //                   .toString(),
                                      //         //               profilepageModel!
                                      //         //                   .userDetails
                                      //         //                   .upiId
                                      //         //                   .toString()), // Replace with your actual widget
                                      //         //         ),
                                      //         //       ),
                                      //         //     );
                                      //         //   },
                                      //         // ).then((value) {
                                      //         //   // Call your custom safeSetState method here
                                      //         //   // safeSetState(() {
                                      //         //   //   // Handle any state changes you want here
                                      //         //   // });
                                      //         // });
                                      //       },
                                      //       iconSize: 45,
                                      //       splashColor: Color(0xFF0099FF),
                                      //       color: Colors.white,
                                      //       highlightColor: Color(0xFF0099FF),
                                      //       hoverColor: Color(0xFF0099FF),
                                      //       focusColor: Color(0xFF0099FF),
                                      //       disabledColor: Colors.transparent,
                                      //     ),
                                      //   ),
                                      // ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
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
                        padding: EdgeInsetsDirectional.fromSTEB(10, 0, 10, 10),
                        child: Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(15),
                              bottomRight: Radius.circular(15),
                              topLeft: Radius.circular(0),
                              topRight: Radius.circular(0),
                            ),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Text(
                                      "Mobile No: ${textValues["txtMobNo"]!}",
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        fontFamily: 'Noto Sans',
                                        color: Color(0xFF202020),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Text(
                                      "Email ID: ${textValues["txtemailID"]!}",
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        fontFamily: 'Noto Sans',
                                        color: Color(0xFF202020),
                                      ),
                                    ),
                                    Flexible(
                                      child: Align(
                                        alignment:
                                            AlignmentDirectional(1.00, -1.00),
                                        child: IconButton(
                                          padding: EdgeInsets.all(
                                              0), // Adjust the padding as needed
                                          icon: Icon(
                                            Icons.content_copy_rounded,
                                            color: Color(0xFF004E97),
                                            size: 20,
                                          ),
                                          onPressed: () {
                                            print('IconButton pressed ...');
                                          },
                                          iconSize: 40,
                                          splashColor: Colors.transparent,
                                          color: Colors.transparent,
                                          highlightColor: Colors.transparent,
                                          hoverColor: Colors.transparent,
                                          focusColor: Colors.transparent,
                                          disabledColor: Colors.transparent,
                                          // Optionally, you can also set other properties like splash radius or constraints.
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
              ],
            ),
          ),
        ),
      ),
    );
  }

  void show(BuildContext context) {
    showCupertinoModalPopup(
        context: context,
        builder: (BuildContext cont) {
          return CupertinoActionSheet(
            actions: [
              CupertinoActionSheetAction(
                onPressed: () {
                  print('Camera');
                  _getImageFromCamera();
                },
                child: Text('Use Camera'),
              ),
              CupertinoActionSheetAction(
                onPressed: () {
                  print('Upload files');
                  _getImageFromGallery();
                },
                child: Text('Upload from files'),
              ),
            ],
            cancelButton: CupertinoActionSheetAction(
              onPressed: () {
                Navigator.of(cont).pop;
              },
              child: Text('Cancel', style: TextStyle(color: Colors.red)),
            ),
          );
        });
  }

  Future<void> _getImageFromGallery() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) return; // User canceled the selection

    File imageFile = File(image.path);
    await HiveHelper.storeImage('myImage', imageFile);
    setState(() {
      _image = File(image.path);
    });
  }

  Future<void> _getImageFromCamera() async {
    final image = await ImagePicker().pickImage(source: ImageSource.camera);
    if (image == null) return; // User canceled the selection

    File imageFile = File(image.path);
    await HiveHelper.storeImage('myImage', imageFile);

    setState(() {
      _image = imageFile;
    });
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
