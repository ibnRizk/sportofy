import 'app_enums.dart';

extension StatusLevelExtension on StatusLevel{
  static StatusLevel fromString(String value) {
    for (StatusLevel type in StatusLevel.values) {
      if (type.name.toLowerCase() == value.toLowerCase()) {
        return type;
      }
    }
    throw Exception('$value is not a valid TripType');
  }
}