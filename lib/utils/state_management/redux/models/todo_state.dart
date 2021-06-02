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
    List<dynamic> todos = await todoService.getTodos();
    return todos.map((todo) => Todo.fromJson(todo)).toList();
  }

  static deleteTodo() {}

  static addTodo() {}

  static markCompleted() {}

  @override
  String toString() {
    return 'todos: ${todos.toString()} isFetching: $isFetching';
  }
}
