import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import '../utils/state_management/redux/actions/actions.dart';
import '../utils/state_management/redux/models/app_state.dart';
import '../views/components/add_todo_modal.dart';

class AddTodoModalContainer extends StatelessWidget {
  const AddTodoModalContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ViewModel>(
        builder: (context, viewModel) =>
            AddTodoModal(saveTodo: viewModel.saveTodo),
        converter: (store) => ViewModel.create(store));
  }
}

class ViewModel {
  final void Function(String todoTitle) saveTodo;

  ViewModel({required this.saveTodo});

  factory ViewModel.create(Store<AppState> store) {
    return ViewModel(saveTodo: (todoTitle) {
      store.dispatch(RequestAddTodo(title: todoTitle, userId: 1));
    });
  }
}
