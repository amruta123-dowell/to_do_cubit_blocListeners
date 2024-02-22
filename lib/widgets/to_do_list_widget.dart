import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/cubits/toDo%20filter%20list/to_do_filter_list_cubit.dart';
import 'package:to_do_app/cubits/todo%20list%20cubit/todo_cubit.dart';

class ToDoListWidget extends StatelessWidget {
  const ToDoListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var filteredTodo =
        context.watch<ToDoFilterListCubit>().state.todoFilteredList;
    return ListView.separated(
      itemCount: filteredTodo.length,
      shrinkWrap: true,
      primary: false,
      itemBuilder: (context, index) {
        return Dismissible(
          background: showBackGnd(0),
          secondaryBackground: showBackGnd(1),
          key: ValueKey(filteredTodo[index].id),
          child: Text(
            filteredTodo[index].description,
            style: const TextStyle(fontSize: 20),
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return const Divider();
      },
    );
  }
}

Widget showBackGnd(int direction) {
  return Container(
    color: Colors.red,
    alignment: direction == 0 ? Alignment.centerLeft : Alignment.centerRight,
    child: const Icon(
      Icons.delete,
      color: Colors.black,
      size: 30,
    ),
  );
}
