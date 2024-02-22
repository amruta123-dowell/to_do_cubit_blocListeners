import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/cubits/filterCubit/to_do_filter_cubit.dart';
import 'package:to_do_app/cubits/search_cubit/to_do_search_cubit.dart';
import 'package:to_do_app/cubits/toDo%20filter%20list/to_do_filter_list_cubit.dart';
import 'package:to_do_app/cubits/todoCount/to_do_count_cubit.dart';
import 'package:to_do_app/ui/to_do_page.dart';

import 'cubits/todo list cubit/todo_cubit.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ToDoFilterCubit>(create: (context) => ToDoFilterCubit()),
        BlocProvider<ToDoSearchCubit>(create: (context) => ToDoSearchCubit()),
        BlocProvider<TodoListCubit>(create: (context) => TodoListCubit()),
        BlocProvider<TodoCountCubit>(
            create: (context) => TodoCountCubit(
                todoInitialCount:
                    context.read<TodoListCubit>().state.todoList.length,
                todoListCubit: BlocProvider.of<TodoListCubit>(context))),
        BlocProvider<ToDoFilterListCubit>(
            create: (context) => ToDoFilterListCubit(
                initialToDoList: context.read<TodoListCubit>().state.todoList,
                filterCubit: BlocProvider.of<ToDoFilterCubit>(context),
                todoListCubit: BlocProvider.of<TodoListCubit>(context),
                toDoSearchCubit: BlocProvider.of<ToDoSearchCubit>(context)))
      ],
      child: MaterialApp(
        title: "TODO",
        theme: ThemeData(primarySwatch: Colors.amber),
        home: const ToDoPage(),
      ),
    );
  }
}
