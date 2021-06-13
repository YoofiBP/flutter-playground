import 'package:redux/redux.dart';

import '../actions/actions.dart';
import '../models/todo_state.dart';

Reducer<TodoState> todosReducer = combineReducers([
  TypedReducer(fetchTodosReducer),
  TypedReducer(receiveTodosReducer),
  TypedReducer(failedTodosReducer),
  TypedReducer(renoveTodoReducer),
  TypedReducer(updateTodoReducer),
  TypedReducer(addTodoReducer)
]);

TodoState fetchTodosReducer(TodoState state, FetchTodos action) {
  return state.copyWith(isFetching: true);
}

TodoState receiveTodosReducer(TodoState state, ReceiveTodos action) {
  return state.copyWith(todos: action.todos, isFetching: false);
}

TodoState failedTodosReducer(TodoState state, FetchTodosFailed action) {
  return state.copyWith(isFetching: false);
}

TodoState renoveTodoReducer(TodoState state, DeleteTodo action) {
  return state.copyWith(
      todos: List.from(state.todos.where((todo) => todo.id != action.id)));
}

TodoState updateTodoReducer(TodoState state, UpdateTodo action) {
  return state.copyWith(
      todos: List.from(state.todos
          .map((todo) => todo.id == action.id ? action.updatedTodo : todo)));
}

TodoState addTodoReducer(TodoState state, AddTodo action) {
  return state.copyWith(todos: List.from(state.todos)..add(action.newTodo));
}
