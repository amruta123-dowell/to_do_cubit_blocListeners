import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'to_do_search_state.dart';

class ToDoSearchCubit extends Cubit<ToDoSearchState> {
  ToDoSearchCubit() : super(ToDoSearchState.initialState());

  void searchNewItem(String? searchItem) {
    emit(state.copyWith(searchingString: searchItem??''));
  }
}
