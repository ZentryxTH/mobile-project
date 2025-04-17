import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationRepository extends GetxController {
  static NotificationRepository get instance => Get.find();

  final _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initNotifications() async {
    // 🔐 Request permission
    await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    // 📲 Get FCM Token
    String? token = await _firebaseMessaging.getToken();
    print('📲 Device Token: $token');

    // 🟠 Foreground Notification
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('🔔 Foreground message received');
      print('Title: ${message.notification?.title}');
      print('Body: ${message.notification?.body}');
    });

    // 🟡 App Opened from Notification
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('📬 Notification opened app');
      print('Title: ${message.notification?.title}');
    });
  }
}
