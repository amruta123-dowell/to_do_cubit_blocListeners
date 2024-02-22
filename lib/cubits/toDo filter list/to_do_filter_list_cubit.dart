import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:to_do_app/cubits/filterCubit/to_do_filter_cubit.dart';
import 'package:to_do_app/cubits/search_cubit/to_do_search_cubit.dart';
import 'package:to_do_app/cubits/todo%20list%20cubit/todo_cubit.dart';

import '../../models/to_do_model.dart';

part 'to_do_filter_list_state.dart';

class ToDoFilterListCubit extends Cubit<ToDoFilterListState> {
  late StreamSubscription searchListSubscription;
  late StreamSubscription filteredTodoSubscription;
  late StreamSubscription filterSubscription;

  final TodoListCubit todoListCubit;
  final ToDoFilterCubit filterCubit;
  final ToDoSearchCubit toDoSearchCubit;
  final List<ToDoModel> initialToDoList;
  ToDoFilterListCubit(
      {required this.todoListCubit,
      required this.filterCubit,
      required this.toDoSearchCubit,
      required this.initialToDoList})
      : super(ToDoFilterListState(todoFilteredList: initialToDoList)) {
    filterSubscription = todoListCubit.stream.listen((event) {});
    filteredTodoSubscription = filterCubit.stream.listen((event) {});
    searchListSubscription = toDoSearchCubit.stream.listen((event) {});
  }

  void setTodoList() {
    List<ToDoModel> _filteredToDo;
    switch (filterCubit.state.filterState) {
      case Filter.active:
        _filteredToDo = todoListCubit.state.todoList
            .where((element) => !element.isCompleted)
            .toList();
        break;
      case Filter.completed:
        _filteredToDo = todoListCubit.state.todoList
            .where((element) => element.isCompleted)
            .toList();
        break;

      case Filter.all:
      default:
        _filteredToDo = todoListCubit.state.todoList;
        break;
    }

    if (toDoSearchCubit.state.searchItem.isNotEmpty) {
      _filteredToDo = todoListCubit.state.todoList.where((element) {
        return element.description
            .toLowerCase()
            .contains(toDoSearchCubit.state.searchItem);
      }).toList();
    }

    emit(state.copyWith(_filteredToDo));
  }

  @override
  Future<void> close() {
    searchListSubscription.cancel();
    filteredTodoSubscription.cancel();
    filterSubscription.cancel();
    return super.close();
  }
}
