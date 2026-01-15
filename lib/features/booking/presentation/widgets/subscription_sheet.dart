import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sportify_app/core/utils/app_colors.dart';
import 'package:sportify_app/features/payment/presentation/widgets/payment_methods_sheet.dart';

class SubscriptionSheet extends StatelessWidget {
  const SubscriptionSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(30.r),
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(20.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Drag Handle
                Center(
                  child: Container(
                    width: 40.w,
                    height: 4.h,
                    margin: EdgeInsets.only(
                      top: 12.h,
                      bottom: 20.h,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(
                        2.r,
                      ),
                    ),
                  ),
                ),

                // Title
                Text(
                  'Reserve the same hour every week for a month.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                ),

                SizedBox(height: 20.h),

                // Price Card
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(
                    vertical: 20.h,
                    horizontal: 20.w,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(
                      12.r,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withValues(
                          alpha: 0.1,
                        ),
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Text(
                    '300 EGP',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.bold,
                      color: MyColors.greenButton,
                    ),
                  ),
                ),

                SizedBox(height: 24.h),

                // Booking Details
                Row(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Every Thursday for 4 weeks',
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                            ),
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            'Stadium location ( Arab Elmaadi )',
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 10.h,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey[300]!,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(
                          8.r,
                        ),
                      ),
                      child: Text(
                        '4 PM - 6 PM',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 20.h),

                // Dates Included
                Text(
                  'Dates Included:',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 12.h),
                Wrap(
                  spacing: 12.w,
                  runSpacing: 12.h,
                  children: [
                    _DateBadge(day: '13', month: 'JUL'),
                    _DateBadge(day: '20', month: 'JUL'),
                    _DateBadge(day: '27', month: 'JUL'),
                    _DateBadge(day: '03', month: 'AUG'),
                  ],
                ),

                SizedBox(height: 30.h),

                // Benefits Section
                _BenefitItem(
                  text:
                      'You can share the subscription price with your friends',
                ),
                SizedBox(height: 16.h),
                _BenefitItem(
                  text:
                      'You can resell any of Your hours for other people to enjoy.',
                ),

                SizedBox(height: 30.h),

                // Subscribe Button
                SizedBox(
                  width: double.infinity,
                  height: 55.h,
                  child: ElevatedButton(
                    onPressed: () {
                      // Capture root navigator context BEFORE popping
                      final rootNavigator = Navigator.of(
                        context,
                        rootNavigator: true,
                      );
                      final rootContext =
                          rootNavigator.context;

                      // 1. Close Subscription Sheet
                      Navigator.pop(context);

                      // 2. Open Payment Sheet after a short delay
                      Future.delayed(
                        const Duration(milliseconds: 300),
                        () {
                          if (rootContext.mounted) {
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
                                  const PaymentMethodsSheet(),
                            );
                          }
                        },
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: MyColors.greenButton,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          12.r,
                        ),
                      ),
                    ),
                    child: Text(
                      'Subscribe',
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
          ),
        ),
      ),
    );
  }
}

// Date Badge Widget
class _DateBadge extends StatelessWidget {
  final String day;
  final String month;

  const _DateBadge({
    required this.day,
    required this.month,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 16.w,
        vertical: 12.h,
      ),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(
          color: Colors.grey[300]!,
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Text(
            day,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            month,
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }
}

// Benefit Item Widget
class _BenefitItem extends StatelessWidget {
  final String text;

  const _BenefitItem({required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 24.w,
          height: 24.w,
          decoration: BoxDecoration(
            color: Colors.grey[100],
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.check,
            size: 16.sp,
            color: MyColors.greenButton,
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
              color: Colors.black87,
            ),
          ),
        ),
      ],
    );
  }
}
