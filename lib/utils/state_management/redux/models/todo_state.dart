import 'package:flutter/foundation.dart';

import '../../../../models/todo.dart';
import '../../../services/todo_service.dart';

class Todos {
  List<Todo> todos;
  bool isFetching;

  Todos({required this.todos, required this.isFetching});

  Todos.initialState()
      : todos = [],
        isFetching = false;

  Todos copyWith({List<Todo>? todos, bool? isFetching}) => Todos(
      todos: todos ?? this.todos, isFetching: isFetching ?? this.isFetching);

  static Future<List<Todo>> fetchTodos(AbstractTodoService todoService) async {
    var todos = (await todoService.getTodos());
    return compute(parseTodos, todos);
  }

  static deleteTodo() {}

  static addTodo() {}

  static markCompleted() {}

  static List<Todo> parseTodos(List<dynamic> todos) {
    return todos.map((todo) => Todo.fromJson(todo)).toList();
  }

  @override
  String toString() {
    return 'todos: ${todos.toString()} isFetching: $isFetching';
  }
}
