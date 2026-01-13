// import 'dart:developer';

// import 'package:flutter_local_notifications/flutter_local_notifications.dart';


// class LocalNotificationService{

//   final FlutterLocalNotificationsPlugin _service = FlutterLocalNotificationsPlugin();


//   Future<void> initialize() async{
//     log('LocalNotificationService initialize STARTING...');
//     const AndroidInitializationSettings androidInitializationSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
//     const DarwinInitializationSettings iosInitializationSettings = DarwinInitializationSettings(
//       notificationCategories: <DarwinNotificationCategory>[
//         DarwinNotificationCategory(
//             'demoCategory',
//             actions: <DarwinNotificationAction>[
//             ],
//             options: <DarwinNotificationCategoryOption>{
//               DarwinNotificationCategoryOption.hiddenPreviewShowTitle,
//             }
//         ),
//       ],
//     );
//     const InitializationSettings settings = InitializationSettings(android: androidInitializationSettings, iOS: iosInitializationSettings,);
//     bool? isInit = await _service.initialize(settings);
//     log('LocalNotificationService initialized $isInit');
//   }

//   Future<NotificationDetails> _notificationsDetails(String icon) async{
//     AndroidNotificationDetails androidNotificationDetails = const AndroidNotificationDetails(
//       'my_channel_id',
//       'my_channel_name',
//       channelDescription: 'my_description',
//       importance: Importance.max,
//       priority: Priority.max,
//       playSound: true,
//       enableVibration: true,
//       //sound: RawResourceAndroidNotificationSound('notification'),
//     );
//     return NotificationDetails(android: androidNotificationDetails);
//   }

//   Future<void> showNotification({
//     required int id,
//     required String title,
//     required String body,
//     required String icon,
//   }) async {
//     log('showNotification title: $title');
//     final NotificationDetails details = await _notificationsDetails(icon);
//     await _service.show(id, title, body, details);
//   }

//   void onDidReceiveLocalNotification({int? id, String? title, String? body, String? payload}){
//     log('onDidReceiveLocalNotification title: $title');
//   }
// }