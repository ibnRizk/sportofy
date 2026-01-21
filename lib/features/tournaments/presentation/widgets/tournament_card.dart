import 'package:flutter/material.dart';
import 'package:sportify_app/core/utils/app_colors.dart';
import 'package:sportify_app/core/utils/app_dimens.dart';
import 'package:sportify_app/core/utils/app_padding.dart';
import 'package:sportify_app/core/utils/app_radius.dart';
import 'package:sportify_app/core/utils/values/text_styles.dart';
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
      margin: AppPadding.bottom16,
      padding: AppPadding.p16,
      decoration: BoxDecoration(
        color: MyColors.white,
        borderRadius: AppRadius.r12,
        boxShadow: [
          BoxShadow(
            color: MyColors.black.withValues(alpha: AppDimens.opacity05),
            blurRadius: AppDimens.elevation8,
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
                style: TextStyles.bold14(color: MyColors.black87),
              ),
              _buildStatusBadge(),
            ],
          ),

          SizedBox(height: AppDimens.h12),

          // Info Row: Team Avatar + Name + Trailing Info
          Row(
            children: [
              // Team Avatar
              CircleAvatar(
                radius: AppDimens.avatarSize22,
                backgroundImage: AssetImage(ImgAssets.team3),
              ),

              SizedBox(width: AppDimens.w12),

              // Team Name
              Expanded(
                child: Text(
                  teamName,
                  style: TextStyles.bold15(color: MyColors.black87),
                ),
              ),

              // Trailing Info
              Text(
                trailingInfo,
                style: TextStyles.medium13(color: _getTrailingColor()),
              ),
            ],
          ),

          // Divider
          Divider(
            height: AppDimens.h24,
            thickness: AppDimens.dividerThickness1,
            color: MyColors.grey200,
          ),

          // Footer Row: Joined Date + Disjoin Button
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Joined at $joinedDate',
                style: TextStyles.regular13(color: MyColors.grey600),
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
        bgColor = MyColors.lightBlue100; // Light Blue
        textColor = MyColors.blue700; // Blue
        break;
      case 'finished':
        bgColor = MyColors.green.withValues(alpha: AppDimens.opacity1); // Light Green
        textColor = MyColors.green; // Green
        break;
      case 'pending':
        bgColor = MyColors.orange.withValues(alpha: AppDimens.opacity1); // Light Orange
        textColor = MyColors.orange; // Orange
        break;
      default:
        bgColor = MyColors.grey200;
        textColor = MyColors.grey700;
    }

    return Container(
      padding: AppPadding.h12v6,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: AppRadius.r4,
      ),
      child: Text(
        status,
        style: TextStyles.medium13(color: textColor),
      ),
    );
  }

  Color _getTrailingColor() {
    // "First place" should be black/bold, others grey
    if (trailingInfo.toLowerCase().contains('first place')) {
      return MyColors.black87;
    }
    return MyColors.grey600;
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
            isDisjoinEnabled ? MyColors.black87 : MyColors.grey400,
        side: BorderSide(
          color: isDisjoinEnabled ? MyColors.black87 : MyColors.grey300,
          width: AppDimens.borderWidth2,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: AppRadius.r8,
        ),
        padding: AppPadding.h24v10,
      ),
      child: Text(
        'Disjoin',
        style: TextStyles.medium14(
          color: isDisjoinEnabled ? MyColors.black87 : MyColors.grey400,
        ),
      ),
    );
  }
}
