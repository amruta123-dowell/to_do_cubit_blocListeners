import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../models/to_do_model.dart';

part 'to_do_filter_state.dart';

class ToDoFilterCubit extends Cubit<ToDoFilterState> {
  ToDoFilterCubit() : super(ToDoFilterState.initialState());

  void changeFilter(Filter newFilter) {
    emit(state.copyWith(filter: newFilter));
  }
}
