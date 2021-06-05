import '../../../../models/todo.dart';

class SetIsBusy {
  final bool isBusy;

  SetIsBusy({required this.isBusy});

  @override
  String toString() {
    return 'SetIsBusy: $isBusy';
  }
}

class SetLoggedIn {
  final bool isLoggedIn;

  SetLoggedIn({required this.isLoggedIn});

  @override
  String toString() {
    return 'SetLoggedIn: $isLoggedIn';
  }
}

class SetUserInfo {
  final String username;
  final dynamic picture;

  SetUserInfo({required this.username, this.picture});

  @override
  String toString() {
    return 'SetUserInfo{name: $username picture: $picture}';
  }
}

class NavigationAction {
  final String route;

  NavigationAction({required this.route});

  @override
  String toString() {
    return 'NavigateAction{route: $route}';
  }
}

class FetchTodos {}

class ReceiveTodos {
  final List<Todo> todos;

  ReceiveTodos({required this.todos});

  @override
  String toString() {
    return 'Receive todos ${todos.toString()}';
  }
}

class FetchTodosFailed {}

class DeleteTodo {
  final int id;

  DeleteTodo({required this.id});
}

class UpdateTodo {
  final int id;
  final Todo updatedTodo;

  UpdateTodo({required this.id, required this.updatedTodo});
}

class AddTodo {
  final Todo newTodo;

  AddTodo({required this.newTodo});
}
