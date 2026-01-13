part of 'pagination_cubit.dart';


abstract class PaginationState extends Equatable {

  const PaginationState();

  @override
  List<Object?> get props => <Object?>[];
}

class PaginationInitialState extends PaginationState {
  const PaginationInitialState();
}

class PaginationLoadingState extends PaginationState {
  const PaginationLoadingState();
}

class PaginationPaginationLoadingState extends PaginationState {
  const PaginationPaginationLoadingState();
}

class PaginationSuccessState<T> extends PaginationState {
  final List<T> value;

  const PaginationSuccessState({required this.value});

  @override
  List<Object?> get props => <Object?>[value];
}

class PaginationErrorState extends PaginationState {
  final String message;

  const PaginationErrorState({required this.message});

  @override
  List<Object?> get props => <Object?>[message];
}

