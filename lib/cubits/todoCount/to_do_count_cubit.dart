import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../todo list cubit/todo_cubit.dart';

part 'to_do_count_state.dart';

class TodoCountCubit extends Cubit<TodoCountState> {
  /// to get the initial count of toDo list
  final int todoInitialCount;
  TodoCountCubit({required this.todoInitialCount})
      : super(TodoCountState(todoCount: todoInitialCount));

  void calculateActiveCount(int activeTodoCount) {
    emit(state.copyWith(activeTodoCount));
  }
}
