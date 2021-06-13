import 'dart:ui';

import 'package:flutter/material.dart';
import '../../containers/add_todo_modal_container.dart';
import '../../models/todo.dart';
import '../components/todo_item.dart';

class TodoListScreen extends StatefulWidget {
  final void Function() onSettingsPress;
  final void Function() onInit;
  final void Function(int id) deleteTodo;
  final void Function(Todo todo) toggleComplete;
  final List<Todo> todos;

  TodoListScreen(
      {required this.onSettingsPress,
      required this.onInit,
      required this.deleteTodo,
      required this.toggleComplete,
      this.todos = const []});

  @override
  _TodoScreenState createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoListScreen> {
  dynamic myList = [];

  @override
  void initState() {
    super.initState();
    widget.onInit();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              context: context,
              shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(25))),
              backgroundColor: Colors.white,
              builder: (context) => FractionallySizedBox(
                    heightFactor: 0.8,
                    child: AddTodoModalContainer(),
                  ));
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Text('Todos'),
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
              icon: Icon(Icons.settings), onPressed: widget.onSettingsPress)
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: widget.todos
                    .map((todo) => TodoItem(
                        todo: todo,
                        deleteTodo: widget.deleteTodo,
                        updateTodo: (value) {
                          widget.toggleComplete(todo);
                        }))
                    .toList(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
