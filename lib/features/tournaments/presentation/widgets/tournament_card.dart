import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sportify_app/core/utils/image_manager.dart';

class TournamentCard extends StatelessWidget {
  final String status;
  final String teamName;
  final String trailingInfo;
  final String joinedDate;
  final bool isDisjoinEnabled;

  const TournamentCard({
    super.key,
    required this.status,
    required this.teamName,
    required this.trailingInfo,
    required this.joinedDate,
    required this.isDisjoinEnabled,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha:0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Row: "Your Team" + Status Badge
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Your Team',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              _buildStatusBadge(),
            ],
          ),

          SizedBox(height: 12.h),

          // Info Row: Team Avatar + Name + Trailing Info
          Row(
            children: [
              // Team Avatar
              CircleAvatar(
                radius: 22.r,
                backgroundImage: AssetImage(ImgAssets.team3),
              ),

              SizedBox(width: 12.w),

              // Team Name
              Expanded(
                child: Text(
                  teamName,
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ),

              // Trailing Info
              Text(
                trailingInfo,
                style: TextStyle(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w500,
                  color: _getTrailingColor(),
                ),
              ),
            ],
          ),

          // Divider
          Divider(
            height: 24.h,
            thickness: 1,
            color: Colors.grey[200],
          ),

          // Footer Row: Joined Date + Disjoin Button
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Joined at $joinedDate',
                style: TextStyle(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey[600],
                ),
              ),
              _buildDisjoinButton(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatusBadge() {
    Color bgColor;
    Color textColor;

    switch (status.toLowerCase()) {
      case 'joined':
        bgColor = const Color(0xFFE3F2FD); // Light Blue
        textColor = const Color(0xFF1976D2); // Blue
        break;
      case 'finished':
        bgColor = const Color(0xFFE8F5E9); // Light Green
        textColor = const Color(0xFF4CAF50); // Green
        break;
      case 'pending':
        bgColor = const Color(0xFFFFF3E0); // Light Orange
        textColor = const Color(0xFFFF9800); // Orange
        break;
      default:
        bgColor = Colors.grey[200]!;
        textColor = Colors.grey[700]!;
    }

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 12.w,
        vertical: 6.h,
      ),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(4.r),
      ),
      child: Text(
        status,
        style: TextStyle(
          fontSize: 13.sp,
          fontWeight: FontWeight.w500,
          color: textColor,
        ),
      ),
    );
  }

  Color _getTrailingColor() {
    // "First place" should be black/bold, others grey
    if (trailingInfo.toLowerCase().contains('first place')) {
      return Colors.black87;
    }
    return Colors.grey[600]!;
  }

  Widget _buildDisjoinButton() {
    return OutlinedButton(
      onPressed: isDisjoinEnabled
          ? () {
              // TODO: Implement disjoin logic
            }
          : null,
      style: OutlinedButton.styleFrom(
        foregroundColor:
            isDisjoinEnabled ? Colors.black87 : Colors.grey[400],
        side: BorderSide(
          color: isDisjoinEnabled ? Colors.black87 : Colors.grey[300]!,
          width: 1.5,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.r),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: 24.w,
          vertical: 10.h,
        ),
      ),
      child: Text(
        'Disjoin',
        style: TextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
          color: isDisjoinEnabled ? Colors.black87 : Colors.grey[400],
        ),
      ),
    );
  }
}
