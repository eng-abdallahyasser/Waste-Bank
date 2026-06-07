import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:waste_bank/routes/app_routes.dart';
import 'package:waste_bank/services/auth_service.dart';

/// Enum representing the two supported registration roles
enum RegistrationRole { farmer, factory }

class AuthController extends GetxController {
  final AuthService _authService;

  AuthController(this._authService);

  // Login form
  final loginEmailController = TextEditingController();
  final loginPhoneController = TextEditingController();
  final loginPasswordController = TextEditingController();

  // Login role: farmer or org/factory
  final loginRole = RegistrationRole.farmer.obs;

  // Register form
  final registerNameController = TextEditingController();
  final registerEmailController = TextEditingController();
  final registerPhoneController = TextEditingController();
  final registerNationalIdController = TextEditingController();
  final registerLandSizeController = TextEditingController();
  final registerCropsTypeController = TextEditingController();
  final registerAddressVillageController = TextEditingController();
  final registerPasswordController = TextEditingController();
  final registerConfirmPasswordController = TextEditingController();

  final isLoginPasswordVisible = false.obs;
  final isRegisterPasswordVisible = false.obs;
  final isConfirmPasswordVisible = false.obs;
  final isLoading = false.obs;
  final agreeToTerms = false.obs;

  // Registration role: farmer or factory
  final registrationRole = RegistrationRole.farmer.obs;

  // Reactive state for the current user and error messages
  final errorMessage = Rxn<String>();

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

  /// Set the registration role
  void setRegistrationRole(RegistrationRole role) {
    registrationRole.value = role;
    clearError();
  }

  /// Set the login role (farmer or org)
  void setLoginRole(RegistrationRole role) {
    loginRole.value = role;
    clearError();
  }

  Future<void> login() async {
    // Validate based on role
    if (loginRole.value == RegistrationRole.farmer) {
      if (loginPhoneController.text.trim().isEmpty) {
        errorMessage.value = 'Please enter your phone number.';
        return;
      }
    } else {
      if (loginEmailController.text.trim().isEmpty) {
        errorMessage.value = 'Please enter your email.';
        return;
      }
    }

    if (loginPasswordController.text.isEmpty) {
      errorMessage.value = 'Please enter your password.';
      return;
    }

    isLoading.value = true;
    errorMessage.value = null;

    final AuthResult result;
    if (loginRole.value == RegistrationRole.farmer) {
      result = await _authService.loginFarmer(
        phone: loginPhoneController.text.trim(),
        password: loginPasswordController.text,
      );
    } else {
      result = await _authService.loginOrg(
        email: loginEmailController.text.trim(),
        password: loginPasswordController.text,
      );
    }

    isLoading.value = false;

    result.fold(
      (error) => errorMessage.value = error,
      (_) => Get.offAllNamed(Routes.MAIN),
    );
  }

  /// Register based on the currently selected role (farmer or factory)
  Future<void> register() async {
    if (registerNameController.text.trim().isEmpty ||
        registerEmailController.text.trim().isEmpty ||
        registerPhoneController.text.trim().isEmpty ||
        registerNationalIdController.text.trim().isEmpty ||
        registerPasswordController.text.isEmpty) {
      errorMessage.value = 'Please fill in all required fields.';
      return;
    }

    // Land size is required for farmers
    if (registrationRole.value == RegistrationRole.farmer) {
      if (registerLandSizeController.text.trim().isEmpty) {
        errorMessage.value = 'Please enter your land size.';
        return;
      }
      if (registerCropsTypeController.text.trim().isEmpty) {
        errorMessage.value = 'Please enter your crops type.';
        return;
      }
      if (registerAddressVillageController.text.trim().isEmpty) {
        errorMessage.value = 'Please enter your village/address.';
        return;
      }
    }

    if (registerPasswordController.text != registerConfirmPasswordController.text) {
      errorMessage.value = 'Passwords do not match.';
      return;
    }

    if (!agreeToTerms.value) {
      errorMessage.value = 'Please agree to the terms and conditions.';
      return;
    }

    isLoading.value = true;
    errorMessage.value = null;

    final AuthResult result;
    if (registrationRole.value == RegistrationRole.farmer) {
      result = await _authService.registerFarmer(
        name: registerNameController.text.trim(),
        email: registerEmailController.text.trim(),
        phone: registerPhoneController.text.trim(),
        nationalId: registerNationalIdController.text.trim(),
        landSize: registerLandSizeController.text.trim(),
        cropsType: registerCropsTypeController.text.trim(),
        addressVillage: registerAddressVillageController.text.trim(),
        password: registerPasswordController.text,
        passwordConfirmation: registerConfirmPasswordController.text,
      );
    } else {
      result = await _authService.registerFactory(
        name: registerNameController.text.trim(),
        email: registerEmailController.text.trim(),
        phone: registerPhoneController.text.trim(),
        nationalId: registerNationalIdController.text.trim(),
        password: registerPasswordController.text,
        passwordConfirmation: registerConfirmPasswordController.text,
      );
    }

    isLoading.value = false;

    result.fold(
      (error) => errorMessage.value = error,
      (_) => Get.offAllNamed(Routes.MAIN),
    );
  }

  Future<void> loginWithGoogle() async {
    isLoading.value = true;
    errorMessage.value = null;

    // TODO: Implement Google Sign-In to get the Google token
    // Then pass it to the auth service:
    // final result = await _authService.loginWithGoogle(googleToken);

    isLoading.value = false;
  }

  Future<void> logout() async {
    isLoading.value = true;
    await _authService.logout();
    isLoading.value = false;
    Get.offAllNamed(Routes.LOGIN);
  }

  void clearError() {
    errorMessage.value = null;
  }

  @override
  void onClose() {
    loginEmailController.dispose();
    loginPhoneController.dispose();
    loginPasswordController.dispose();
    registerNameController.dispose();
    registerEmailController.dispose();
    registerPhoneController.dispose();
    registerNationalIdController.dispose();
    registerLandSizeController.dispose();
    registerCropsTypeController.dispose();
    registerAddressVillageController.dispose();
    registerPasswordController.dispose();
    registerConfirmPasswordController.dispose();
    super.onClose();
  }
}
