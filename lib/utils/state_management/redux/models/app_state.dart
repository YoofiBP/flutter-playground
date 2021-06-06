import 'auth_state.dart';
import 'todo_state.dart';

class AppState {
  AuthState authState;
  TodoState todos;

  //constructor
  AppState({required this.authState, required this.todos});

  //named constructor
  AppState.initialState()
      : authState = AuthState.defaultState(),
        todos = TodoState.initialState();

  AppState copyWith({AuthState? authState, TodoState? todos}) {
    return AppState(
        authState: authState ?? this.authState, todos: todos ?? this.todos);
  }

  @override
  String toString() {
    return '''AppState{
      authState: ${authState.toString()} 
      todos: ${todos.toString()}''';
  }
}
