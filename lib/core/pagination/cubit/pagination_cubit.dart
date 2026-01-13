import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/error/failures.dart';
import '../entity/pagination_response.dart';
import '../usecase/additional_pagination_params.dart';
import '../usecase/pagination_usecase.dart';

part 'pagination_states.dart';

abstract class PaginationCubit<T, UseCase extends PaginationUseCase<T>>
    extends Cubit<PaginationState> {
  final UseCase useCase;
  abstract ScrollController scrollController;

  PaginationCubit(this.useCase) : super(const PaginationInitialState());

  abstract bool isSearch;
  abstract String? term;
  abstract List<T> data;
  abstract List<T> dataSearch;
  abstract PaginationMeta meta;
  abstract PaginationMeta metaSearch;
  abstract AdditionalPaginationParams? additionalParams;
  abstract Timer? debounceTimer;

  Future<void> fPagination({
    int? page = 1,
    int? perPage = 10,
    AdditionalPaginationParams? additionalParams,
    void Function(PaginationResponse<T> response)? onSuccess,
  }) async {
    this.additionalParams = additionalParams;
    isSearch = false;
    term = null;
    meta = meta.copyWith(currentPage: page);
    if (meta.currentPage > 1) {
      emit(const PaginationPaginationLoadingState());
    } else {
      emit(const PaginationLoadingState());
    }
    final Either<Failure, PaginationResponse<T>> eitherResult =
        await useCase.call(PaginationParams(
            page: page, perPage: perPage, additionalParams: additionalParams));
    eitherResult.fold((Failure fail) {
      emit(PaginationErrorState(
          message: fail.message ?? 'Please try again later'));
    }, (PaginationResponse<T> response) {
      meta = response.meta;
      if (meta.currentPage == 1) {
        data.clear();
      }
      data.addAll(response.data);
      onSuccess?.call(response);
      emit(PaginationSuccessState(value: data));
    });
  }

  // Timer? _debounceTimer;

  Future<void> fPaginationSearch({
    required int page,
    int? perPage = 10,
    required String term,
    AdditionalPaginationParams? additionalParams,
  }) async {
    if (debounceTimer?.isActive == true) {
      debounceTimer?.cancel();
    }
    debounceTimer = Timer(const Duration(milliseconds: 750), () async {
      this.additionalParams = additionalParams;
      isSearch = true;
      this.term = term;
      metaSearch = metaSearch.copyWith(currentPage: page);
      if (metaSearch.currentPage > 1) {
        emit(const PaginationPaginationLoadingState());
      } else {
        emit(const PaginationLoadingState());
      }

      final params = PaginationParams(
          term: this.term,
          page: page,
          perPage: perPage,
          additionalParams: additionalParams);
      final Either<Failure, PaginationResponse<T>> eitherResult =
          await useCase.call(params);
      eitherResult.fold((Failure fail) {
        emit(PaginationErrorState(
            message: fail.message ?? 'Please try again later'));
      }, (PaginationResponse<T> response) {
        metaSearch = response.meta;
        if (metaSearch.currentPage == 1) {
          dataSearch.clear();
        }
        dataSearch.addAll(response.data);
        emit(PaginationSuccessState(value: dataSearch));
      });
    });
  }

  void emitAllData() {
    debounceTimer?.cancel();
    isSearch = false;
    emit(const PaginationLoadingState());
    emit(PaginationSuccessState(value: data));
  }

  void emitItems(List<T> items) {
    data = items;
    emit(const PaginationLoadingState());
    emit(PaginationSuccessState(value: data));
  }

  void resetFields() {
    data = [];
    dataSearch = [];
    isSearch = false;
    term = null;
    additionalParams = null;
    debounceTimer = null;
    emit(const PaginationInitialState());
  }

  void addScrollListener() {
    scrollController.addListener(() {
      if (isSearch) {
        if (state is! PaginationPaginationLoadingState &&
            metaSearch.currentPage < metaSearch.lastPage &&
            scrollController.hasClients &&
            scrollController.position.pixels >=
                scrollController.position.maxScrollExtent * 0.9) {
          metaSearch =
              metaSearch.copyWith(currentPage: metaSearch.currentPage + 1);
          fPaginationSearch(
              page: metaSearch.currentPage,
              term: term!,
              additionalParams: additionalParams);
        }
      } else {
        if (state is! PaginationPaginationLoadingState &&
            meta.currentPage < meta.lastPage &&
            scrollController.hasClients &&
            scrollController.position.pixels >=
                scrollController.position.maxScrollExtent * 0.9) {
          meta = meta.copyWith(currentPage: meta.currentPage + 1);
          fPagination(
              page: meta.currentPage, additionalParams: additionalParams);
        }
      }
    });
  }
}
