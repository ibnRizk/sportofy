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
import 'package:sportify_app/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:sportify_app/injection_container.dart';

class OtpView extends StatefulWidget {
  final String phoneNumber;

  const OtpView({super.key, required this.phoneNumber});

  @override
  State<OtpView> createState() => _OtpViewState();
}

class _OtpViewState extends State<OtpView> {
  final List<TextEditingController> _controllers = List.generate(
    4,
    (index) => TextEditingController(),
  );
  final List<FocusNode> _focusNodes = List.generate(
    4,
    (index) => FocusNode(),
  );

  @override
  void initState() {
    super.initState();
    // Timer is started in route creation
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  String _getOtpValue() {
    return _controllers.map((c) => c.text).join();
  }

  void _onOtpChanged(int index, String value) {
    if (value.isNotEmpty && index < 3) {
      _focusNodes[index + 1].requestFocus();
    }
    context.read<AuthCubit>().validateOtp(_getOtpValue());
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                  SizedBox(height: AppDimens.h24),

                  // Title
                  Text(
                    'enter_verification_code'.tr(context),
                    style: TextStyles.bold20(
                      color: MyColors.darkGrayColor,
                    ),
                  ),

                  SizedBox(height: AppDimens.h12),

                  // Subtitle
                  RichText(
                    text: TextSpan(
                      style: TextStyles.regular16(
                        color: MyColors.darkGrayColor,
                      ).copyWith(
                        height: 1.5,
                      ),
                      children: [
                        TextSpan(
                          text: 'enter_code_sent'.tr(context) + ' ',
                        ),
                        TextSpan(
                          text: '+20 ${widget.phoneNumber}',
                          style: TextStyles.regular16(
                            color: MyColors.darkGrayColor,
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: AppDimens.h32),

                  // OTP Input Boxes
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(
                      4,
                      (index) => _buildOtpBox(index),
                    ),
                  ),

                  SizedBox(height: AppDimens.h24),

                  // Resend Code
                  BlocBuilder<AuthCubit, AuthState>(
                    builder: (context, state) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'didnt_receive_code'.tr(context) + '  ',
                            style: TextStyles.regular16(
                              color: MyColors.darkGrayColor,
                            ),
                          ),
                          GestureDetector(
                            onTap: state.otpCountdown == 0
                                ? () {
                                    context.read<AuthCubit>().resendOtp();
                                  }
                                : null,
                            child: Text(
                              '${'send_again'.tr(context)} (${state.otpCountdown})',
                              style: TextStyles.regular16(
                                color: state.otpCountdown == 0
                                    ? MyColors.greenButton
                                    : MyColors.darkGrayColor,
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

                        // Confirm Button
                        BlocBuilder<AuthCubit, AuthState>(
                          builder: (context, state) {
                            return SizedBox(
                              width: double.infinity,
                              height: AppDimens.buttonHeight56,
                              child: ElevatedButton(
                                onPressed: state.isOtpValid
                                    ? () {
                                        context.go(Routes.setupProfileRoute);
                                      }
                                    : null,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: state.isOtpValid
                                      ? MyColors.greenButton
                                      : MyColors.grey300,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: AppRadius.r12,
                                  ),
                                  elevation: AppDimens.elevation0,
                                  disabledBackgroundColor: MyColors.grey300,
                                ),
                                child: Text(
                                  'confirm'.tr(context),
                                  style: TextStyles.semiBold20(
                                    color: state.isOtpValid
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
    );
  }

  Widget _buildOtpBox(int index) {
    return Container(
      width: AppDimens.w70,
      height: AppDimens.h70,
      decoration: BoxDecoration(
        border: Border.all(
          color: MyColors.borderColor,
          width: AppDimens.borderWidth2,
        ),
        borderRadius: AppRadius.r12,
      ),
      child: TextField(
        controller: _controllers[index],
        focusNode: _focusNodes[index],
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        maxLength: 1,
        onChanged: (value) => _onOtpChanged(index, value),
        decoration: const InputDecoration(
          border: InputBorder.none,
          counterText: '',
        ),
        style: TextStyles.regular16(
          color: MyColors.darkGrayColor,
        ),
      ),
    );
  }
}
