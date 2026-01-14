part of 'auth_cubit.dart';

class AuthState extends Equatable {
  final String phoneNumber;
  final bool isPhoneValid;
  final String otp;
  final bool isOtpValid;
  final int otpCountdown;
  final String fullName;
  final String email;
  final String? gender;
  final DateTime? dateOfBirth;
  final bool isProfileValid;

  const AuthState({
    this.phoneNumber = '',
    this.isPhoneValid = false,
    this.otp = '',
    this.isOtpValid = false,
    this.otpCountdown = 50,
    this.fullName = '',
    this.email = '',
    this.gender,
    this.dateOfBirth,
    this.isProfileValid = false,
  });

  AuthState copyWith({
    String? phoneNumber,
    bool? isPhoneValid,
    String? otp,
    bool? isOtpValid,
    int? otpCountdown,
    String? fullName,
    String? email,
    String? gender,
    DateTime? dateOfBirth,
    bool? isProfileValid,
  }) {
    return AuthState(
      phoneNumber: phoneNumber ?? this.phoneNumber,
      isPhoneValid: isPhoneValid ?? this.isPhoneValid,
      otp: otp ?? this.otp,
      isOtpValid: isOtpValid ?? this.isOtpValid,
      otpCountdown: otpCountdown ?? this.otpCountdown,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      gender: gender ?? this.gender,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      isProfileValid: isProfileValid ?? this.isProfileValid,
    );
  }

  @override
  List<Object?> get props => [
        phoneNumber,
        isPhoneValid,
        otp,
        isOtpValid,
        otpCountdown,
        fullName,
        email,
        gender,
        dateOfBirth,
        isProfileValid,
      ];
}
