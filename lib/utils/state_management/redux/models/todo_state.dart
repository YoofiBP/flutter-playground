import 'package:flutter/foundation.dart';

import '../../../../models/todo.dart';
import '../../../services/todo_service.dart';

class TodoState {
  List<Todo> todos;
  bool isFetching;

  TodoState({required this.todos, required this.isFetching});

  TodoState.initialState()
      : todos = [],
        isFetching = false;

  TodoState copyWith({List<Todo>? todos, bool? isFetching}) => TodoState(
      todos: todos ?? this.todos, isFetching: isFetching ?? this.isFetching);

  static Future<List<Todo>> fetchTodos(AbstractTodoService todoService) async {
    var todos = await todoService.getTodos();
    return compute(parseTodos, todos);
  }

  static Future<bool> deleteTodo(
      int id, AbstractTodoService todoService) async {
    return await todoService.deleteTodo(id);
  }

  static Future<Todo> updateTodo(int id, Map<String, dynamic> update,
      AbstractTodoService todoService) async {
    var updatedTodo = await todoService.updateTodo(id, update);
    return Todo.fromJson(updatedTodo);
  }

  static Future<Todo> addTodo(
      String title, int userId, AbstractTodoService todoService) async {
    var todo = await todoService.postTodo(title, userId);
    return Todo.fromJson(todo);
  }

  static List<Todo> parseTodos(List<dynamic> todos) {
    return todos.map((todo) => Todo.fromJson(todo)).toList();
  }

  @override
  String toString() {
    return 'todos: ${todos.toString()} isFetching: $isFetching';
  }
}
