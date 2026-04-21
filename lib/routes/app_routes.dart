abstract class Routes {
  Routes._();
  static const MAIN = _Paths.MAIN;
  static const HOME = _Paths.HOME;
  static const MARKET = _Paths.MARKET;
  static const ORDERS = _Paths.ORDERS;
  static const CHAT = _Paths.CHAT;
}

abstract class _Paths {
  _Paths._();
  static const MAIN = '/';
  static const HOME = '/home';
  static const MARKET = '/market';
  static const ORDERS = '/orders';
  static const CHAT = '/chat';
}
