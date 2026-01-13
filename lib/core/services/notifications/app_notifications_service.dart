// import 'dart:developer';
// import 'dart:io';

// import 'package:permission_handler/permission_handler.dart';

// import 'firebase_messaging.dart';
// import 'local_notifications.dart';

// /// add: <uses-permission android:name="android.permission.POST_NOTIFICATIONS"/>
// /// run: flutter pub add permission_handler

// abstract class AppNotificationsService {
//   static Future<void> initNotifications() async{
//     requestPermission();
//     final LocalNotificationService notificationService = LocalNotificationService();
//     await notificationService.initialize();
//     bool requestFCMApis = true;
//     if(Platform.isIOS){
//       final apnsToken = await AppFirebaseMessaging.getAPNSToken();
//       if (apnsToken == null) {
//         // APNS token is available, make FCM plugin API requests...
//         requestFCMApis = false;
//       }
//     }
//     if(requestFCMApis){
//       AppFirebaseMessaging.setForegroundNotificationPresentationOptions();
//       AppFirebaseMessaging.onMessage(notificationService);
//       AppFirebaseMessaging.onMessageOpenedApp(notificationService);
//       AppFirebaseMessaging.getToken();
//       AppFirebaseMessaging.onTokenRefresh();
//       AppFirebaseMessaging.subscribeToTopic('all');
//       AppFirebaseMessaging.subscribeToTopic('all_doctors');
//     }
//   }
  
//   static Future<void> requestPermission() async {
//     PermissionStatus status = await Permission.notification.status;
//     log('requestPermission PermissionStatus: ${status.toString()}');
//     if (!status.isGranted) {
//       status = await Permission.notification.request();
//       log('requestPermission PermissionStatus.request(): ${status.toString()}');
//     }
//   }
// }