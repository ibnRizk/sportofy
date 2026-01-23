import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sportify_app/core/utils/app_colors.dart';
import 'package:sportify_app/core/utils/app_dimens.dart';
import 'package:sportify_app/core/utils/app_padding.dart';
import 'package:sportify_app/core/utils/app_radius.dart';
import 'package:sportify_app/core/utils/values/text_styles.dart';
import 'package:sportify_app/config/routes/app_routes.dart';
import 'package:sportify_app/features/payment/presentation/widgets/payment_methods_sheet.dart';

class JoinTeamSheet extends StatelessWidget {
  const JoinTeamSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppPadding.h20,
      decoration: BoxDecoration(
        color: MyColors.white,
        borderRadius: AppRadius.top30,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Drag Handle
          SizedBox(height: AppDimens.h12),
          Container(
            width: AppDimens.w40,
            height: AppDimens.h4,
            decoration: BoxDecoration(
              color: MyColors.grey300,
              borderRadius: AppRadius.r2,
            ),
          ),

          SizedBox(height: AppDimens.h20),

          // Title
          Text(
            'Join with your team',
            style: TextStyles.bold18(color: MyColors.black),
            textAlign: TextAlign.center,
          ),

          SizedBox(height: AppDimens.h20),

          // Team Card (Reusing the Strict Layout)
          _TeamCard(
            teamName: 'Team Name',
            memberCount: '17 member',
            avatarImage: 'assets/images/team3.png',
            extraMembersCount: 6,
          ),

          SizedBox(height: AppDimens.h16),

          // Rich Text with Hyperlink
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              style: TextStyles.regular14(
                color: MyColors.grey700,
              ).copyWith(height: 1.5),
              children: [
                const TextSpan(
                  text:
                      'If you want to change your team, you can\ndo so by your profile ',
                ),
                TextSpan(
                  text: 'View Profile',
                  style: TextStyles.bold14(
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

          SizedBox(height: AppDimens.h24),

          // Join Button
          SizedBox(
            width: double.infinity,
            height: AppDimens.buttonHeight50,
            child: ElevatedButton(
              onPressed: () {
                // Capture root navigator context before popping
                final rootNavigator = Navigator.of(
                  context,
                  rootNavigator: true,
                );

                // Close "Join with team" sheet
                Navigator.pop(context);

                // Open "Payment Methods" sheet after a short delay
                Future.delayed(
                  const Duration(milliseconds: 300),
                  () {
                    showModalBottomSheet(
                      context: rootNavigator.context,
                      isScrollControlled: true,
                      backgroundColor: MyColors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: AppRadius.top30,
                      ),
                      builder: (context) =>
                          const PaymentMethodsSheet(),
                    );
                  },
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: MyColors.greenButton,
                disabledBackgroundColor: MyColors.grey300,
                disabledForegroundColor: MyColors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: AppRadius.r10,
                ),
                elevation: AppDimens.elevation0,
              ),
              child: Text(
                'Join',
                style: TextStyles.bold16(
                  color: MyColors.white,
                ),
              ),
            ),
          ),

          SizedBox(height: AppDimens.h20),
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
      padding: AppPadding.p15,
      decoration: BoxDecoration(
        color: MyColors.white,
        border: Border.all(
          color: MyColors.grey300,
          width: AppDimens.borderWidth1,
        ),
        borderRadius: AppRadius.r12,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // LEADING: Team Logo
          CircleAvatar(
            radius: AppDimens.avatarSize25,
            backgroundImage: AssetImage(avatarImage),
          ),

          SizedBox(width: AppDimens.w12),

          // MIDDLE: Team Info (Expanded)
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  teamName,
                  style: TextStyles.bold16(
                    color: MyColors.black,
                  ),
                ),
                SizedBox(height: AppDimens.h4),
                Text(
                  memberCount,
                  style: TextStyles.regular12(
                    color: MyColors.grey600,
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
                width: AppDimens.w80,
                height: AppDimens.h30,
                child: Stack(
                  children: [
                    // Avatar 1
                    Positioned(
                      left: 0,
                      child: CircleAvatar(
                        radius: AppDimens.avatarSize15,
                        backgroundColor: MyColors.white,
                        child: CircleAvatar(
                          radius: AppDimens.avatarSize13,
                          backgroundImage: AssetImage(
                            avatarImage,
                          ),
                        ),
                      ),
                    ),

                    // Avatar 2
                    Positioned(
                      left: AppDimens.w15,
                      child: CircleAvatar(
                        radius: AppDimens.avatarSize15,
                        backgroundColor: MyColors.white,
                        child: CircleAvatar(
                          radius: AppDimens.avatarSize13,
                          backgroundImage: AssetImage(
                            avatarImage,
                          ),
                        ),
                      ),
                    ),

                    // Avatar 3
                    Positioned(
                      left: AppDimens.w30,
                      child: CircleAvatar(
                        radius: AppDimens.avatarSize15,
                        backgroundColor: MyColors.white,
                        child: CircleAvatar(
                          radius: AppDimens.avatarSize13,
                          backgroundImage: AssetImage(
                            avatarImage,
                          ),
                        ),
                      ),
                    ),

                    // Avatar 4 (The "+X")
                    Positioned(
                      left: AppDimens.w45,
                      child: CircleAvatar(
                        radius: AppDimens.avatarSize15,
                        backgroundColor: MyColors.white,
                        child: CircleAvatar(
                          radius: AppDimens.avatarSize13,
                          backgroundColor: MyColors.black87,
                          child: Text(
                            '+$extraMembersCount',
                            style: TextStyles.bold9(
                              color: MyColors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(width: AppDimens.w8),

              // The Arrow Icon
              Icon(
                Icons.arrow_forward_ios,
                size: AppDimens.iconSize16,
                color: MyColors.grey600,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
