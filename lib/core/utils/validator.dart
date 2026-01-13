import 'package:flutter/material.dart';
import 'package:sportify_app/config/locale/app_localizations.dart';

abstract class Validator {
  static String? call({
    required String? value,
    required ValidatorType type,
    required BuildContext context,
  }) {
    String? validateNotEmpty = _notEmpty(value, context);
    if (validateNotEmpty == null) {
      return type.condition.call(value!) ??
          validateNotEmpty;
    }
    return validateNotEmpty;
  }

  static String? _notEmpty(String? value, context) {
    if (value != null && value.trim().isEmpty) {
      return 'error_field_required'.tr(context);
    }
    return null;
  }

  static String? _name(String value, context) {
    if (value.trim().split(' ').length < 2) {
      return 'error_valid_name'.tr(context);
    }
    return null;
  }

  static String? _phone(String value, context) {
    const pattern =
        r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$';
    final regExp = RegExp(pattern);
    if (!regExp.hasMatch(value)) {
      return 'error_valid_phone_number'.tr(context);
    }
    return null;
  }

  static String? _email(String value, context) {
    const pattern =
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
    final regExp = RegExp(pattern);
    if (!regExp.hasMatch(value)) {
      return 'error_valid_email'.tr(context);
    }
    return null;
  }

  static String? _textOnly(String value, context) {
    const pattern = '[a-zA-Z]';
    final regExp = RegExp(pattern);
    if (!regExp.hasMatch(value)) {
      return 'error_valid_text'.tr(context);
    }
    return null;
  }

  static String? _numbersOnly(String value, context) {
    final int? number = int.tryParse(value);
    if (number == null) {
      return 'error_valid_numbers'.tr(context);
    }
    return null;
  }

  // static String? _passwordOld(String value) {
  //   const pattern =
  //       r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$';

  //   final regExp = RegExp(pattern);
  //   if (!regExp.hasMatch(value)) {
  //     return Strings.errorValidPassword;
  //   }
  //   return null;
  // }

  static String? _password(String? password, context) {
    if (password == null || password.isEmpty) {
      return 'error_valid_password'.tr(context);
    }

    // bool hasUppercase = password.contains(RegExp(r'[A-Z]'));
    bool hasDigits = password.contains(RegExp(r'[0-9]'));
    // bool hasLowercase = password.contains(RegExp(r'[a-z]'));
    // bool hasSpecialCharacters =
    //     password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
    bool hasMinLength = password.length > 7;
    bool isValid =
        hasDigits &
        // hasUppercase &
        // hasLowercase &
        // hasSpecialCharacters &
        hasMinLength;
    return isValid
        ? null
        : 'error_valid_password'.tr(context);
  }

  static String? _confirmPassword(
    String value,
    String? password,
    context,
  ) {
    final String? notEmptyPassword = _notEmpty(
      password,
      context,
    );
    if (notEmptyPassword != null) {
      if (value != password) {
        return 'error_valid_password_confirm'.tr(context);
      }
    }
    return null;
  }
}

enum ValidatorType {
  standard,
  name,
  email,
  phone,
  textOnly,
  numbersOnly,
  password,
  confirmPassword,
}

extension ValidatorTypeExtension on ValidatorType {
  get condition {
    switch (this) {
      case ValidatorType.standard:
        return Validator._notEmpty;
      case ValidatorType.name:
        return Validator._name;
      case ValidatorType.email:
        return Validator._email;
      case ValidatorType.phone:
        return Validator._phone;
      case ValidatorType.textOnly:
        return Validator._textOnly;
      case ValidatorType.numbersOnly:
        return Validator._numbersOnly;
      case ValidatorType.password:
        return Validator._password;
      case ValidatorType.confirmPassword:
        return Validator._confirmPassword;
    }
  }
}
