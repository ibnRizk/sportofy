import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sportify_app/config/locale/app_localizations.dart';
import 'package:sportify_app/config/routes/app_routes.dart';
import 'package:sportify_app/core/utils/app_colors.dart';
import 'package:sportify_app/core/utils/app_dimens.dart';
import 'package:sportify_app/core/utils/app_padding.dart';
import 'package:sportify_app/core/utils/app_radius.dart';
import 'package:sportify_app/core/utils/values/text_styles.dart';
import 'package:sportify_app/core/utils/validator.dart';
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

class LoginViewBody extends StatefulWidget {
  const LoginViewBody({super.key});

  @override
  State<LoginViewBody> createState() =>
      _LoginViewBodyState();
}

class _LoginViewBodyState extends State<LoginViewBody> {
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  void _handleLogin(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      final phoneNumber = _phoneController.text.trim();
      context.read<AuthCubit>().validatePhoneNumber(
        phoneNumber,
      );
      context.go(Routes.otpRoute, extra: phoneNumber);
    }
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
          'login'.tr(context),
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
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: AppDimens.h24),

                          // Welcome Title
                          Text(
                            'welcome_emoji'.tr(context),
                            style: TextStyles.bold20(
                              color: MyColors.darkGrayColor,
                            ),
                          ),

                          SizedBox(height: AppDimens.h24),

                          // Question
                          Text(
                            'what_is_mobile'.tr(context),
                            style: TextStyles.bold20(
                              color: MyColors.darkGrayColor,
                            ),
                          ),

                          SizedBox(height: AppDimens.h12),

                          // Subtitle
                          Text(
                            'send_code_verify'.tr(context),
                            style: TextStyles.regular16(
                              color: MyColors.darkGrayColor,
                            ).copyWith(height: 1.5),
                          ),

                          SizedBox(height: AppDimens.h32),

                          // Phone Input Field
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: MyColors.borderColor,
                                width:
                                    AppDimens.borderWidth2,
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
                                        imageAsset:
                                            ImgAssets
                                                .egyptFlag,
                                        width: AppDimens
                                            .iconSize24,
                                        height:
                                            AppDimens.h16,
                                        fit: BoxFit.cover,
                                      ),
                                      SizedBox(
                                        width: AppDimens.w8,
                                      ),
                                      Text(
                                        '+20',
                                        style:
                                            TextStyles.medium16(
                                              color: context
                                                  .colors
                                                  .textColor,
                                            ),
                                      ),
                                      SizedBox(
                                        width:
                                            AppDimens.w12,
                                      ),
                                      Container(
                                        width: AppDimens.w1,
                                        height:
                                            AppDimens.h24,
                                        color: MyColors
                                            .borderColor,
                                      ),
                                    ],
                                  ),
                                ),

                                // Phone Number Input
                                Expanded(
                                  child: TextFormField(
                                    controller:
                                        _phoneController,
                                    keyboardType:
                                        TextInputType.phone,
                                    inputFormatters: [
                                      FilteringTextInputFormatter
                                          .digitsOnly,
                                      LengthLimitingTextInputFormatter(
                                        11,
                                      ),
                                    ],
                                    validator: (value) =>
                                        Validator.validatePhoneNumber(
                                          value,
                                          context,
                                        ),
                                    onChanged: (value) {
                                      context
                                          .read<AuthCubit>()
                                          .validatePhoneNumber(
                                            value,
                                          );
                                    },
                                    style:
                                        TextStyles.regular16(
                                          color: MyColors
                                              .darkGrayColor,
                                        ),
                                    decoration: InputDecoration(
                                      hintText:
                                          'enter_phone'.tr(
                                            context,
                                          ),
                                      hintStyle:
                                          TextStyles.regular16(
                                            color: MyColors
                                                .greyText,
                                          ),
                                      border:
                                          InputBorder.none,
                                      errorBorder:
                                          InputBorder.none,
                                      focusedErrorBorder:
                                          InputBorder.none,
                                      enabledBorder:
                                          InputBorder.none,
                                      focusedBorder:
                                          InputBorder.none,
                                      disabledBorder:
                                          InputBorder.none,
                                      contentPadding:
                                          AppPadding.h12v16,
                                      errorStyle: TextStyle(
                                        fontSize: 12,
                                        color: MyColors
                                            .errorColor,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
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
                                  _phoneController.text
                                          .trim()
                                          .length ==
                                      11 &&
                                  _phoneController.text
                                      .trim()
                                      .startsWith('01');
                              return SizedBox(
                                width: double.infinity,
                                height: AppDimens
                                    .buttonHeight56,
                                child: ElevatedButton(
                                  onPressed: isValid
                                      ? () => _handleLogin(
                                          context,
                                        )
                                      : null,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: isValid
                                        ? MyColors
                                              .greenButton
                                        : MyColors.grey300,
                                    shape:
                                        RoundedRectangleBorder(
                                          borderRadius:
                                              AppRadius.r12,
                                        ),
                                    elevation: AppDimens
                                        .elevation0,
                                    disabledBackgroundColor:
                                        MyColors.grey300,
                                  ),
                                  child: Text(
                                    'continue'.tr(context),
                                    style:
                                        TextStyles.semiBold20(
                                          color: isValid
                                              ? Colors.white
                                              : MyColors
                                                    .grey500,
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
