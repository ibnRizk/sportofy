import 'package:equatable/equatable.dart';

import '/core/base_classes/pagination.dart';

class BaseListResponse extends Equatable {
  const BaseListResponse({
    this.data,
    this.message,
    this.success,
    this.pagination,
    this.statusCode,
  });

  final List<dynamic>? data;
  final String? message;
  final bool? success;
  final Pagination? pagination;
  final num? statusCode;

  @override
  List<Object?> get props => [
        data,
        message,
        success,
        pagination,
        statusCode,
      ];
}
