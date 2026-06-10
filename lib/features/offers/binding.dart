import 'package:get/get.dart';
import 'package:waste_bank/services/api_client.dart';
import 'package:waste_bank/services/local_storage_service.dart';
import 'package:waste_bank/services/offer_service.dart';
import 'controller.dart';

class OfferBinding extends Bindings {
  @override
  void dependencies() {
    if (!Get.isRegistered<LocalStorageService>()) {
      Get.put<LocalStorageService>(LocalStorageService(), permanent: true);
    }
    if (!Get.isRegistered<ApiClient>()) {
      Get.put<ApiClient>(ApiClient(Get.find<LocalStorageService>()), permanent: true);
    }
    Get.lazyPut<OfferService>(() => OfferService(Get.find<ApiClient>()));
    Get.lazyPut<OfferController>(() => OfferController(Get.find<OfferService>()));
  }
}
