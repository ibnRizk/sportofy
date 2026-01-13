import 'package:equatable/equatable.dart';

abstract class AdditionalPaginationParams extends Equatable {
  const AdditionalPaginationParams();

  Map<String, dynamic> toJson();

  @override
  List<Object?> get props => <Object?>[];

}