import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:sportify_app/config/routes/app_routes.dart';
import 'package:sportify_app/core/utils/app_colors.dart';
import 'package:sportify_app/features/booking/presentation/widgets/subscription_sheet.dart';

class BookingTypeSheet extends StatelessWidget {
  const BookingTypeSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(30.r),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(20.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Drag Handle
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
              'You can book this hour once or book it over a month',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),

            SizedBox(height: 20.h),

            // Illustration
            Container(
              height: 150.h,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12.r),
                child: Image.asset(
                  'assets/images/pana.png',
                  fit: BoxFit.contain,
                  errorBuilder:
                      (context, error, stackTrace) {
                        // Placeholder if image not found
                        return Center(
                          child: Icon(
                            Icons.sports_soccer,
                            size: 64.sp,
                            color: Colors.grey[400],
                          ),
                        );
                      },
                ),
              ),
            ),

            SizedBox(height: 20.h),

            // Description
            Text(
              'Subscribe now and enjoy playing at the same hour every week for a month or just enjoy it once',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: Colors.grey[600],
              ),
            ),

            SizedBox(height: 30.h),

            // Action Buttons
            Row(
              children: [
                // "Just Once" Button
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      print("Just Once Clicked");

                      // Capture root navigator context BEFORE popping
                      final rootNavigator = Navigator.of(
                        context,
                        rootNavigator: true,
                      );
                      final rootContext =
                          rootNavigator.context;

                      // Close the current sheet first
                      Navigator.pop(context);

                      // Navigate to reservation screen after a short delay
                      Future.delayed(
                        const Duration(milliseconds: 300),
                        () {
                          if (rootContext.mounted) {
                            print(
                              "Navigating to Reservation Screen",
                            );
                            // Use GoRouter extension method
                            rootContext.push(
                              Routes.reservationRoute,
                            );
                          } else {
                            print(
                              "ERROR: Context not mounted after delay",
                            );
                          }
                        },
                      );
                    },
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(
                        color: MyColors.greenButton,
                        width: 1,
                      ),
                      foregroundColor: MyColors.greenButton,
                      padding: EdgeInsets.symmetric(
                        vertical: 14.h,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          10.r,
                        ),
                      ),
                    ),
                    child: Text(
                      'Just Once',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),

                SizedBox(width: 15.w),

                // "Subscription" Button
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      print("Subscription Clicked");

                      // Capture root navigator context BEFORE popping
                      final rootNavigator = Navigator.of(
                        context,
                        rootNavigator: true,
                      );
                      final rootContext =
                          rootNavigator.context;

                      // Close the current sheet first
                      Navigator.pop(context);

                      // Show subscription sheet after a short delay
                      Future.delayed(
                        const Duration(milliseconds: 300),
                        () {
                          if (rootContext.mounted) {
                            print(
                              "Opening Subscription Sheet",
                            );
                            showModalBottomSheet(
                              context: rootContext,
                              isScrollControlled: true,
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.vertical(
                                      top: Radius.circular(
                                        30.r,
                                      ),
                                    ),
                              ),
                              builder: (context) =>
                                  const SubscriptionSheet(),
                            );
                          } else {
                            print(
                              "ERROR: Context not mounted after delay",
                            );
                          }
                        },
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: MyColors.greenButton,
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(
                        vertical: 14.h,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          10.r,
                        ),
                      ),
                    ),
                    child: Text(
                      'Subscription',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }
}
