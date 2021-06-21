import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../utils/routing.dart';
import '../../utils/state_management/provider/todo_list.dart';
import '../components/add_todo_modal.dart';
import '../components/todo_item.dart';

class TodoListScreen extends StatelessWidget {
  void onSettingsPress(BuildContext context) {
    Navigator.pushNamed(context, Routes.settings);
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
                  child: Consumer<TodoListModel>(
                    builder: (context, todoListModel, child) =>
                        AddTodoModal(saveTodo: todoListModel.add),
                  )));
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Text('Todos'),
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
              icon: Icon(Icons.settings),
              onPressed: () => onSettingsPress(context))
        ],
      ),
      body: Provider.of<TodoListModel>(context).isFetching
          ? Center(child: CircularProgressIndicator())
          : SafeArea(
              child: Column(
                children: [
                  Expanded(
                    child: Consumer<TodoListModel>(
                      builder: (context, todoListModel, child) =>
                          ListView.builder(
                              itemCount: todoListModel.todos.length,
                              itemBuilder: (context, index) => TodoItem(
                                  key: Key(
                                      todoListModel.todos[index].id.toString()),
                                  todo: todoListModel.todos[index],
                                  deleteTodo: todoListModel.delete,
                                  updateTodo: todoListModel.update)),
                    ),
                  )
                ],
              ),
            ),
    );
  }
}
