import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/cubits/toDo%20filter%20list/to_do_filter_list_cubit.dart';
import 'package:to_do_app/models/to_do_model.dart';

import '../cubits/todo list cubit/todo_cubit.dart';

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
            onDismissed: (_) {
              context.read<TodoListCubit>().deleteTodoItem(filteredTodo[index]);
            },
            confirmDismiss: (direction) {
              return showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                        title: const Text("Are you sure?"),
                        content: const Text("Do you want to delete?"),
                        actions: [
                          TextButton(
                              onPressed: () => Navigator.of(context).pop(),
                              child: const Text("CANCEL")),
                          TextButton(
                              onPressed: () {
                                context
                                    .read<TodoListCubit>()
                                    .deleteTodoItem(filteredTodo[index]);
                                Navigator.of(context).pop();
                              },
                              child: const Text("OK"))
                        ],
                      ));
            },
            background: showBackGnd(0),
            secondaryBackground: showBackGnd(1),
            key: ValueKey(filteredTodo[index].id),
            child: NewItemCheckBoxWidget(item: filteredTodo[index]));
      },
      separatorBuilder: (BuildContext context, int index) {
        return const Divider();
      },
    );
  }
}

//To show item background color
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

//Custom widget to show the item with checkbox and edit the description

class NewItemCheckBoxWidget extends StatefulWidget {
  const NewItemCheckBoxWidget({super.key, required this.item});
  final ToDoModel item;

  @override
  State<NewItemCheckBoxWidget> createState() => _NewItemCheckBoxWidgetState();
}

class _NewItemCheckBoxWidgetState extends State<NewItemCheckBoxWidget> {
  TextEditingController editTextController = TextEditingController();
  bool _error = false;
  @override
  void initState() {
    editTextController.text = widget.item.description;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        showDialog(
            context: context,
            builder: (context) {
              editTextController.text = widget.item.description;
              return StatefulBuilder(builder: (context, setState) {
                return AlertDialog(
                  title: const Text("Edit Todo"),
                  content: TextField(
                    controller: editTextController,
                    decoration: InputDecoration(
                        errorStyle: const TextStyle(color: Colors.red),
                        errorText:
                            _error ? "Text should not be empty. " : null),
                  ),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text("Cancel")),
                    TextButton(
                        onPressed: () {
                          setState(() {
                            _error =
                                editTextController.text.isEmpty ? true : false;
                          });
                          if (!_error) {
                            Navigator.of(context).pop();
                          }
                        },
                        child: const Text("OK")),
                  ],
                );
              });
            });
      },
      trailing: Checkbox(
          value: widget.item.isCompleted,
          onChanged: (_) {
            context.read<TodoListCubit>().changeTodoStatus(widget.item.id);
          }),
      title: Text(widget.item.description),
    );
  }
}
