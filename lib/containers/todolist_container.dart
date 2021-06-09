import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:new_todo_list/utils/state_management/redux/selectors/selectors.dart';
import 'package:redux/redux.dart';

import '../models/todo.dart';
import '../utils/state_management/redux/actions/actions.dart';
import '../utils/state_management/redux/models/app_state.dart';
import '../views/screens/todolist_screen.dart';

class TodoListContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ViewModel>(
        builder: (context, viewModel) => TodoListScreen(
              onSettingsPress: viewModel.onSettingsPress,
              onInit: viewModel.onInit,
              todos: viewModel.todos,
              deleteTodo: viewModel.deleteTodo,
              toggleComplete: viewModel.toggleComplete,
            ),
        converter: (store) => ViewModel.create(store));
  }
}

class ViewModel {
  final void Function() onSettingsPress;
  final void Function() onInit;
  final void Function(int id) deleteTodo;
  final void Function(Todo todo) toggleComplete;
  final List<Todo> todos;

  ViewModel(
      {required this.onSettingsPress,
      required this.onInit,
      required this.todos,
      required this.deleteTodo,
      required this.toggleComplete});

  factory ViewModel.create(Store<AppState> store) {
    return ViewModel(
        onSettingsPress: () {
          store.dispatch(NavigationAction(route: '/settings'));
        },
        onInit: () {
          store.dispatch(FetchTodos());
        },
        todos: todosSelector(store.state),
        toggleComplete: (todo) {
          todo.toggleComplete();
          store.dispatch(
              RequestUpdateTodo(id: todo.id, updateBody: todo.toJson()));
        },
        deleteTodo: (id) {
          store.dispatch(RequestDeleteTodo(id: id));
        });
  }
}
