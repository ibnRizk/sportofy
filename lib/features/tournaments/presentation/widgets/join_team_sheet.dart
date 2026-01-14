import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:sportify_app/config/routes/app_routes.dart';
import 'package:sportify_app/core/utils/app_colors.dart';
import 'package:sportify_app/features/payment/presentation/widgets/payment_methods_sheet.dart';

class JoinTeamSheet extends StatelessWidget {
  const JoinTeamSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(30.r),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Drag Handle
          SizedBox(height: 12.h),
          Container(
            width: 40.w,
            height: 4.h,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),

          SizedBox(height: 20.h),

          // Title
          Text(
            'Join with your team',
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            textAlign: TextAlign.center,
          ),

          SizedBox(height: 20.h),

          // Team Card (Reusing the Strict Layout)
          _TeamCard(
            teamName: 'Team Name',
            memberCount: '17 member',
            avatarImage: 'assets/images/team3.png',
            extraMembersCount: 6,
          ),

          SizedBox(height: 16.h),

          // Rich Text with Hyperlink
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: Colors.grey[700],
                height: 1.5,
              ),
              children: [
                const TextSpan(
                  text: 'If you want to change your team, you can\ndo so by your profile ',
                ),
                TextSpan(
                  text: 'View Profile',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: MyColors.greenButton,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      // Close sheet first
                      Navigator.pop(context);
                      // Navigate to profile
                      context.push(Routes.profileRoute);
                    },
                ),
              ],
            ),
          ),

          SizedBox(height: 24.h),

          // Join Button
          SizedBox(
            width: double.infinity,
            height: 50.h,
            child: ElevatedButton(
              onPressed: () {
                // Capture root navigator context before popping
                final rootNavigator = Navigator.of(context, rootNavigator: true);
                
                // Close "Join with team" sheet
                Navigator.pop(context);

                // Open "Payment Methods" sheet after a short delay
                Future.delayed(const Duration(milliseconds: 300), () {
                  showModalBottomSheet(
                    context: rootNavigator.context,
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(30.r),
                      ),
                    ),
                    builder: (context) => const PaymentMethodsSheet(),
                  );
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: MyColors.greenButton,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.r),
                ),
                elevation: 0,
              ),
              child: Text(
                'Join',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),

          SizedBox(height: 20.h),
        ],
      ),
    );
  }
}

// TEAM CARD WITH EXACT LAYOUT (REUSING STRICT STRUCTURE)
class _TeamCard extends StatelessWidget {
  final String teamName;
  final String memberCount;
  final String avatarImage;
  final int extraMembersCount;

  const _TeamCard({
    required this.teamName,
    required this.memberCount,
    required this.avatarImage,
    required this.extraMembersCount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15.w),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Colors.grey[300]!,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // LEADING: Team Logo
          CircleAvatar(
            radius: 25.r,
            backgroundImage: AssetImage(avatarImage),
          ),

          SizedBox(width: 12.w),

          // MIDDLE: Team Info (Expanded)
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  teamName,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  memberCount,
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),

          // TRAILING: Stacked Avatars + Arrow
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              // The Avatar Stack (Fixed Size Container)
              SizedBox(
                width: 80.w,
                height: 30.h,
                child: Stack(
                  children: [
                    // Avatar 1
                    Positioned(
                      left: 0,
                      child: CircleAvatar(
                        radius: 15.r,
                        backgroundColor: Colors.white,
                        child: CircleAvatar(
                          radius: 13.r,
                          backgroundImage: AssetImage(avatarImage),
                        ),
                      ),
                    ),

                    // Avatar 2
                    Positioned(
                      left: 15.w,
                      child: CircleAvatar(
                        radius: 15.r,
                        backgroundColor: Colors.white,
                        child: CircleAvatar(
                          radius: 13.r,
                          backgroundImage: AssetImage(avatarImage),
                        ),
                      ),
                    ),

                    // Avatar 3
                    Positioned(
                      left: 30.w,
                      child: CircleAvatar(
                        radius: 15.r,
                        backgroundColor: Colors.white,
                        child: CircleAvatar(
                          radius: 13.r,
                          backgroundImage: AssetImage(avatarImage),
                        ),
                      ),
                    ),

                    // Avatar 4 (The "+X")
                    Positioned(
                      left: 45.w,
                      child: CircleAvatar(
                        radius: 15.r,
                        backgroundColor: Colors.white,
                        child: CircleAvatar(
                          radius: 13.r,
                          backgroundColor: Colors.black87,
                          child: Text(
                            '+$extraMembersCount',
                            style: TextStyle(
                              fontSize: 9.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(width: 8.w),

              // The Arrow Icon
              Icon(
                Icons.arrow_forward_ios,
                size: 16.sp,
                color: Colors.grey[600],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
