import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:waste_bank/routes/app_routes.dart';
import 'package:waste_bank/services/offer_service.dart';

class OfferController extends GetxController {
  final OfferService _offerService;

  OfferController(this._offerService);

  // ----- Form Controllers -----
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final quantityController = TextEditingController();
  final priceController = TextEditingController();
  final locationController = TextEditingController();

  // ----- Dropdown / Picker State -----
  static const List<String> categories = [
    'مخلفات زراعية',
    'قش أرز',
    'مخلفات عضوية',
    'سماد',
    'مخلفات نخيل',
    'بلاستيك',
    'معادن',
    'ورق',
    'زجاج',
    'خشب',
    'مطاط',
    'إلكترونيات',
    'أخرى',
  ];

  static const List<String> units = [
    'كجم',
    'طن',
    'لتر',
    'دونم',
    'متر مكعب',
  ];

  final selectedCategory = ''.obs;
  final selectedUnit = 'كجم'.obs;

  final selectedDate = Rxn<String>();

  // ----- Reactive State -----
  final isLoading = false.obs;
  final errorMessage = Rxn<String>();

  // ----- Validation & Submission -----

  Future<void> createOffer() async {
    // Validate required fields
    if (titleController.text.trim().isEmpty) {
      errorMessage.value = 'الرجاء إدخال عنوان العرض.';
      return;
    }
    if (selectedCategory.value.isEmpty) {
      errorMessage.value = 'الرجاء اختيار نوع المخلفات.';
      return;
    }
    if (descriptionController.text.trim().isEmpty) {
      errorMessage.value = 'الرجاء إدخال وصف للعرض.';
      return;
    }
    if (quantityController.text.trim().isEmpty) {
      errorMessage.value = 'الرجاء إدخال الكمية.';
      return;
    }
    final quantity = double.tryParse(quantityController.text.trim());
    if (quantity == null || quantity <= 0) {
      errorMessage.value = 'الرجاء إدخال كمية صحيحة.';
      return;
    }
    if (priceController.text.trim().isEmpty) {
      errorMessage.value = 'الرجاء إدخال السعر.';
      return;
    }
    final price = double.tryParse(priceController.text.trim());
    if (price == null || price < 0) {
      errorMessage.value = 'الرجاء إدخال سعر صحيح.';
      return;
    }
    if (locationController.text.trim().isEmpty) {
      errorMessage.value = 'الرجاء إدخال الموقع.';
      return;
    }

    isLoading.value = true;
    errorMessage.value = null;

    final result = await _offerService.createOffer(
      title: titleController.text.trim(),
      category: selectedCategory.value,
      description: descriptionController.text.trim(),
      quantity: quantity,
      unit: selectedUnit.value,
      price: price,
      location: locationController.text.trim(),
      availableDate: selectedDate.value,
    );

    isLoading.value = false;

    result.fold(
      (error) {
        errorMessage.value = error;
      },
      (_) {
        Get.snackbar(
          'تم بنجاح',
          'تم إنشاء العرض بنجاح!',
          backgroundColor: const Color(0xFF0D631B),
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
          duration: const Duration(seconds: 3),
        );
        Get.offAllNamed(Routes.MAIN);
      },
    );
  }

  void clearError() {
    errorMessage.value = null;
  }

  void setCategory(String category) {
    selectedCategory.value = category;
    clearError();
  }

  void setUnit(String unit) {
    selectedUnit.value = unit;
  }

  void setDate(String date) {
    selectedDate.value = date;
  }

  /// Picks a date and sets it
  Future<void> pickDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: Get.context!,
      initialDate: now.add(const Duration(days: 1)),
      firstDate: now,
      lastDate: now.add(const Duration(days: 365)),
      locale: const Locale('ar'),
    );
    if (picked != null) {
      // Format as YYYY-MM-DD
      final formatted =
          '${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}';
      setDate(formatted);
    }
  }

  @override
  void onClose() {
    titleController.dispose();
    descriptionController.dispose();
    quantityController.dispose();
    priceController.dispose();
    locationController.dispose();
    super.onClose();
  }
}
