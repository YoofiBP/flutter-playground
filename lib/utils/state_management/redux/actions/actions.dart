import 'dart:isolate';

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
