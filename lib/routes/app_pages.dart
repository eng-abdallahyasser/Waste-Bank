import 'package:get/get.dart';
import 'package:waste_bank/features/chat/page.dart';
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
    GetPage(name: Routes.CHAT, page: () => const ChatPage()),
  ];
}
