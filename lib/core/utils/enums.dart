// ignore_for_file: constant_identifier_names

enum LanguageCode {
  en,
  ar,
}

enum Themes {
  light,
  dark,
}

enum UserType {
  firstOpen, //WelcomeScreen
  login, // LoginScreen
  pending, // FlowScreen
  refused, // FlowScreen
  approved,
  user,
  doctor,
  delivery, // HomeScreen
}

enum UserStatus {
  pending,
  approved,
  refused,
}

enum SettleType {
  deposit,
  withdrawal,
  no_settle,
}

enum Modules { settlement, booking }

enum AppUpdateType {
  flexible,
  immediately,
}
