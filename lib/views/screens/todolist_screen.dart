import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../containers/add_todo_modal_container.dart';
import '../../models/todo.dart';
import '../../utils/state_management/provider/todo_list.dart';
import '../components/todo_item.dart';

class TodoListScreen extends StatefulWidget {
  final void Function() onSettingsPress;
  final void Function(Todo todo) deleteTodo;
  final void Function(Todo todo) updateTodo;
  final List<Todo> todos;

  TodoListScreen(
      {required this.onSettingsPress,
      required this.deleteTodo,
      required this.updateTodo,
      this.todos = const []});

  @override
  _TodoScreenState createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoListScreen> {
  dynamic myList = [];

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
      body: Provider.of<TodoListModel>(context).isFetching
          ? Center(child: CircularProgressIndicator())
          : SafeArea(
              child: Column(
                children: [
                  Expanded(
                    child: ListView(
                      children: widget.todos
                          .map((todo) => TodoItem(
                              todo: todo,
                              deleteTodo: widget.deleteTodo,
                              updateTodo: (value) {
                                widget.updateTodo(todo);
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
