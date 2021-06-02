import 'package:flutter/material.dart';

class TodoItem extends StatelessWidget {
  const TodoItem(
      {Key? key,
      required this.id,
      required this.title,
      required this.completed,
      required this.toggleComplete,
      required this.deleteTodo})
      : super(key: key);

  final int id;
  final String title;
  final bool completed;
  final void Function(bool?) toggleComplete;
  final void Function(int id) deleteTodo;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Checkbox(
        value: completed,
        onChanged: toggleComplete,
      ),
      trailing: IconButton(
          icon: Icon(Icons.delete_forever_sharp),
          onPressed: () {
            deleteTodo(id);
          }),
      title: Text(
        title,
        style: TextStyle(fontSize: 20),
      ),
    );
  }
}
