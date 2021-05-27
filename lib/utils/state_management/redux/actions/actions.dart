class SetIsBusy {
  final bool isBusy;

  SetIsBusy({required this.isBusy});

  @override
  String toString() {
    return 'SetIsBusy: $isBusy';
  }
}

class SetLoggedIn {
  final bool isLoggedIn;

  SetLoggedIn({required this.isLoggedIn});

  @override
  String toString() {
    return 'SetLoggedIn: $isLoggedIn';
  }
}

class SetUserInfo {
  final String username;
  final dynamic picture;

  SetUserInfo({required this.username, this.picture});

  @override
  String toString() {
    return 'SetUserInfo{name: $username picture: $picture}';
  }
}

class NavigationAction {
  final String route;

  NavigationAction({required this.route});

  @override
  String toString() {
    return 'NavigateAction{route: $route}';
  }
}
