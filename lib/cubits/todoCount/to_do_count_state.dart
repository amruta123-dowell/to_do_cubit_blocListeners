part of 'to_do_count_cubit.dart';

class TodoCountState extends Equatable {
  final int todoCount;
  const TodoCountState({required this.todoCount});

  @override
  List<Object> get props => [todoCount];

  @override
  String toString() {
    return "To do count: $todoCount";
  }

  factory TodoCountState.initialState(int count) {
    return  TodoCountState(todoCount: count);
  }
  TodoCountState copyWith(int countVal) {
    return TodoCountState(todoCount: countVal);
  }
}
