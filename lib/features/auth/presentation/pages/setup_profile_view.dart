import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:sportify_app/config/locale/app_localizations.dart';
import 'package:sportify_app/config/routes/app_routes.dart';
import 'package:sportify_app/core/utils/app_colors.dart';
import 'package:sportify_app/core/utils/app_dimens.dart';
import 'package:sportify_app/core/utils/app_padding.dart';
import 'package:sportify_app/core/utils/app_radius.dart';
import 'package:sportify_app/core/utils/values/text_styles.dart';
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
        elevation: AppDimens.elevation0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: context.colors.black,
          ),
          onPressed: () => context.pop(),
        ),
        title: Text(
          'setup_profile'.tr(context),
          style: TextStyles.semiBold18(color: context.colors.black),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: AppPadding.h20,
          child: Column(
            children: [
              SizedBox(height: AppDimens.h24),

              // Full Name
              BlocBuilder<AuthCubit, AuthState>(
                builder: (context, state) {
                  return TextFormField(
                    onChanged: (value) {
                      context.read<AuthCubit>().updateFullName(value);
                    },
                    decoration: InputDecoration(
                      hintText: 'full_name'.tr(context),
                      hintStyle: TextStyles.regular14(color: MyColors.greyText),
                      border: OutlineInputBorder(
                        borderRadius: AppRadius.r10,
                        borderSide: BorderSide(
                          color: MyColors.borderColor,
                          width: AppDimens.borderWidth2,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: AppRadius.r10,
                        borderSide: BorderSide(
                          color: MyColors.borderColor,
                          width: AppDimens.borderWidth2,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: AppRadius.r10,
                        borderSide: BorderSide(
                          color: MyColors.greenButton,
                          width: AppDimens.borderWidth2,
                        ),
                      ),
                      contentPadding: AppPadding.h16v16,
                    ),
                  );
                },
              ),

              SizedBox(height: AppDimens.h20),

              // Email (Optional)
              TextFormField(
                onChanged: (value) {
                  context.read<AuthCubit>().updateEmail(value);
                },
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: 'email_optional'.tr(context),
                  hintStyle: TextStyles.regular14(color: MyColors.greyText),
                  border: OutlineInputBorder(
                    borderRadius: AppRadius.r10,
                    borderSide: BorderSide(
                      color: MyColors.borderColor,
                      width: AppDimens.borderWidth2,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: AppRadius.r10,
                    borderSide: BorderSide(
                      color: MyColors.borderColor,
                      width: AppDimens.borderWidth2,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: AppRadius.r10,
                    borderSide: BorderSide(
                      color: MyColors.greenButton,
                      width: AppDimens.borderWidth2,
                    ),
                  ),
                  contentPadding: AppPadding.h16v16,
                ),
              ),

              SizedBox(height: AppDimens.h20),

              // Gender Dropdown
              BlocBuilder<AuthCubit, AuthState>(
                builder: (context, state) {
                  return DropdownButtonFormField<String>(
                    value: state.gender,
                    hint: Text(
                      'gender'.tr(context),
                      style: TextStyles.regular14(color: MyColors.greyText),
                    ),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: AppRadius.r10,
                        borderSide: BorderSide(
                          color: MyColors.borderColor,
                          width: AppDimens.borderWidth2,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: AppRadius.r10,
                        borderSide: BorderSide(
                          color: MyColors.borderColor,
                          width: AppDimens.borderWidth2,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: AppRadius.r10,
                        borderSide: BorderSide(
                          color: MyColors.greenButton,
                          width: AppDimens.borderWidth2,
                        ),
                      ),
                      contentPadding: AppPadding.h16v16,
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

              SizedBox(height: AppDimens.h20),

              // Date of Birth
              BlocBuilder<AuthCubit, AuthState>(
                builder: (context, state) {
                  return InkWell(
                    onTap: () => _selectDate(context),
                    child: Container(
                      padding: AppPadding.h16v16,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: MyColors.borderColor,
                          width: AppDimens.borderWidth2,
                        ),
                        borderRadius: AppRadius.r10,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            state.dateOfBirth != null
                                ? _formatDate(state.dateOfBirth)
                                : 'date_of_birth'.tr(context),
                            style: TextStyles.regular14(
                              color: state.dateOfBirth != null
                                  ? context.colors.textColor
                                  : MyColors.greyText,
                            ),
                          ),
                          Icon(
                            Icons.keyboard_arrow_down,
                            color: MyColors.greyText,
                            size: AppDimens.w20,
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
                    height: AppDimens.buttonHeight56,
                    child: ElevatedButton(
                      onPressed: state.isProfileValid
                          ? () {
                              context.go(Routes.homeScreenRoute);
                            }
                          : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: state.isProfileValid
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
                          color: state.isProfileValid
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
