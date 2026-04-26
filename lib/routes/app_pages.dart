import 'package:get/get.dart';
import 'package:waste_bank/features/notifications/binding.dart';
import 'package:waste_bank/features/notifications/page.dart';
import 'package:waste_bank/features/profile/binding.dart';
import 'package:waste_bank/features/profile/page.dart';
import 'package:waste_bank/features/support/binding.dart';
import 'package:waste_bank/features/support/page.dart';
import 'package:waste_bank/features/home/binding.dart';
import 'package:waste_bank/features/home/page.dart';
import 'package:waste_bank/features/market/page.dart';
import 'package:waste_bank/features/orders/page.dart';
import '../features/main_screen.dart';
import 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.MAIN;

  static final routes = [
    GetPage(
      name: Routes.MAIN,
      page: () => const MainScreen(),
    ),
    GetPage(
      name: Routes.HOME,
      page: () => const HomePage(),
      binding: HomeBinding(),
    ),
    GetPage(name: Routes.MARKET, page: () => const MarketPage()),
    GetPage(name: Routes.ORDERS, page: () => const OrdersPage()),
    GetPage(
      name: Routes.SUPPORT,
      page: () => const SupportPage(),
      binding: SupportBinding(),
    ),
    GetPage(
      name: Routes.PROFILE,
      page: () => const ProfilePage(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: Routes.NOTIFICATIONS,
      page: () => const NotificationsPage(),
      binding: NotificationsBinding(),
    ),
  ];
}
