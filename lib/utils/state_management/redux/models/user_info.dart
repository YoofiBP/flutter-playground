class UserInfo {
  final String username;
  final dynamic picture;

  UserInfo({this.username = '', this.picture = ''});

  @override
  String toString() {
    return 'UserInfo{username: $username picture: $picture}';
  }
}
