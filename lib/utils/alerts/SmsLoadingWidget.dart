// ignore_for_file: prefer_const_constructors

import 'package:fedsecure/utils/alerts/SmsLoadingModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SmsLoadingWidget extends StatefulWidget {
  const SmsLoadingWidget({super.key});

  @override
  State<SmsLoadingWidget> createState() => _SmsLoadingWidgetState();
}

class _SmsLoadingWidgetState extends State<SmsLoadingWidget> {
  late SmsLoadingModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
   // _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = SmsLoadingModel();
  }

  @override
  void dispose() {
   // _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      height: 300,
      decoration: BoxDecoration(
        color: Color(0xFF00468F),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(12),
          bottomRight: Radius.circular(12),
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 100,
            height: 110,
            decoration: BoxDecoration(
              color: Color(0x00FFFFFF),
              image: DecorationImage(
                fit: BoxFit.contain,
                image: Image.asset(
                  'assets/images/sim_shape_blue.png',
                ).image,
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(0),
                  child: Image.asset(
                    'assets/images/smsverify.png',
                    width: 35,
                    height: 40,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
          ),
          Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
              child: Text(
                'Sending SMS...',
                style: TextStyle(
                  fontFamily: 'Roboto',
                  color: Color(0xFFFAFAFA),
                  // Add any additional text styles here if needed
                ),
              )),
        ],
      ),
    );
  }
}
