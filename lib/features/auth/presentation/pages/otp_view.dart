import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:sportify_app/config/locale/app_localizations.dart';
import 'package:sportify_app/config/routes/app_routes.dart';
import 'package:sportify_app/core/utils/app_colors.dart';
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

                // Title
                Text(
                  'enter_verification_code'.tr(context),
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                    color: context.colors.textColor,
                  ),
                ),

                SizedBox(height: 12.h),

                // Subtitle
                RichText(
                  text: TextSpan(
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: MyColors.greyText,
                      height: 1.5,
                    ),
                    children: [
                      TextSpan(
                        text: 'enter_code_sent'.tr(context) + ' ',
                      ),
                      TextSpan(
                        text: '+20 ${widget.phoneNumber}',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: context.colors.textColor,
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 32.h),

                // OTP Input Boxes
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(
                    4,
                    (index) => _buildOtpBox(index),
                  ),
                ),

                SizedBox(height: 24.h),

                // Resend Code
                BlocBuilder<AuthCubit, AuthState>(
                  builder: (context, state) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'didnt_receive_code'.tr(context) + '  ',
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: MyColors.greyText,
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
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: state.otpCountdown == 0
                                  ? MyColors.greenButton
                                  : MyColors.greyText,
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),

                const Spacer(),

                // Confirm Button
                BlocBuilder<AuthCubit, AuthState>(
                  builder: (context, state) {
                    return SizedBox(
                      width: double.infinity,
                      height: 56.h,
                      child: ElevatedButton(
                        onPressed: state.isOtpValid
                            ? () {
                                context.go(Routes.setupProfileRoute);
                              }
                            : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: state.isOtpValid
                              ? MyColors.greenButton
                              : Colors.grey[300],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          elevation: 0,
                          disabledBackgroundColor: Colors.grey[300],
                        ),
                        child: Text(
                          'confirm'.tr(context),
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            color: state.isOtpValid
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

  Widget _buildOtpBox(int index) {
    return Container(
      width: 70.w,
      height: 70.h,
      decoration: BoxDecoration(
        border: Border.all(
          color: MyColors.borderColor,
          width: 1.5,
        ),
        borderRadius: BorderRadius.circular(12.r),
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
        style: TextStyle(
          fontSize: 24.sp,
          fontWeight: FontWeight.w600,
          color: context.colors.textColor,
        ),
      ),
    );
  }
}
