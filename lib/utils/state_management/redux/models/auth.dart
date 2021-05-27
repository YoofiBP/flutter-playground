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
}
