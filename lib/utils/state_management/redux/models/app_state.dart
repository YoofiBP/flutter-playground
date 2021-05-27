import 'auth_state.dart';

class AppState {
  final AuthState authState;

  //constructor
  AppState({required this.authState});

  //named constructor
  AppState.initialState() : authState = AuthState.defaultState();

  @override
  String toString() {
    return 'AppState{authState: ${authState.toString()}';
  }
}
