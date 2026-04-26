abstract class Routes {
  Routes._();
  static const MAIN = _Paths.MAIN;
  static const HOME = _Paths.HOME;
  static const MARKET = _Paths.MARKET;
  static const ORDERS = _Paths.ORDERS;
  static const SUPPORT = _Paths.SUPPORT;
  static const PROFILE = _Paths.PROFILE;
  static const NOTIFICATIONS = _Paths.NOTIFICATIONS;
}

abstract class _Paths {
  _Paths._();
  static const MAIN = '/';
  static const HOME = '/home';
  static const MARKET = '/market';
  static const ORDERS = '/orders';
  static const SUPPORT = '/support';
  static const PROFILE = '/profile';
  static const NOTIFICATIONS = '/notifications';
}
