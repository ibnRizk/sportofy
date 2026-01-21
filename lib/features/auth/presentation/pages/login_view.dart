import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sportify_app/config/locale/app_localizations.dart';
import 'package:sportify_app/config/routes/app_routes.dart';
import 'package:sportify_app/core/utils/app_colors.dart';
import 'package:sportify_app/core/utils/app_dimens.dart';
import 'package:sportify_app/core/utils/app_padding.dart';
import 'package:sportify_app/core/utils/app_radius.dart';
import 'package:sportify_app/core/utils/values/text_styles.dart';
import 'package:sportify_app/core/utils/image_manager.dart';
import 'package:sportify_app/core/widgets/app_image.dart';
import 'package:sportify_app/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:sportify_app/injection_container.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: const LoginViewBody(),
    );
  }
}

class LoginViewBody extends StatelessWidget {
  const LoginViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.white,
      appBar: AppBar(
        backgroundColor: context.colors.white,
        elevation: AppDimens.elevation0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: context.colors.black,
          ),
          onPressed: () => context.pop(),
        ),
        title: Text(
          'login'.tr(context),
          style: TextStyles.semiBold18(color: context.colors.black),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: AppPadding.h20,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: AppDimens.h24),

              // Welcome Title
              Text(
                'welcome_emoji'.tr(context),
                style: TextStyles.bold24(color: context.colors.textColor),
              ),

              SizedBox(height: AppDimens.h24),

              // Question
              Text(
                'what_is_mobile'.tr(context),
                style: TextStyles.semiBold18(color: context.colors.textColor),
              ),

              SizedBox(height: AppDimens.h12),

              // Subtitle
              Text(
                'send_code_verify'.tr(context),
                style: TextStyles.regular14(color: MyColors.greyText).copyWith(
                  height: 1.5,
                ),
              ),

              SizedBox(height: AppDimens.h32),

              // Phone Input Field
              BlocBuilder<AuthCubit, AuthState>(
                builder: (context, state) {
                  return Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: MyColors.borderColor,
                        width: AppDimens.borderWidth2,
                      ),
                      borderRadius: AppRadius.r10,
                    ),
                    child: Row(
                      children: [
                        // Flag and Country Code
                        Padding(
                          padding: AppPadding.h12,
                          child: Row(
                            children: [
                              AppImage.asset(
                                imageAsset: ImgAssets.egyptFlag,
                                width: AppDimens.iconSize24,
                                height: AppDimens.h16,
                                fit: BoxFit.cover,
                              ),
                              SizedBox(width: AppDimens.w8),
                              Text(
                                '+20',
                                style: TextStyles.medium16(color: context.colors.textColor),
                              ),
                              SizedBox(width: AppDimens.w12),
                              Container(
                                width: AppDimens.w1,
                                height: AppDimens.h24,
                                color: MyColors.borderColor,
                              ),
                            ],
                          ),
                        ),

                        // Phone Number Input
                        Expanded(
                          child: TextField(
                            keyboardType: TextInputType.phone,
                            onChanged: (value) {
                              context.read<AuthCubit>().validatePhoneNumber(value);
                            },
                            decoration: InputDecoration(
                              hintText: 'enter_phone'.tr(context),
                              hintStyle: TextStyles.regular14(color: MyColors.greyText),
                              border: InputBorder.none,
                              contentPadding: AppPadding.h12v16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),

              const Spacer(),

              // Continue Button
              BlocBuilder<AuthCubit, AuthState>(
                builder: (context, state) {
                  return SizedBox(
                    width: double.infinity,
                    height: AppDimens.buttonHeight56,
                    child: ElevatedButton(
                      onPressed: state.isPhoneValid
                          ? () {
                              context.go(
                                Routes.otpRoute,
                                extra: state.phoneNumber,
                              );
                            }
                          : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: state.isPhoneValid
                            ? MyColors.greenButton
                            : MyColors.grey300,
                        shape: RoundedRectangleBorder(
                          borderRadius: AppRadius.r12,
                        ),
                        elevation: AppDimens.elevation0,
                        disabledBackgroundColor: MyColors.grey300,
                      ),
                      child: Text(
                        'continue'.tr(context),
                        style: TextStyles.semiBold16(
                          color: state.isPhoneValid
                              ? MyColors.white
                              : MyColors.grey500,
                        ),
                      ),
                    ),
                  );
                },
              ),

              SizedBox(height: AppDimens.h32),
            ],
          ),
        ),
      ),
    );
  }
}
