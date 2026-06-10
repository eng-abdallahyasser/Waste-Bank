import 'package:get/get.dart';
import 'package:waste_bank/services/local_storage_service.dart';
import 'controller.dart';

class ProfileBinding extends Bindings {
  @override
  void dependencies() {
    if (!Get.isRegistered<LocalStorageService>()) {
      Get.put<LocalStorageService>(LocalStorageService(), permanent: true);
    }
    Get.lazyPut<ProfileController>(() => ProfileController(Get.find<LocalStorageService>()));
  }
}
