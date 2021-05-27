import 'package:redux/redux.dart';

import '../actions/actions.dart';
import '../models/auth_state.dart';
import '../models/user_info.dart';

Reducer<AuthState> authStateReducer = combineReducers([
  TypedReducer(setIsBusyReducer),
  TypedReducer(setIsLoggedInReducer),
  TypedReducer(setUserInfoReducer)
]);

AuthState setIsBusyReducer(AuthState state, SetIsBusy action) {
  return state.copyWith(isBusy: action.isBusy);
}

AuthState setIsLoggedInReducer(AuthState state, SetLoggedIn action) {
  return state.copyWith(isLoggedIn: action.isLoggedIn);
}

AuthState setUserInfoReducer(AuthState state, SetUserInfo action) {
  return state.copyWith(
      userInfo: UserInfo(username: action.username, picture: action.picture));
}
