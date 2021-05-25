class AuthState {
  final bool isBusy;
  final bool isLoggedIn;
  final String name;
  final dynamic picture;

  //constructor
  AuthState(
      {this.isBusy = false,
      this.isLoggedIn = false,
      this.name = '',
      this.picture = ''});

  AuthState copyWith(
      {bool? isBusy, bool? isLoggedIn, String? name, dynamic picture}) {
    return AuthState(
        isBusy: isBusy ?? this.isBusy,
        isLoggedIn: isLoggedIn ?? this.isLoggedIn,
        name: name ?? this.name,
        picture: picture ?? this.picture);
  }

  @override
  String toString() {
    return 'AuthState{isBusy: $isBusy isLoggedIn: $isLoggedIn}';
  }
}
