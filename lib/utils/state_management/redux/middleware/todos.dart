import 'package:redux/redux.dart';

import '../../../services/todo_service.dart';
import '../actions/actions.dart';
import '../models/app_state.dart';
import '../models/todo_state.dart';

void fetchTodosMiddleware(
    Store<AppState> store, dynamic action, NextDispatcher next) {
  if (action is FetchTodos) {
    Todos.fetchTodos(httpTodoService)
        .then((todos) => store.dispatch(ReceiveTodos(todos: todos)))
        .catchError((error) {
      print(error);
      store.dispatch(FetchTodosFailed());
    });
  }

  next(action);
}
