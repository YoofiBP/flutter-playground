import 'package:redux/redux.dart';

import '../actions/actions.dart';
import '../models/todo_state.dart';

Reducer<Todos> todosReducer = combineReducers([
  TypedReducer(fetchTodosReducer),
  TypedReducer(receiveTodosReducer),
  TypedReducer(failedTodosReducer),
  TypedReducer(renoveTodoReducer),
]);

Todos fetchTodosReducer(Todos state, FetchTodos action) {
  return state.copyWith(isFetching: true);
}

Todos receiveTodosReducer(Todos state, ReceiveTodos action) {
  return state.copyWith(todos: action.todos, isFetching: false);
}

Todos failedTodosReducer(Todos state, FetchTodosFailed action) {
  return state.copyWith(isFetching: false);
}

Todos renoveTodoReducer(Todos state, DeleteTodo action) {
  print('Removing todo ${action.id}');
  return state.copyWith(
      todos: List.from(state.todos.where((todo) => todo.id != action.id)));
}
