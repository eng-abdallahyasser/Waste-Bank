import 'package:get/get.dart';
import 'controller.dart';

class MarketBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MarketController>(() => MarketController());
  }
}