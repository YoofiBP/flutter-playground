import 'package:redux/redux.dart';

import '../../../services/todo_service.dart';
import '../actions/actions.dart';
import '../models/app_state.dart';
import '../models/todo_state.dart';

void fetchTodosMiddleware(
    Store<AppState> store, dynamic action, NextDispatcher next) {
  if (action is FetchTodos) {
    TodoState.fetchTodos(httpTodoService)
        .then((todos) => store.dispatch(ReceiveTodos(todos: todos)))
        .catchError((error) {
      print(error);
      store.dispatch(FetchTodosFailed());
    });
  }

  next(action);
}

void saveTodosMiddleware(
    Store<AppState> store, dynamic action, NextDispatcher next) {
  if (action is RequestAddTodo) {
    TodoState.addTodo(action.title, action.userId, httpTodoService)
        .then((todo) => store.dispatch(AddTodo(newTodo: todo)))
        .catchError((error) {
      print(error);
      store.dispatch(FailedAddTodo);
    });
  }

  next(action);
}

void deleteTodosMiddleware(
    Store<AppState> store, dynamic action, NextDispatcher next) {
  if (action is RequestDeleteTodo) {
    TodoState.deleteTodo(action.id, httpTodoService).then((deleted) {
      if (deleted == true) {
        store.dispatch(DeleteTodo(id: action.id));
      } else {
        store.dispatch(FailedDeleteTodo);
      }
    }).catchError((error) {
      print(error);
      store.dispatch(FailedDeleteTodo);
    });
  }

  next(action);
}

void updateTodosMiddleware(
    Store<AppState> store, dynamic action, NextDispatcher next) {
  if (action is RequestUpdateTodo) {
    TodoState.updateTodo(action.id, action.updateBody, httpTodoService)
        .then((updatedTodo) =>
            store.dispatch(UpdateTodo(id: action.id, updatedTodo: updatedTodo)))
        .catchError((error) {
      print(error);
      store.dispatch(FailedUpdateTodo);
    });
  }
  next(action);
}
