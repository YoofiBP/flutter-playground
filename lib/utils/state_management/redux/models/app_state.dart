import 'auth_state.dart';
import 'todo_state.dart';

class AppState {
  AuthState authState;
  Todos todos;

  //constructor
  AppState({required this.authState, required this.todos});

  //named constructor
  AppState.initialState()
      : authState = AuthState.defaultState(),
        todos = Todos.initialState();

  AppState copyWith({AuthState? authState, Todos? todos}) {
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
