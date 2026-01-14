import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:sportify_app/config/locale/app_localizations.dart';
import 'package:sportify_app/config/routes/app_routes.dart';
import 'package:sportify_app/core/utils/app_colors.dart';
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
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: context.colors.black,
          ),
          onPressed: () => context.pop(),
        ),
        title: Text(
          'login'.tr(context),
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
            color: context.colors.black,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 24.h),

              // Welcome Title
              Text(
                'welcome_emoji'.tr(context),
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w700,
                  color: context.colors.textColor,
                ),
              ),

              SizedBox(height: 24.h),

              // Question
              Text(
                'what_is_mobile'.tr(context),
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                  color: context.colors.textColor,
                ),
              ),

              SizedBox(height: 12.h),

              // Subtitle
              Text(
                'send_code_verify'.tr(context),
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: MyColors.greyText,
                  height: 1.5,
                ),
              ),

              SizedBox(height: 32.h),

              // Phone Input Field
              BlocBuilder<AuthCubit, AuthState>(
                builder: (context, state) {
                  return Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: MyColors.borderColor,
                        width: 1.5,
                      ),
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Row(
                      children: [
                        // Flag and Country Code
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12.w),
                          child: Row(
                            children: [
                              AppImage.asset(
                                imageAsset: ImgAssets.egyptFlag,
                                width: 24.w,
                                height: 16.h,
                                fit: BoxFit.cover,
                              ),
                              SizedBox(width: 8.w),
                              Text(
                                '+20',
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w500,
                                  color: context.colors.textColor,
                                ),
                              ),
                              SizedBox(width: 12.w),
                              Container(
                                width: 1,
                                height: 24.h,
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
                              hintStyle: TextStyle(
                                fontSize: 14.sp,
                                color: MyColors.greyText,
                              ),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 12.w,
                                vertical: 16.h,
                              ),
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
                    height: 56.h,
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
                            : Colors.grey[300],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        elevation: 0,
                        disabledBackgroundColor: Colors.grey[300],
                      ),
                      child: Text(
                        'continue'.tr(context),
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: state.isPhoneValid
                              ? Colors.white
                              : Colors.grey[500],
                        ),
                      ),
                    ),
                  );
                },
              ),

              SizedBox(height: 32.h),
            ],
          ),
        ),
      ),
    );
  }
}
