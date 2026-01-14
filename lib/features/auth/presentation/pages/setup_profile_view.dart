import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:sportify_app/config/locale/app_localizations.dart';
import 'package:sportify_app/config/routes/app_routes.dart';
import 'package:sportify_app/core/utils/app_colors.dart';
import 'package:sportify_app/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:sportify_app/injection_container.dart';

class SetupProfileView extends StatelessWidget {
  const SetupProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return const SetupProfileViewBody();
  }
}

class SetupProfileViewBody extends StatelessWidget {
  const SetupProfileViewBody({super.key});

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(1996),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: MyColors.greenButton,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && context.mounted) {
      context.read<AuthCubit>().updateDateOfBirth(picked);
    }
  }

  String _formatDate(DateTime? date) {
    if (date == null) return '';
    return DateFormat('d MMM yyyy').format(date);
  }

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
          'setup_profile'.tr(context),
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
            children: [
              SizedBox(height: 24.h),

              // Full Name
              BlocBuilder<AuthCubit, AuthState>(
                builder: (context, state) {
                  return TextFormField(
                    onChanged: (value) {
                      context.read<AuthCubit>().updateFullName(value);
                    },
                    decoration: InputDecoration(
                      hintText: 'full_name'.tr(context),
                      hintStyle: TextStyle(
                        fontSize: 14.sp,
                        color: MyColors.greyText,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.r),
                        borderSide: BorderSide(
                          color: MyColors.borderColor,
                          width: 1.5,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.r),
                        borderSide: BorderSide(
                          color: MyColors.borderColor,
                          width: 1.5,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.r),
                        borderSide: BorderSide(
                          color: MyColors.greenButton,
                          width: 1.5,
                        ),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 16.h,
                      ),
                    ),
                  );
                },
              ),

              SizedBox(height: 20.h),

              // Email (Optional)
              TextFormField(
                onChanged: (value) {
                  context.read<AuthCubit>().updateEmail(value);
                },
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: 'email_optional'.tr(context),
                  hintStyle: TextStyle(
                    fontSize: 14.sp,
                    color: MyColors.greyText,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.r),
                    borderSide: BorderSide(
                      color: MyColors.borderColor,
                      width: 1.5,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.r),
                    borderSide: BorderSide(
                      color: MyColors.borderColor,
                      width: 1.5,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.r),
                    borderSide: BorderSide(
                      color: MyColors.greenButton,
                      width: 1.5,
                    ),
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 16.h,
                  ),
                ),
              ),

              SizedBox(height: 20.h),

              // Gender Dropdown
              BlocBuilder<AuthCubit, AuthState>(
                builder: (context, state) {
                  return DropdownButtonFormField<String>(
                    value: state.gender,
                    hint: Text(
                      'gender'.tr(context),
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: MyColors.greyText,
                      ),
                    ),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.r),
                        borderSide: BorderSide(
                          color: MyColors.borderColor,
                          width: 1.5,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.r),
                        borderSide: BorderSide(
                          color: MyColors.borderColor,
                          width: 1.5,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.r),
                        borderSide: BorderSide(
                          color: MyColors.greenButton,
                          width: 1.5,
                        ),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 16.h,
                      ),
                    ),
                    items: [
                      DropdownMenuItem(
                        value: 'male',
                        child: Text('male'.tr(context)),
                      ),
                      DropdownMenuItem(
                        value: 'female',
                        child: Text('female'.tr(context)),
                      ),
                    ],
                    onChanged: (value) {
                      context.read<AuthCubit>().updateGender(value);
                    },
                  );
                },
              ),

              SizedBox(height: 20.h),

              // Date of Birth
              BlocBuilder<AuthCubit, AuthState>(
                builder: (context, state) {
                  return InkWell(
                    onTap: () => _selectDate(context),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 16.h,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: MyColors.borderColor,
                          width: 1.5,
                        ),
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            state.dateOfBirth != null
                                ? _formatDate(state.dateOfBirth)
                                : 'date_of_birth'.tr(context),
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: state.dateOfBirth != null
                                  ? context.colors.textColor
                                  : MyColors.greyText,
                            ),
                          ),
                          Icon(
                            Icons.keyboard_arrow_down,
                            color: MyColors.greyText,
                            size: 20.w,
                          ),
                        ],
                      ),
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
                      onPressed: state.isProfileValid
                          ? () {
                              context.go(Routes.homeScreenRoute);
                            }
                          : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: state.isProfileValid
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
                          color: state.isProfileValid
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
