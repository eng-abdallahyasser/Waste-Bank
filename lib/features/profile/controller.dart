import 'package:get/get.dart';
import 'package:waste_bank/routes/app_routes.dart';
import 'package:waste_bank/services/local_storage_service.dart';

class ProfileController extends GetxController {
  final LocalStorageService _storage;

  ProfileController(this._storage);

  final userName = 'مكرم علي'.obs;
  final userLocation = 'الدقهلية، المنصورة'.obs;

  final impactStats = [
    {'label': 'النفايات المجموعة', 'value': '1250', 'unit': 'كجم'},
    {'label': 'إجمالي الأرباح', 'value': '450.5', 'unit': 'ج.م'},
    {'label': 'الأشجار المنقذة', 'value': '12', 'unit': ''},
  ].obs;

  final menuItems = [
    {'title': 'تعديل الملف الشخصي', 'icon': 'person_outline'},
    {'title': 'إعدادات الحساب', 'icon': 'settings_outlined'},
    {'title': 'طرق الدفع', 'icon': 'payment_outlined'},
    {'title': 'الخصوصية والأمان', 'icon': 'security_outlined'},
    {'title': 'المساعدة والدعم', 'icon': 'help_outline'},
  ].obs;

  Future<void> logout() async {
    // Clear stored token and user data from GetStorage
    _storage.clearAuth();

    // Navigate to login and clear all previous routes
    Get.offAllNamed(Routes.LOGIN);
  }
}
