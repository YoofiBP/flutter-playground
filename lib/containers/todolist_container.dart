import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import '../utils/state_management/redux/actions/actions.dart';
import '../utils/state_management/redux/models/app_state.dart';

class TodoListContainer extends StatelessWidget {
  final ViewModelBuilder<ViewModel> builder;

  TodoListContainer({required this.builder});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ViewModel>(
        builder: builder, converter: (store) => ViewModel.create(store));
  }
}

class ViewModel {
  final void Function() onSettingsPress;

  ViewModel({required this.onSettingsPress});

  factory ViewModel.create(Store<AppState> store) {
    return ViewModel(onSettingsPress: () {
      store.dispatch(NavigationAction(route: '/settings'));
    });
  }
}
