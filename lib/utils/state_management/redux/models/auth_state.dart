import 'user_info.dart';

class AuthState {
  final bool isBusy;
  final bool isLoggedIn;
  final UserInfo userInfo;
  //constructor
  AuthState(
      {this.isBusy = false, this.isLoggedIn = false, required this.userInfo});

  factory AuthState.defaultState(
      {bool isBusy = false, bool isLoggedIn = false}) {
    var userInfo = UserInfo();
    return AuthState(userInfo: userInfo);
  }

  AuthState copyWith({bool? isBusy, bool? isLoggedIn, UserInfo? userInfo}) {
    return AuthState(
        isBusy: isBusy ?? this.isBusy,
        isLoggedIn: isLoggedIn ?? this.isLoggedIn,
        userInfo: userInfo ?? this.userInfo);
  }

  @override
  String toString() {
    return '''AuthState{isBusy: $isBusy 
    isLoggedIn: $isLoggedIn userInfo: ${userInfo.toString()}}''';
  }
}
