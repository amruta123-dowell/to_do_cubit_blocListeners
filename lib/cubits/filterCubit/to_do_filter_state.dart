part of 'to_do_filter_cubit.dart';

class ToDoFilterState extends Equatable {
  final Filter filterState;
  const ToDoFilterState({required this.filterState});

  @override
  List<Object> get props => [filterState];

  factory ToDoFilterState.initialState() {
    return const ToDoFilterState(filterState: Filter.all);
  }

  ToDoFilterState copyWith({Filter? filter}) {
    return ToDoFilterState(filterState: filter ?? filterState);
  }
}
