import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import '../utils/auth/auth.dart';
import '../utils/state_management/redux/actions/actions.dart';
import '../utils/state_management/redux/models/app_state.dart';
import '../utils/state_management/redux/models/user_info.dart';
import '../views/screens/login_screen.dart';

class LoginContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ViewModel>(
        converter: (store) => ViewModel.create(store),
        builder: (context, viewModel) => LoginScreen(
              isBusy: viewModel.isBusy,
              loginAction: viewModel.loginAction,
            ));
  }
}

class ViewModel {
  final bool isBusy;
  final bool isLoggedIn;
  final UserInfo userInfo;
  final void Function() loginAction;

  ViewModel(
      {required this.isBusy,
      required this.isLoggedIn,
      required this.userInfo,
      required this.loginAction});

  factory ViewModel.create(Store<AppState> store) {
    return ViewModel(
        isBusy: store.state.authState.isBusy,
        isLoggedIn: store.state.authState.isLoggedIn,
        userInfo: store.state.authState.userInfo,
        loginAction: () async {
          try {
            store.dispatch(SetIsBusy(isBusy: true));
            var result = await AppAuth().loginAction();
            store.dispatch(SetUserInfo(
                username: result['username'] as String,
                picture: result['picture']));
            store.dispatch(SetIsBusy(isBusy: false));
            store.dispatch(SetLoggedIn(isLoggedIn: true));
            store.dispatch(NavigationAction(route: '/todo'));
          } on Exception catch (e, s) {
            store.dispatch(SetIsBusy(isBusy: false));
            print('login error: $e - stack: $s');
          }
        });
  }
}
