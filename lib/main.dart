
import 'package:fedsecure/ui/AppSettings/AppSettingsModel.dart';
import 'package:fedsecure/ui/AppSettings/AppSettingsWidget.dart';

import 'package:fedsecure/ui/Home/HomeWidget.dart';

import 'package:fedsecure/ui/Messages/MessagesScreenWidget.dart';
import 'package:fedsecure/ui/firebase/firebase_notification.dart';
import 'package:fedsecure/ui/onBoarding/mpin/SetMPINWidget.dart';
import 'package:fedsecure/ui/onBoarding/splashScreen/SplashScreenWidget.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:telephony/telephony.dart';
onBackgroundMessage(SmsMessage message) {
  debugPrint("onBackgroundMessage called");
}

Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  final appDocumentDirectory = await getApplicationDocumentsDirectory();
  final Telephony telephony = Telephony.instance;
  Hive.init(appDocumentDirectory.path);
  // If you have custom types, register them here
  // Hive.registerAdapter(MyModelAdapter());
  await Hive.openBox('myBox');
  // Initialize Firebase
  await Firebase.initializeApp();

  // Initialize Firebase Notifications
  await FirebaseNotification().initFirebase();


  //bool? permissionsGranted = await telephony.requestPhoneAndSmsPermissions;
  // if(permissionsGranted==true)
  //   {
  //     print(permissionsGranted);
  //   }

  var status = await Permission.sms.request();

  if (status == PermissionStatus.granted) {
    print("permission granted");
  }

  runApp(const MyApp());
  FlutterNativeSplash.remove();
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FedSecure',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SplashScreenWidget(),
    );
  }
}