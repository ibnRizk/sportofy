import '../entity/pagination_response.dart';

class PaginationModel<T, Model extends T> extends PaginationResponse<T> {

  const PaginationModel({
    required super.success,
    required super.message,
    required super.meta,
    required super.data,
    required super.response,
  });

  factory PaginationModel.fromJson({
    required Map<String, dynamic> json,
    required Model Function(Map<String, dynamic> json) fetchDataModel,
  }) {
    return PaginationModel(
      response: json,
      success: json['success'],
      message: json['message'] ?? '',
      meta: PaginationMetaModel.fromJson(json: json['pagination'] as Map<String, dynamic>),
      data: (json['data'] as List<dynamic>)
          .map((dynamic e) => fetchDataModel(e))
          .toList(),
    );
  }
}

class PaginationMetaModel extends PaginationMeta {
  const PaginationMetaModel({
    required super.currentPage,
    required super.lastPage,
    required super.perPage,
    required super.total,
  });

  factory PaginationMetaModel.fromJson({
    required Map<String, dynamic> json,
  }) =>
      PaginationMetaModel(
        currentPage: json['current_page'] != null
            ? num.tryParse(json['current_page'].toString())?.toInt() ?? -1
            : -1,
        lastPage: json['last_page'] != null
            ? num.tryParse(json['last_page'].toString())?.toInt() ?? -1
            : -1,
        perPage: json['per_page'] != null
            ? num.tryParse(json['per_page'].toString())?.toInt() ?? -1
            : -1,
        total: json['total'] != null
            ? num.tryParse(json['total'].toString())?.toInt() ?? -1
            : -1,
      );
}
