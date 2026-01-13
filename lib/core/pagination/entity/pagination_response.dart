import 'package:equatable/equatable.dart';

class PaginationResponse<T> extends Equatable{
  final bool? success;
  final String? message;
  final PaginationMeta meta;
  final List<T> data;
  final Map<String, dynamic>? response;

  const PaginationResponse({
    this.success,
    this.message,
    required this.meta,
    required this.data,
    this.response,
  });

  @override
  List<Object?> get props => <Object?>[
    success,
    message,
    meta,
    data,
    response,
  ];
}

class PaginationMeta extends Equatable{
  final int currentPage;
  final int lastPage;
  final int perPage;
  final int total;

  const PaginationMeta({
    required this.currentPage,
    required this.lastPage,
    this.perPage = 10,
    required this.total,
  });

  @override
  List<Object?> get props => <Object?>[
    currentPage,
    lastPage,
    perPage,
    total,
  ];

  PaginationMeta copyWith({
    int? currentPage,
    int? lastPage,
    int? perPage,
    int? total,
  }) => PaginationMeta(
    currentPage: currentPage ?? this.currentPage,
    lastPage: lastPage ?? this.lastPage,
    perPage: perPage ?? this.perPage,
    total: total ?? this.total,
  );

}