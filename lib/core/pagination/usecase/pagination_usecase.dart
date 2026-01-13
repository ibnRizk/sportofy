import 'package:equatable/equatable.dart';
import 'package:dartz/dartz.dart';

import '../../../../../../core/error/failures.dart';
import '../../usecases/usecase.dart';
import '../entity/pagination_response.dart';
import 'additional_pagination_params.dart';


abstract class PaginationUseCase<T> extends UseCase<PaginationResponse, PaginationParams> {

  @override
  Future<Either<Failure, PaginationResponse<T>>> call(PaginationParams params);

}


class PaginationParams extends Equatable {
  final int? page;
  final int? perPage;
  final String? term;
  final AdditionalPaginationParams? additionalParams;

  const PaginationParams({
    this.page,
    this.perPage,
    this.term,
    this.additionalParams,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'page': page,
      'per_page': perPage,
      'term': term,
    };
    if(additionalParams != null){
      data.addAll(additionalParams!.toJson());
    }
    return data;
  }

  @override
  List<Object?> get props => <Object?>[
    page,
    perPage,
    term,
    additionalParams,
  ];

}



