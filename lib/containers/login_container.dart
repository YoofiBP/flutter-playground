import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import '../utils/auth/auth.dart';
import '../utils/state_management/redux/actions/actions.dart';
import '../utils/state_management/redux/models/app_state.dart';
import '../utils/state_management/redux/models/user_info.dart';
import '../utils/state_management/redux/selectors/selectors.dart';
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
        isBusy: isBusySelector(store.state),
        isLoggedIn: isLoggedInSelector(store.state),
        userInfo: userInfoSelector(store.state),
        loginAction: () async {
          try {
            store.dispatch(SetIsBusy(isBusy: true));
            var result = await AppAuth().loginAction();
            store.dispatch(SetUserInfo(
                username: result['username'] as String,
                picture: result['picture']));
            store.dispatch(SetLoggedIn(isLoggedIn: true));
            store.dispatch(NavigationAction(route: '/todo'));
            store.dispatch(SetIsBusy(isBusy: false));
          } on Exception catch (e, s) {
            store.dispatch(SetIsBusy(isBusy: false));
            print('login error: $e - stack: $s');
          }
        });
  }
}
