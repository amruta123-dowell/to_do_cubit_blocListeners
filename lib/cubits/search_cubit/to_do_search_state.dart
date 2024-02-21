part of 'to_do_search_cubit.dart';

class ToDoSearchState extends Equatable {
  final String searchItem;
  const ToDoSearchState({required this.searchItem});

  @override
  List<Object> get props => [searchItem];
  @override
  String toString() {
    return "searching item string ---> $searchItem";
  }

  ToDoSearchState copyWith({String? searchingString}) {
    return ToDoSearchState(searchItem: searchingString ?? searchItem);
  }

  factory ToDoSearchState.initialState() {
    return const ToDoSearchState(searchItem: '');
  }
}
