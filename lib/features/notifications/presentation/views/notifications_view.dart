import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sportify_app/core/utils/app_colors.dart';
import 'package:sportify_app/core/utils/image_manager.dart';
import 'package:sportify_app/injection_container.dart';
import 'package:sportify_app/features/notifications/presentation/widgets/notification_tile.dart';

class NotificationsView extends StatelessWidget {
  const NotificationsView({super.key});

  // Mock notification data
  final List<Map<String, dynamic>> _requests = const [
    {
      'avatar': ImgAssets.mohamedAhmed,
      'name': 'Mohamed Saad',
      'message':
          'wants to share with you the price of reserving a stadium.',
      'time': '4h',
      'action': 'Share',
    },
    {
      'avatar': ImgAssets.salahMostafa,
      'name': 'Mohamed Saad',
      'message':
          'wants to share with you the price of a subscription to book an hour.',
      'time': '11h',
      'action': 'Share',
    },
    {
      'avatar': ImgAssets.mohamedAhmed,
      'name': 'Mohamed Saad',
      'message':
          'agreed to join you in today\'s match at 11.',
      'time': '2d',
      'action': 'Pay',
    },
    {
      'avatar': ImgAssets.salahMostafa,
      'name': 'Mohamed Saad',
      'message':
          'the owner of the stadium (Stadium name), agreed to book the stadium with by paying cash.',
      'time': '1d',
      'action': null,
    },
    {
      'avatar': ImgAssets.mohamedAhmed,
      'name': 'Ahmed Moussa',
      'message': 'accepted your friend request.',
      'time': '1d',
      'action': null,
    },
    {
      'avatar': ImgAssets.salahMostafa,
      'name': 'Ali Ayman',
      'message': 'asks for your friend.',
      'time': '2d',
      'action': 'Accept',
    },
    {
      'avatar': ImgAssets.mohamedAhmed,
      'name': 'Mohamed Mostafa',
      'message': 'wants you to join his team as a striker.',
      'time': '2d',
      'action': 'Accept',
    },
    {
      'avatar': ImgAssets.salahMostafa,
      'name': 'Mohamed Karim',
      'message':
          'The tournament was entered by Mohamed Karim and you are a striker in his team.',
      'time': '2d',
      'action': null,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black87,
            size: 24.sp,
          ),
          onPressed: () {
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            }
          },
        ),
        title: Text(
          'Notification',
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
            color: context.colors.textColor,
          ),
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Requests Section Header
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 20.w,
                vertical: 16.h,
              ),
              child: Text(
                'Requests',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: context.colors.textColor,
                ),
              ),
            ),

            // Notification List
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _requests.length,
              separatorBuilder: (context, index) => Divider(
                height: 1,
                thickness: 1,
                color: Colors.grey[200],
                indent: 72
                    .w, // Align with content (avatar + spacing)
              ),
              itemBuilder: (context, index) {
                final notification = _requests[index];
                return NotificationTile(
                  userAvatar:
                      notification['avatar'] as String,
                  userName: notification['name'] as String,
                  message:
                      notification['message'] as String,
                  time: notification['time'] as String,
                  actionButtonText:
                      notification['action'] as String?,
                  onActionTap:
                      notification['action'] != null
                      ? () {
                          // TODO: Handle action based on type
                          final action =
                              notification['action']
                                  as String;
                          debugPrint(
                            'Action tapped: $action',
                          );
                        }
                      : null,
                );
              },
            ),

            // See All Requests Link
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 20.w,
                vertical: 16.h,
              ),
              child: GestureDetector(
                onTap: () {
                  // TODO: Navigate to all requests screen
                  debugPrint('See all requests tapped');
                },
                child: Text(
                  'See all requests',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: MyColors.greenButton,
                  ),
                ),
              ),
            ),

            // This Month Section Header
            Padding(
              padding: EdgeInsets.only(
                left: 20.w,
                right: 20.w,
                top: 24.h,
                bottom: 16.h,
              ),
              child: Text(
                'This Month',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ),

            // Divider
            Divider(
              height: 1,
              thickness: 1,
              color: Colors.grey[200],
            ),

            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }
}
