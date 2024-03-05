import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';


class NotificationList extends StatefulWidget {
  @override
  _NotificationListState createState() => _NotificationListState();
}

class _NotificationListState extends State<NotificationList> {
  List<RemoteMessage> notifications = [];

  @override
  void initState() {
    super.initState();
    // Fetch initial notifications from storage or server
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications'),
      ),
      body: ListView.builder(
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          final notification = notifications[index];
          return ListTile(
            title: Text(notification.notification?.title ?? 'No title'),
            subtitle: Text(notification.notification?.body ?? ''),
            onTap: () {
              // Handle notification tap
            },
          );
        },
      ),
    );
  }
}
