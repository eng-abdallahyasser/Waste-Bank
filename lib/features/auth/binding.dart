import 'package:get/get.dart';
import 'package:waste_bank/services/api_client.dart';
import 'package:waste_bank/services/auth_service.dart';
import 'package:waste_bank/services/local_storage_service.dart';
import 'controller.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<LocalStorageService>(LocalStorageService(), permanent: true);
    Get.put<ApiClient>(ApiClient(Get.find<LocalStorageService>()), permanent: true);
    Get.lazyPut<AuthService>(() => AuthService(
      Get.find<ApiClient>(),
      Get.find<LocalStorageService>(),
    ));
    Get.lazyPut<AuthController>(() => AuthController(Get.find<AuthService>()));
  }
}
