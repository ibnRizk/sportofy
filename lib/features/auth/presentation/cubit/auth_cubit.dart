import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(const AuthState());

  Timer? _timer;

  // Phone number validation
  void validatePhoneNumber(String phone) {
    final isValid = phone.length >= 10;
    emit(state.copyWith(
      phoneNumber: phone,
      isPhoneValid: isValid,
    ));
  }

  // OTP validation
  void validateOtp(String otp) {
    final isValid = otp.length == 4;
    emit(state.copyWith(
      otp: otp,
      isOtpValid: isValid,
    ));
  }

  // Profile form validation
  void updateFullName(String name) {
    emit(state.copyWith(fullName: name));
    _validateProfileForm();
  }

  void updateEmail(String email) {
    emit(state.copyWith(email: email));
  }

  void updateGender(String? gender) {
    emit(state.copyWith(gender: gender));
    _validateProfileForm();
  }

  void updateDateOfBirth(DateTime? date) {
    emit(state.copyWith(dateOfBirth: date));
    _validateProfileForm();
  }

  void _validateProfileForm() {
    final isValid = state.fullName.isNotEmpty &&
        state.gender != null &&
        state.dateOfBirth != null;
    emit(state.copyWith(isProfileValid: isValid));
  }

  // OTP Timer
  void startOtpTimer() {
    emit(state.copyWith(otpCountdown: 50));
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (state.otpCountdown > 0) {
        emit(state.copyWith(otpCountdown: state.otpCountdown - 1));
      } else {
        timer.cancel();
      }
    });
  }

  void resendOtp() {
    startOtpTimer();
    // Here you would call your API to resend OTP
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
