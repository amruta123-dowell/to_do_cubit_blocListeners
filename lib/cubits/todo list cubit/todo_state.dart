part of 'todo_cubit.dart';

class TodoListState extends Equatable {
  final List<ToDoModel> todoList;
  const TodoListState({required this.todoList});

  @override
  List<Object> get props => [todoList];

  factory TodoListState.initialState() {
    return TodoListState(todoList: [
      ToDoModel(id: "1", description: "Washing clothes"),
      ToDoModel(id: "2", description: "Studying"),
      ToDoModel(id: "3", description: "Cleaning room"),
    ]);
  }
  TodoListState copyWith(List<ToDoModel> listTodo) {
    return TodoListState(todoList:listTodo);
  }
}
