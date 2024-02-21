import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../todo list cubit/todo_cubit.dart';

part 'to_do_count_state.dart';

class TodoCountCubit extends Cubit<TodoCountState> {
  final TodoListCubit todoListCubit;
  late final StreamSubscription todoListSubscription;

  /// to get the initial count of toDo list
  final int todoInitialCount;
  TodoCountCubit({required this.todoListCubit, required this.todoInitialCount})
      : super(TodoCountState(todoCount: todoInitialCount)) {
    todoListSubscription =
        todoListCubit.stream.listen((TodoListState todoListState) {
      final currentActiveTodoCount = todoListState.todoList
          .where((element) => !element.isCompleted)
          .toList()
          .length;
      emit(state.copyWith(currentActiveTodoCount));
    });
  }
  @override
  Future<void> close() {
    todoListSubscription.cancel();
    return super.close();
  }
}
