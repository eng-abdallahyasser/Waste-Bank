import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:waste_bank/routes/app_routes.dart';

class AuthController extends GetxController {
  // Login form
  final loginEmailController = TextEditingController();
  final loginPasswordController = TextEditingController();

  // Register form
  final registerNameController = TextEditingController();
  final registerEmailController = TextEditingController();
  final registerPhoneController = TextEditingController();
  final registerPasswordController = TextEditingController();
  final registerConfirmPasswordController = TextEditingController();

  final isLoginPasswordVisible = false.obs;
  final isRegisterPasswordVisible = false.obs;
  final isConfirmPasswordVisible = false.obs;
  final isLoading = false.obs;
  final agreeToTerms = false.obs;

  void toggleLoginPasswordVisibility() {
    isLoginPasswordVisible.value = !isLoginPasswordVisible.value;
  }

  void toggleRegisterPasswordVisibility() {
    isRegisterPasswordVisible.value = !isRegisterPasswordVisible.value;
  }

  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordVisible.value = !isConfirmPasswordVisible.value;
  }

  void toggleAgreeToTerms() {
    agreeToTerms.value = !agreeToTerms.value;
  }

  void logout() {
    // Implement logout logic
    // After logout, navigate to login screen
    Get.offAllNamed(Routes.LOGIN);
  }

  void login() {
    // Implement login logic
    // After successful login, navigate to main screen
    Get.offAllNamed(Routes.MAIN);
  }

  void register() {
    // Implement register logic
    // After successful registration, navigate to main screen
    Get.offAllNamed(Routes.MAIN);
  }

  void loginWithGoogle() {
    // Implement Google login
  }

  @override
  void onClose() {
    loginEmailController.dispose();
    loginPasswordController.dispose();
    registerNameController.dispose();
    registerEmailController.dispose();
    registerPhoneController.dispose();
    registerPasswordController.dispose();
    registerConfirmPasswordController.dispose();
    super.onClose();
  }
}
