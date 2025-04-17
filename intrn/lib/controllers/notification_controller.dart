import 'package:get/get.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationController extends GetxController {
  var notifications = <RemoteMessage>[].obs;

  @override
  void onInit() {
    super.onInit();
    
    // Listen for foreground notifications
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("📩 In-app notification received");
      notifications.insert(0, message);
    });

    // Optional: Handle when app is opened from background/tapped
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print("📬 Notification opened app: ${message.notification?.title}");
    });
  }
}
