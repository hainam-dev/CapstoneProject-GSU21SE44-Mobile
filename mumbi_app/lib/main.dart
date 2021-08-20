import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/services.dart';
import 'Constant/colorTheme.dart';
import 'app.dart';

final storage = FlutterSecureStorage();
const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel', // id
  'High Importance Notifications', // title
  'This channel is used for important notifications.', // description
  importance: Importance.high,
);
FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  print("Handling a background message: ${message.messageId}");
  flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  if (message.data.length > 0) {
    await flutterLocalNotificationsPlugin.show(
        message.data.hashCode,
        message.data['title'],
        message.data['text'],
        NotificationDetails(
          android: AndroidNotificationDetails(
              channel.id, channel.name, channel.description,
              largeIcon: DrawableResourceAndroidBitmap('@mipmap/logo'),
              color: PINK_COLOR,
              icon: 'logo_notification'),
        ));
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  HttpOverrides.global = new MyHttpOverrides();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  runApp(MyApp());
}
