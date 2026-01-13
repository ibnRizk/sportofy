// ignore_for_file: constant_identifier_names

enum PageAnimation { slide, fade, none }

enum DisplayMode { images, videos }

enum AppearanceOption { map, list }

enum ContactOption { phoneAndMessage, phone, message, messageAndTemporaryNumberService, temporaryNumberService, non }

enum Option { dropdown, checkbox, text, numeric, date, radio, multiselect, slider, range }

enum OrderType { pending, end, canceled, review }

enum OrderStatus { accepted, ended, canceled }

enum TypeNotification {
  chat,
  wallet_charge,
  cancellation_accepted_user,
  order_ended,
  order_accepted,
  cancellation_rejected_user,
  order_updated,
  order_rejected,
  order_timed_out,
}
