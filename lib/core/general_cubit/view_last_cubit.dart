import 'package:flutter_bloc/flutter_bloc.dart';

class ViewLastCubit extends Cubit<bool> {
  ViewLastCubit() : super(false);

  void chengeViewLast() {
    emit(true);
  }
}
