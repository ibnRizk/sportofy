import 'package:equatable/equatable.dart';

class BaseOneResponse extends Equatable {
  const BaseOneResponse({
    this.data,
    this.message,
    this.success,
    this.statusCode,
  });

  final dynamic data;
  final String? message;
  final bool? success;
  final num? statusCode;

  @override
  List<Object?> get props => [
        data,
        message,
        success,
        statusCode,
      ];
}
