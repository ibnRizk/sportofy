// import 'dart:developer';

// import 'package:firebase_messaging/firebase_messaging.dart';
// import '../../../injection_container.dart';
// import 'local_notifications.dart';

// abstract class AppFirebaseMessaging{

//   static Future<void> setForegroundNotificationPresentationOptions() async{
//     return await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
//       alert: true, // Required to display a heads up notification
//       badge: true,
//       sound: true,
//     );
//   }

//   static Future<void> getToken() async{
//     final String? token = await FirebaseMessaging.instance.getToken();
//     log('@AppFirebaseMessaging:: getToken: FCM token: $token');
//     ServiceLocator.injectTokenFCMSingleton(token);
//     dioConsumer.updateDeviceTokenHeader();
//   }

//   static void onTokenRefresh() async{
//     FirebaseMessaging.instance.onTokenRefresh.listen((String token) {
//       log('@AppFirebaseMessaging:: onTokenRefresh: FCM token: $token');
//       ServiceLocator.injectTokenFCMSingleton(token);
//       dioConsumer.updateDeviceTokenHeader();
//     });

//   }

//   static void onMessage(LocalNotificationService service){
//     FirebaseMessaging.onMessage.listen((RemoteMessage event) {
//       log('@AppFirebaseMessaging:: onMessage: ${event.notification?.toMap().toString()??''}');
//       log('@AppFirebaseMessaging:: onMessage: ${event.data}');
//       _showLocalNotification(service, event);
//       // ServiceLocator.instance<GetNotificationsCubit>().fPagination(
//       //   onSuccess: (response) {
//       //     ServiceLocator.instance<GetNotificationsCubit>()
//       //         .changeUnreadCount(
//       //       response.response?['params']?['unread_count'] ?? 0,
//       //       withoutEmit: true,
//       //     );
//       //   },
//       // );
//     });
//   }

//   static void onMessageOpenedApp(LocalNotificationService service){
//     FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage event) {
//       log('@AppFirebaseMessaging:: onMessageOpenedApp: ${event.notification?.toMap().toString()??''}');
//       log('@AppFirebaseMessaging:: onMessageOpenedApp: ${event.data}');
//       // _showLocalNotification(service, event);
//       // ServiceLocator.instance<GetNotificationsCubit>().fPagination(
//       //   onSuccess: (response) {
//       //     ServiceLocator.instance<GetNotificationsCubit>()
//       //         .changeUnreadCount(
//       //       response.response?['params']?['unread_count'] ?? 0,
//       //       withoutEmit: true,
//       //     );
//       //   },
//       // );
//     });
//   }

//   static void subscribeToTopic(String topic){
//     FirebaseMessaging.instance.subscribeToTopic(topic).then((value) {
//       log('@AppFirebaseMessaging:: subscribeToTopic: FCM subscribeToTopic($topic) Success');
//     }).catchError((error){
//       log('@AppFirebaseMessaging:: subscribeToTopic: FCM subscribeToTopic($topic) Error: ${error.toString()}');
//     });
//   }

//   static void _showLocalNotification(LocalNotificationService service, RemoteMessage event){
//     String title = event.notification?.title?? '';
//     String body = event.notification?.body?? '';
//     service.showNotification(id: 5, title: title, body: body, icon: '');
//   }

//   static Future<String?> getAPNSToken() async{
//     final String? apnsToken = await FirebaseMessaging.instance.getAPNSToken();
//     log('@AppFirebaseMessaging:: getAPNSToken: apnsToken: $apnsToken');
//     return apnsToken;
//   }
// }