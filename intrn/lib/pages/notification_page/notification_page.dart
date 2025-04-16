import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:intrn/controllers/notification_controller.dart';

class NotificationPage extends StatelessWidget {
  NotificationPage({Key? key}) : super(key: key);
  final controller = Get.put(NotificationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFFF5F5F5),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Notifications",
          style: TextStyle(fontFamily: "Poppins", fontSize: 24, color: Colors.black),
        ),
      ),
      body: Obx(() {
        final notifications = controller.notifications;

        if (notifications.isEmpty) {
          return const Center(child: Text("No notifications yet."));
        }

        final now = DateTime.now();
        final today = <RemoteMessage>[];
        final yesterday = <RemoteMessage>[];
        final thisWeek = <RemoteMessage>[];

        for (var msg in notifications) {
          final date = msg.sentTime ?? now;
          final diff = now.difference(date).inDays;

          if (diff == 0) {
            today.add(msg);
          } else if (diff == 1) {
            yesterday.add(msg);
          } else if (diff <= 7) {
            thisWeek.add(msg);
          }
        }

        return ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          children: [
            if (today.isNotEmpty) ...[
              _sectionTitle("Today"),
              ...today.map((msg) => _NotificationCard(
                    title: msg.notification?.title ?? '',
                    body: msg.notification?.body ?? '',
                  )),
            ],
            if (yesterday.isNotEmpty) ...[
              _sectionTitle("Yesterday"),
              ...yesterday.map((msg) => _NotificationCard(
                    title: msg.notification?.title ?? '',
                    body: msg.notification?.body ?? '',
                  )),
            ],
            if (thisWeek.isNotEmpty) ...[
              _sectionTitle("This Week"),
              ...thisWeek.map((msg) => _NotificationCard(
                    title: msg.notification?.title ?? '',
                    body: msg.notification?.body ?? '',
                  )),
            ],
          ],
        );
      }),
    );
  }

  Widget _sectionTitle(String title) => Padding(
        padding: const EdgeInsets.only(top: 24, bottom: 8),
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
      );
}

class _NotificationCard extends StatelessWidget {
  final String title;
  final String body;

  const _NotificationCard({required this.title, required this.body});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2)),
        ],
      ),
      child: Row(
        children: [
          Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              color: const Color(0xFFFF7A27),
              borderRadius: BorderRadius.circular(12),
            ),
            alignment: Alignment.center,
            child: const Text(
              'Intrn',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    )),
                const SizedBox(height: 4),
                Text(body,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    )),
              ],
            ),
          ),
          const Icon(Icons.circle, color: Colors.red, size: 10),
        ],
      ),
    );
  }
}
