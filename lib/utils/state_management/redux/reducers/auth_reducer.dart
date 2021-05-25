import 'package:redux/redux.dart';

import '../actions/actions.dart';
import '../models/auth_state.dart';

Reducer<AuthState> authStateReducer = combineReducers(
    [TypedReducer(setIsBusyReducer), TypedReducer(setIsLoggedInReducer)]);

AuthState setIsBusyReducer(AuthState state, SetIsBusy action) {
  return AuthState(isBusy: action.isBusy, isLoggedIn: state.isLoggedIn);
}

AuthState setIsLoggedInReducer(AuthState state, SetLoggedIn action) {
  return AuthState(isLoggedIn: action.isLoggedIn, isBusy: state.isBusy);
}
