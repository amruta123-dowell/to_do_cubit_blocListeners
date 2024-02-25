import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../models/to_do_model.dart';

part 'todo_state.dart';

class TodoListCubit extends Cubit<TodoListState> {
  TodoListCubit() : super(TodoListState.initialState());

  void addItemTodoList(String todoDesc) {
    final value = ToDoModel(description: todoDesc);
    final newList = [...state.todoList, value];
    emit(state.copyWith(newList));
  }

  void editTodo(String id, String desc) {
    final newList = state.todoList.map((element) {
      if (element.id == id) {
        return ToDoModel(description: desc, id: id);
      }
      return element;
    }).toList();

    emit(state.copyWith(newList));
  }

  void changeTodoStatus(String id) {
    final newList = state.todoList.map((element) {
      if (element.id == id) {
        return ToDoModel(
            description: element.description,
            id: element.id,
            isCompleted: !element.isCompleted);
      }
      return element;
    }).toList();

    emit(state.copyWith(newList));
  }

  deleteTodoItem(ToDoModel todoModel) {
    final newList =
        state.todoList.where((element) => element.id != todoModel.id).toList();

    emit(state.copyWith(newList));
  }
}
