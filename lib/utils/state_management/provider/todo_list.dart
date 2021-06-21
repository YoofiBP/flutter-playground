import 'dart:collection';

import 'package:flutter/material.dart';

import '../../../models/todo.dart';
import '../../services/todo_service.dart';

class TodoListModel extends ChangeNotifier {
  final List<Todo> _todos = [];
  bool _isFetching = false;
  final AbstractTodoService todoService;

  TodoListModel({required this.todoService});

  UnmodifiableListView<Todo> get todos => UnmodifiableListView(_todos);
  bool get isFetching => _isFetching;

  //sync todos with database
  void _saveTodos() {
    todoService.saveTodos(List.from(_todos.map((todo) => todo.toJson())));
  }

  void add(Todo todo) async {
    _todos.add(todo);
    notifyListeners();
    _saveTodos();
  }

  void delete(Todo todo) async {
    _todos.removeWhere((currentTodo) => currentTodo.id == todo.id);
    notifyListeners();
    _saveTodos();
  }

  void update(Todo todo) async {
    var updatedTodo = await todoService.updateTodo(todo.id, todo.toJson());
    var oldTodo = _todos.firstWhere((oldTodo) => oldTodo.id == todo.id);
    var replaceIndex = _todos.indexOf(oldTodo);
    _todos.replaceRange(replaceIndex, replaceIndex + 1, updatedTodo);
    notifyListeners();
    _saveTodos();
  }

  void fetchTodos() async {
    _isFetching = true;
    notifyListeners();

    try {
      var todos = await todoService.getTodos();
      _todos.addAll(parseTodos(todos));
      _isFetching = false;
      print('Todos fetched');
      notifyListeners();
    } on Exception catch (_) {
      _isFetching = false;
      notifyListeners();
      //report to service
    }
  }

  List<Todo> parseTodos(List<dynamic> todos) {
    return List.from(todos.map((e) => Todo.fromJson(e)));
  }
}
