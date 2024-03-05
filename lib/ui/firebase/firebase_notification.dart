import 'package:firebase_messaging/firebase_messaging.dart';

import '../../hive_Database/HiveHelper.dart';

class FirebaseNotification {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  // static final _instance = FirebaseNotification._internal();

  // factory FirebaseNotification() => _instance;

  // FirebaseNotification._internal() {
  //   FirebaseMessaging.onBackgroundMessage(handelBackgroundMessage);
  //   FirebaseMessaging.onMessage.listen(_handleForegroundMessage);
  // }
  

  Future<void> initFirebase() async {
    print("i am called");
    await _firebaseMessaging.requestPermission();

  final fcmToken=await _firebaseMessaging.getToken();
print('Token: $fcmToken');
    HiveHelper.saveData('mobile_fcm', fcmToken);




// FirebaseMessaging.onBackgroundMessage(handelBackgroundMessage);


//
// FirebaseMessaging.onBackgroundMessage(handelBackgroundMessage);
//

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      // Handle the incoming message when the app is in the foreground
      print("onMessage: $message");
      // Add your custom handling logic here
    });

//     FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
//       // Handle the incoming message when the app is in the background
//       print("onMessageOpenedApp: $message");
//       // Add your custom handling logic here
//     });
//   }
//   Future<void> _handleForegroundMessage(RemoteMessage message) async {
//     // Process foreground message
//   }

//

//   Future<void> handelBackgroundMessage(RemoteMessage message) async {
//     print('Title ${message.notification?.title}');
//     print('Title ${message.notification?.body}');
//     print('Title ${message.data}');
//   }
}
}
