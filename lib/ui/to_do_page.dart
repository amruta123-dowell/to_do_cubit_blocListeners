import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/cubits/filterCubit/to_do_filter_cubit.dart';
import 'package:to_do_app/cubits/search_cubit/to_do_search_cubit.dart';
import 'package:to_do_app/cubits/todo%20list%20cubit/todo_cubit.dart';
import 'package:to_do_app/cubits/todoCount/to_do_count_cubit.dart';

import '../bounce.dart';
import '../models/to_do_model.dart';
import '../widgets/to_do_list_widget.dart';

class ToDoPage extends StatelessWidget {
  const ToDoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const HeaderWidget(),
              const CreateTodoWidget(),
              const SizedBox(
                height: 30,
              ),
              SearchAndFilterButtonWidget(),
              const SizedBox(
                height: 30,
              ),
              const ToDoListWidget()
            ],
          ),
        ),
      ),
    ));
  }
}

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          "To Do",
          style: TextStyle(fontSize: 40),
        ),
        BlocBuilder<TodoCountCubit, TodoCountState>(builder: (context, state) {
          return Text(
            "Total no.of Todos ${state.todoCount} ",
            style: const TextStyle(fontSize: 20, color: Colors.red),
          );
        }),
        // Text(
        //   "Total no.of Todos ${context.watch<TodoCountCubit>().state.todoCount} ",
        //   style: const TextStyle(fontSize: 20, color: Colors.red),
        // )
      ],
    );
  }
}

class CreateTodoWidget extends StatefulWidget {
  const CreateTodoWidget({super.key});

  @override
  State<CreateTodoWidget> createState() => _CreateTodoWidgetState();
}

class _CreateTodoWidgetState extends State<CreateTodoWidget> {
  TextEditingController todoTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: todoTextController,
      decoration: const InputDecoration(
        label: Text("description of To do", style: TextStyle(fontSize: 17)),
      ),
      onFieldSubmitted: (value) {
        if (value.isNotEmpty) {
          context.read<TodoListCubit>().addItemTodoList(value);
          todoTextController.clear();
        }
      },
    );
  }
}

class SearchAndFilterButtonWidget extends StatefulWidget {
  SearchAndFilterButtonWidget({super.key});
  final debounce = Bounce(milliSeconds: 200);
  @override
  State<SearchAndFilterButtonWidget> createState() =>
      _SearchAndFilterButtonWidgetState();
}

class _SearchAndFilterButtonWidgetState
    extends State<SearchAndFilterButtonWidget> {
  TextEditingController searchController = TextEditingController();
  @override
  void dispose() {
    searchController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          controller: searchController,
          decoration: const InputDecoration(
              suffixIcon: Icon(Icons.search), filled: true),
          onChanged: (String? value) {
            context.read<ToDoSearchCubit>().searchNewItem(value);
          },
        ),
        const SizedBox(
          height: 30,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            filterButton(context, Filter.all),
            filterButton(context, Filter.active),
            filterButton(context, Filter.completed)
          ],
        )
      ],
    );
  }
}

Widget filterButton(BuildContext context, Filter filterState) {
  return TextButton(
      onPressed: () {
        context.read<ToDoFilterCubit>().changeFilter(filterState);
      },
      child: Text(
        filterState == Filter.all
            ? "ALL"
            : filterState == Filter.active
                ? "ACTIVE"
                : "COMPLETED",
        style: TextStyle(fontSize: 15, color: getColor(context, filterState)),
      ));
}

MaterialColor getColor(BuildContext context, Filter filter) {
  var filterState = context.watch<ToDoFilterCubit>().state.filterState;
  if (filterState == filter) {
    return Colors.purple;
  }
  return Colors.grey;
}
