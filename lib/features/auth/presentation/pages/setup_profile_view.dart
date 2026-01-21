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
import 'package:sportify_app/core/utils/validator.dart';
import 'package:sportify_app/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:sportify_app/injection_container.dart';

class SetupProfileView extends StatelessWidget {
  const SetupProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return const SetupProfileViewBody();
  }
}

class SetupProfileViewBody extends StatefulWidget {
  const SetupProfileViewBody({super.key});

  @override
  State<SetupProfileViewBody> createState() =>
      _SetupProfileViewBodyState();
}

class _SetupProfileViewBodyState
    extends State<SetupProfileViewBody> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  bool _hasAttemptedValidation = false;

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

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  String _formatDate(DateTime? date) {
    if (date == null) return '';
    return DateFormat('d MMM yyyy').format(date);
  }

  void _handleContinue(BuildContext context) {
    final cubit = context.read<AuthCubit>();
    // Mark that validation has been attempted
    setState(() {
      _hasAttemptedValidation = true;
    });

    // Validate form fields
    if (_formKey.currentState!.validate()) {
      // Additional validation for date of birth (not a TextFormField)
      if (cubit.state.dateOfBirth == null) {
        return;
      }
      cubit.updateFullName(_nameController.text.trim());
      if (_emailController.text.trim().isNotEmpty) {
        cubit.updateEmail(_emailController.text.trim());
      }
      context.go(Routes.homeScreenRoute);
    }
  }

  String? _validateEmailOptional(
    String? value,
    BuildContext context,
  ) {
    if (value == null || value.trim().isEmpty) {
      return null; // Email is optional
    }
    return Validator.validateEmail(value, context);
  }

  String? _validateGender(
    String? value,
    BuildContext context,
  ) {
    if (value == null || value.isEmpty) {
      return Validator.validateRequired(value, context);
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    // Detect if keyboard is open
    final bool isKeyboardOpen =
        MediaQuery.of(context).viewInsets.bottom > 0;

    return Scaffold(
      resizeToAvoidBottomInset: true,
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
          style: TextStyles.semiBold18(
            color: MyColors.darkGrayColor,
          ),
        ),
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: constraints.maxHeight,
                  ),
                  child: IntrinsicHeight(
                    child: Padding(
                      padding: AppPadding.h20,
                      child: Column(
                        children: [
                  SizedBox(height: AppDimens.h24),

                  // Full Name
                  TextFormField(
                    controller: _nameController,
                    style: TextStyles.regular16(
                      color: MyColors.darkGrayColor,
                    ),
                    validator: (value) =>
                        Validator.validateName(
                          value,
                          context,
                        ),
                    onChanged: (value) {
                      context
                          .read<AuthCubit>()
                          .updateFullName(value);
                    },
                    decoration: InputDecoration(
                      hintText: 'full_name'.tr(context),
                      hintStyle: TextStyles.regular16(
                        color: MyColors.greyText,
                      ),
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
                      errorBorder: OutlineInputBorder(
                        borderRadius: AppRadius.r10,
                        borderSide: BorderSide(
                          color: MyColors.errorColor,
                          width: AppDimens.borderWidth2,
                        ),
                      ),
                      focusedErrorBorder:
                          OutlineInputBorder(
                            borderRadius: AppRadius.r10,
                            borderSide: BorderSide(
                              color: MyColors.errorColor,
                              width: AppDimens.borderWidth2,
                            ),
                          ),
                      contentPadding: AppPadding.h16v16,
                      errorStyle: TextStyle(
                        fontSize: 12,
                        color: MyColors.errorColor,
                      ),
                    ),
                  ),

                  SizedBox(height: AppDimens.h20),

                  // Email (Optional)
                  TextFormField(
                    controller: _emailController,
                    keyboardType:
                        TextInputType.emailAddress,
                    style: TextStyles.regular16(
                      color: MyColors.darkGrayColor,
                    ),
                    validator: (value) =>
                        _validateEmailOptional(
                          value,
                          context,
                        ),
                    onChanged: (value) {
                      if (value.trim().isNotEmpty) {
                        context
                            .read<AuthCubit>()
                            .updateEmail(value);
                      }
                    },
                    decoration: InputDecoration(
                      hintText: 'email_optional'.tr(
                        context,
                      ),
                      hintStyle: TextStyles.regular16(
                        color: MyColors.greyText,
                      ),
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
                      errorBorder: OutlineInputBorder(
                        borderRadius: AppRadius.r10,
                        borderSide: BorderSide(
                          color: MyColors.errorColor,
                          width: AppDimens.borderWidth2,
                        ),
                      ),
                      focusedErrorBorder:
                          OutlineInputBorder(
                            borderRadius: AppRadius.r10,
                            borderSide: BorderSide(
                              color: MyColors.errorColor,
                              width: AppDimens.borderWidth2,
                            ),
                          ),
                      contentPadding: AppPadding.h16v16,
                      errorStyle: TextStyle(
                        fontSize: 12,
                        color: MyColors.errorColor,
                      ),
                    ),
                  ),

                  SizedBox(height: AppDimens.h20),

                  // Gender Dropdown
                  BlocBuilder<AuthCubit, AuthState>(
                    builder: (context, state) {
                      return DropdownButtonFormField<
                        String
                      >(
                        value: state.gender,
                        validator: (value) =>
                            _validateGender(value, context),
                        hint: Text(
                          'gender'.tr(context),
                          style: TextStyles.regular16(
                            color: MyColors.greyText,
                          ),
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
                          errorBorder: OutlineInputBorder(
                            borderRadius: AppRadius.r10,
                            borderSide: BorderSide(
                              color: MyColors.errorColor,
                              width: AppDimens.borderWidth2,
                            ),
                          ),
                          focusedErrorBorder:
                              OutlineInputBorder(
                                borderRadius: AppRadius.r10,
                                borderSide: BorderSide(
                                  color:
                                      MyColors.errorColor,
                                  width: AppDimens
                                      .borderWidth2,
                                ),
                              ),
                          contentPadding: AppPadding.h16v16,
                          errorStyle: TextStyle(
                            fontSize: 12,
                            color: MyColors.errorColor,
                          ),
                        ),
                        items: [
                          DropdownMenuItem(
                            value: 'male',
                            child: Text(
                              'male'.tr(context),
                              style: TextStyles.regular16(
                                color: MyColors.darkGrayColor,
                              ),
                            ),
                          ),
                          DropdownMenuItem(
                            value: 'female',
                            child: Text(
                              'female'.tr(context),
                              style: TextStyles.regular16(
                                color: MyColors.darkGrayColor,
                              ),
                            ),
                          ),
                        ],
                        onChanged: (value) {
                          context
                              .read<AuthCubit>()
                              .updateGender(value);
                        },
                      );
                    },
                  ),

                  SizedBox(height: AppDimens.h20),

                  // Date of Birth
                  BlocBuilder<AuthCubit, AuthState>(
                    builder: (context, state) {
                      final hasError =
                          state.dateOfBirth == null &&
                          _hasAttemptedValidation;
                      return Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
                        children: [
                          InkWell(
                            onTap: () =>
                                _selectDate(context),
                            child: Container(
                              padding: AppPadding.h16v16,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: hasError
                                      ? MyColors.errorColor
                                      : MyColors
                                            .borderColor,
                                  width: AppDimens
                                      .borderWidth2,
                                ),
                                borderRadius: AppRadius.r10,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment
                                        .spaceBetween,
                                children: [
                                  Text(
                                    state.dateOfBirth !=
                                            null
                                        ? _formatDate(
                                            state
                                                .dateOfBirth,
                                          )
                                        : 'date_of_birth'
                                              .tr(context),
                                    style: TextStyles.regular16(
                                      color:
                                          state.dateOfBirth !=
                                              null
                                          ? MyColors
                                                .darkGrayColor
                                          : MyColors
                                                .greyText,
                                    ),
                                  ),
                                  Icon(
                                    Icons
                                        .keyboard_arrow_down,
                                    color:
                                        MyColors.greyText,
                                    size: AppDimens.w20,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          if (hasError)
                            Padding(
                              padding: EdgeInsets.only(
                                top: 8,
                              ),
                              child: Text(
                                'error_field_required'.tr(
                                  context,
                                ),
                                style: TextStyle(
                                  fontSize: 12,
                                  color:
                                      MyColors.errorColor,
                                ),
                              ),
                            ),
                        ],
                      );
                    },
                  ),

                          // Dynamic Spacing
                          if (isKeyboardOpen)
                            SizedBox(height: AppDimens.h24)
                          else
                            const Spacer(),

                          // Continue Button
                          BlocBuilder<AuthCubit, AuthState>(
                            builder: (context, state) {
                              final isValid =
                                  state.fullName.isNotEmpty &&
                                  state.gender != null &&
                                  state.dateOfBirth != null;
                              return SizedBox(
                                width: double.infinity,
                                height: AppDimens.buttonHeight56,
                                child: ElevatedButton(
                                  onPressed: isValid
                                      ? () =>
                                            _handleContinue(context)
                                      : null,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: isValid
                                        ? MyColors.greenButton
                                        : MyColors.grey300,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: AppRadius.r12,
                                    ),
                                    elevation: AppDimens.elevation0,
                                    disabledBackgroundColor:
                                        MyColors.grey300,
                                  ),
                                  child: Text(
                                    'continue'.tr(context),
                                    style: TextStyles.semiBold20(
                                      color: isValid
                                          ? Colors.white
                                          : MyColors.grey500,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),

                          // Bottom padding for aesthetics when keyboard is closed
                          if (!isKeyboardOpen)
                            SizedBox(height: AppDimens.h32),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
