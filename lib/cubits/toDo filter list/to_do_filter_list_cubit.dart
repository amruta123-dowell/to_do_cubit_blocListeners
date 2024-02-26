import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../models/to_do_model.dart';

part 'to_do_filter_list_state.dart';

class ToDoFilterListCubit extends Cubit<ToDoFilterListState> {
  final List<ToDoModel> initialToDoList;
  ToDoFilterListCubit({required this.initialToDoList})
      : super(ToDoFilterListState(todoFilteredList: initialToDoList));
  void setTodoList(Filter filter, List<ToDoModel> toDoList, String searchItem) {
    List<ToDoModel> filteredToDo;
    switch (filter) {
      case Filter.active:
        filteredToDo =
            toDoList.where((element) => !element.isCompleted).toList();
        break;
      case Filter.completed:
        filteredToDo =
            toDoList.where((element) => element.isCompleted).toList();
        break;

      case Filter.all:
      default:
        filteredToDo = toDoList;
        break;
    }

    if (searchItem.isNotEmpty) {
      filteredToDo = filteredToDo
          .where((ToDoModel todo) =>
              todo.description.toLowerCase().contains(searchItem))
          .toList();
    } else {
      filteredToDo = filteredToDo;
    }

    emit(state.copyWith(filteredToDo));
  }
}
