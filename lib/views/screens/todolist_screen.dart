import 'package:flutter/material.dart';
import '../../models/todo.dart';
import '../components/todo_item.dart';

class TodoListScreen extends StatefulWidget {
  final void Function() onSettingsPress;
  final void Function() onInit;
  final void Function(int id) deleteTodo;
  final List<Todo> todos;

  TodoListScreen(
      {required this.onSettingsPress,
      required this.onInit,
      required this.deleteTodo,
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
          print('addTodo');
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
                        id: todo.id,
                        title: todo.title,
                        completed: todo.completed,
                        deleteTodo: widget.deleteTodo,
                        toggleComplete: (_) {}))
                    .toList(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
