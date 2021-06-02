import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
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
            ),
        converter: (store) => ViewModel.create(store));
  }
}

class ViewModel {
  final void Function() onSettingsPress;
  final void Function() onInit;
  final void Function(int id) deleteTodo;
  final List<Todo> todos;

  ViewModel(
      {required this.onSettingsPress,
      required this.onInit,
      required this.todos,
      required this.deleteTodo});

  factory ViewModel.create(Store<AppState> store) {
    return ViewModel(
        onSettingsPress: () {
          store.dispatch(NavigationAction(route: '/settings'));
        },
        onInit: () {
          store.dispatch(FetchTodos());
        },
        todos: store.state.todos.todos,
        deleteTodo: (id) {
          store.dispatch(DeleteTodo(id: id));
        });
  }
}
