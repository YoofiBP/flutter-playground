import 'auth_state.dart';

class AppState {
  AuthState authState;

  //constructor
  AppState({required this.authState});

  AppState.initialState() : authState = AuthState();

  @override
  String toString() {
    return 'AppState{authState: ${authState.toString()}';
  }
}
