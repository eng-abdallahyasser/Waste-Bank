import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'controller.dart';
import '../../widgets/auth/auth_text_field.dart';
import '../../widgets/auth/auth_google_button.dart';

class RegisterPage extends GetView<AuthController> {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4FAFF),
      body: Stack(
        children: [
          // Background decorative elements
          Positioned(
            top: -60,
            left: -50,
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF0D631B).withOpacity(0.07),
              ),
            ),
          ),
          Positioned(
            top: 120,
            left: -10,
            child: Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF2E7D32).withOpacity(0.1),
              ),
            ),
          ),
          Positioned(
            bottom: -80,
            right: -40,
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF0D631B).withOpacity(0.06),
              ),
            ),
          ),

          // Main content
          SafeArea(
            child: Column(
              children: [
                _buildAppBar(),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const SizedBox(height: 16),
                        _buildHeader(),
                        const SizedBox(height: 28),
                        _buildRoleSelector(),
                        const SizedBox(height: 28),
                        _buildForm(),
                        const SizedBox(height: 24),
                        _buildTermsCheckbox(),
                        const SizedBox(height: 12),
                        _buildErrorBanner(),
                        const SizedBox(height: 12),
                        _buildRegisterButton(),
                        const SizedBox(height: 32),
                        _buildDivider(),
                        const SizedBox(height: 32),
                        _buildGoogleButton(),
                        const SizedBox(height: 40),
                        _buildLoginLink(),
                        const SizedBox(height: 32),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: Color(0xFF2E7D32),
              size: 20,
            ),
            onPressed: () => Get.back(),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        // Logo
        Container(
          width: 72,
          height: 72,
          decoration: BoxDecoration(
            color: const Color(0xFF0D631B),
            borderRadius: BorderRadius.circular(22),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF0D631B).withOpacity(0.3),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: const Icon(Icons.recycling, color: Colors.white, size: 36),
        ),
        const SizedBox(height: 20),
        Text(
          'إنشاء حساب جديد',
          textAlign: TextAlign.center,
          style: GoogleFonts.cairo(
            fontWeight: FontWeight.w900,
            fontSize: 28,
            color: const Color(0xFF001F2A),
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'انضم إلى مجتمع بنك النفايات وابدأ رحلتك البيئية',
          textAlign: TextAlign.center,
          style: GoogleFonts.tajawal(
            fontSize: 15,
            color: const Color(0xFF707A6C),
            height: 1.5,
          ),
        ),
      ],
    );
  }

  /// Role selector: Farmer or Factory
  Widget _buildRoleSelector() {
    return Obx(() => Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: const Color(0xFFE8F0E8),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () => controller.setRegistrationRole(RegistrationRole.farmer),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(vertical: 14),
                decoration: BoxDecoration(
                  color: controller.registrationRole.value == RegistrationRole.farmer
                      ? const Color(0xFF0D631B)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.agriculture_outlined,
                      size: 20,
                      color: controller.registrationRole.value == RegistrationRole.farmer
                          ? Colors.white
                          : const Color(0xFF5A7A5A),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'مزارع',
                      style: GoogleFonts.cairo(
                        fontWeight: FontWeight.w700,
                        fontSize: 15,
                        color: controller.registrationRole.value == RegistrationRole.farmer
                            ? Colors.white
                            : const Color(0xFF5A7A5A),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () => controller.setRegistrationRole(RegistrationRole.factory),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(vertical: 14),
                decoration: BoxDecoration(
                  color: controller.registrationRole.value == RegistrationRole.factory
                      ? const Color(0xFF0D631B)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.factory_outlined,
                      size: 20,
                      color: controller.registrationRole.value == RegistrationRole.factory
                          ? Colors.white
                          : const Color(0xFF5A7A5A),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'مصنع / منظمة',
                      style: GoogleFonts.cairo(
                        fontWeight: FontWeight.w700,
                        fontSize: 15,
                        color: controller.registrationRole.value == RegistrationRole.factory
                            ? Colors.white
                            : const Color(0xFF5A7A5A),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    ));
  }

  Widget _buildForm() {
    return Column(
      children: [
        // Name field — label changes dynamically based on role
        Obx(() => AuthTextField(
          controller: controller.registerNameController,
          label: controller.registrationRole.value == RegistrationRole.farmer
              ? 'الاسم الكامل'
              : 'اسم الشركة / المنظمة',
          hint: controller.registrationRole.value == RegistrationRole.farmer
              ? 'أدخل اسمك الكامل'
              : 'أدخل اسم الشركة أو المنظمة',
          icon: controller.registrationRole.value == RegistrationRole.farmer
              ? Icons.person_outline
              : Icons.business_outlined,
          keyboardType: TextInputType.name,
        )),
        const SizedBox(height: 16),
        AuthTextField(
          controller: controller.registerEmailController,
          label: 'البريد الإلكتروني',
          hint: 'example@email.com',
          icon: Icons.email_outlined,
          keyboardType: TextInputType.emailAddress,
        ),
        const SizedBox(height: 16),
        AuthTextField(
          controller: controller.registerPhoneController,
          label: 'رقم الهاتف',
          hint: '01XXXXXXXXX',
          icon: Icons.phone_outlined,
          keyboardType: TextInputType.phone,
        ),
        const SizedBox(height: 16),
        AuthTextField(
          controller: controller.registerNationalIdController,
          label: 'الرقم الوطني',
          hint: 'أدخل رقمك الوطني',
          icon: Icons.badge_outlined,
          keyboardType: TextInputType.number,
        ),
        // Industrial registration number & factory owner name — only relevant for factories
        Obx(() {
          if (controller.registrationRole.value != RegistrationRole.factory) {
            return const SizedBox.shrink();
          }
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: AuthTextField(
                  controller: controller.registerFactoryOwnerNameController,
                  label: 'اسم صاحب المصنع',
                  hint: 'أدخل اسم صاحب المصنع',
                  icon: Icons.person_outline,
                  keyboardType: TextInputType.text,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: AuthTextField(
                  controller: controller.registerIndustrialRegNumberController,
                  label: 'الرقم الصناعي',
                  hint: 'أدخل الرقم الصناعي للمنشأة',
                  icon: Icons.factory_outlined,
                  keyboardType: TextInputType.text,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: _buildIndustryTypeDropdown(),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: AuthTextField(
                  controller: controller.registerAddressVillageController,
                  label: 'عنوان المصنع',
                  hint: 'أدخل عنوان المصنع',
                  icon: Icons.location_on_outlined,
                  keyboardType: TextInputType.text,
                ),
              ),
            ],
          );
        }),
        // Land size — only relevant for farmers
        Obx(() {
          if (controller.registrationRole.value != RegistrationRole.farmer) {
            return const SizedBox.shrink();
          }
          return Column(
            children: [
              const SizedBox(height: 16),
              AuthTextField(
                controller: controller.registerLandSizeController,
                label: 'مساحة الأرض (دونم)',
                hint: 'أدخل مساحة الأرض',
                icon: Icons.straighten_outlined,
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),
              AuthTextField(
                controller: controller.registerCropsTypeController,
                label: 'نوع المحاصيل',
                hint: 'مثال: قمح، زيتون، خضروات',
                icon: Icons.eco_outlined,
                keyboardType: TextInputType.text,
              ),
              const SizedBox(height: 16),
              AuthTextField(
                controller: controller.registerAddressVillageController,
                label: 'العنوان / القرية',
                hint: 'أدخل عنوانك أو اسم القرية',
                icon: Icons.location_on_outlined,
                keyboardType: TextInputType.text,
              ),
            ],
          );
        }),
        const SizedBox(height: 16),
        Obx(() => AuthTextField(
          controller: controller.registerPasswordController,
          label: 'كلمة المرور',
          hint: '••••••••',
          icon: Icons.lock_outline,
          obscureText: !controller.isRegisterPasswordVisible.value,
          suffixIcon: IconButton(
            icon: Icon(
              controller.isRegisterPasswordVisible.value
                  ? Icons.visibility_outlined
                  : Icons.visibility_off_outlined,
              color: const Color(0xFF707A6C),
              size: 20,
            ),
            onPressed: controller.toggleRegisterPasswordVisibility,
          ),
        )),
        const SizedBox(height: 16),
        Obx(() => AuthTextField(
          controller: controller.registerConfirmPasswordController,
          label: 'تأكيد كلمة المرور',
          hint: '••••••••',
          icon: Icons.lock_outline,
          obscureText: !controller.isConfirmPasswordVisible.value,
          suffixIcon: IconButton(
            icon: Icon(
              controller.isConfirmPasswordVisible.value
                  ? Icons.visibility_outlined
                  : Icons.visibility_off_outlined,
              color: const Color(0xFF707A6C),
              size: 20,
            ),
            onPressed: controller.toggleConfirmPasswordVisibility,
          ),
        )),
      ],
    );
  }

  Widget _buildIndustryTypeDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          'نوع الصناعة',
          style: GoogleFonts.cairo(
            fontWeight: FontWeight.w700,
            fontSize: 14,
            color: const Color(0xFF001F2A),
          ),
        ),
        const SizedBox(height: 8),
        Obx(() => GestureDetector(
          onTap: () => _showIndustryTypePicker(),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.04),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              children: [
                const Icon(Icons.category_outlined, color: Color(0xFF2E7D32), size: 20),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    controller.selectedIndustryType.value.isEmpty
                        ? 'اختر نوع الصناعة'
                        : controller.selectedIndustryType.value,
                    textAlign: TextAlign.right,
                    style: GoogleFonts.cairo(
                      fontSize: 15,
                      color: controller.selectedIndustryType.value.isEmpty
                          ? const Color(0xFF707A6C)
                          : const Color(0xFF001F2A),
                    ),
                  ),
                ),
                Icon(
                  Icons.keyboard_arrow_down_outlined,
                  color: const Color(0xFF2E7D32),
                  size: 20,
                ),
              ],
            ),
          ),
        )),
      ],
    );
  }

  /// Shows a bottom sheet with industry type options to pick from
  void _showIndustryTypePicker() {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.fromLTRB(24, 24, 24, 40),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'نوع الصناعة',
              textAlign: TextAlign.center,
              style: GoogleFonts.cairo(
                fontWeight: FontWeight.w900,
                fontSize: 20,
                color: const Color(0xFF001F2A),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'اختر نوع الصناعة الخاصة بمنظمتك',
              textAlign: TextAlign.center,
              style: GoogleFonts.tajawal(
                fontSize: 14,
                color: const Color(0xFF707A6C),
              ),
            ),
            const SizedBox(height: 20),
            const Divider(height: 1, color: Color(0xFFE0E8E0)),
            const SizedBox(height: 8),
            ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(Get.context!).size.height * 0.5,
              ),
              child: ListView(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                children: AuthController.industryTypes.map(
                  (type) => _buildIndustryOption(type),
                ).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIndustryOption(String type) {
    return Obx(() => GestureDetector(
      onTap: () {
        controller.selectedIndustryType.value = type;
        Get.back();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        margin: const EdgeInsets.symmetric(vertical: 2),
        decoration: BoxDecoration(
          color: controller.selectedIndustryType.value == type
              ? const Color(0xFF0D631B).withOpacity(0.08)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Container(
              width: 22,
              height: 22,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: controller.selectedIndustryType.value == type
                      ? const Color(0xFF0D631B)
                      : const Color(0xFFBCC8B5),
                  width: 2,
                ),
                color: controller.selectedIndustryType.value == type
                    ? const Color(0xFF0D631B)
                    : Colors.transparent,
              ),
              child: controller.selectedIndustryType.value == type
                  ? const Icon(Icons.check, color: Colors.white, size: 14)
                  : null,
            ),
            const SizedBox(width: 12),
            Text(
              type,
              style: GoogleFonts.cairo(
                fontSize: 16,
                fontWeight: controller.selectedIndustryType.value == type
                    ? FontWeight.w700
                    : FontWeight.w500,
                color: const Color(0xFF001F2A),
              ),
            ),
          ],
        ),
      ),
    ));
  }

  Widget _buildErrorBanner() {
    return Obx(() {
      final error = controller.errorMessage.value;
      if (error == null || error.isEmpty) return const SizedBox.shrink();
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: const Color(0xFFFDE8E8),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFFFCA5A5)),
        ),
        child: Row(
          children: [
            const Icon(Icons.error_outline, color: Color(0xFFDC2626), size: 20),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                error,
                style: GoogleFonts.tajawal(
                  fontSize: 14,
                  color: const Color(0xFF991B1B),
                  height: 1.4,
                ),
              ),
            ),
            GestureDetector(
              onTap: controller.clearError,
              child: const Icon(Icons.close, color: Color(0xFFDC2626), size: 18),
            ),
          ],
        ),
      );
    });
  }

  Widget _buildTermsCheckbox() {
    return Obx(
      () => GestureDetector(
        onTap: controller.toggleAgreeToTerms,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            RichText(
              text: TextSpan(
                style: GoogleFonts.cairo(
                  fontSize: 13,
                  color: const Color(0xFF707A6C),
                ),
                children: [
                  TextSpan(
                    text: 'سياسة الخصوصية',
                    style: GoogleFonts.cairo(
                      fontWeight: FontWeight.w700,
                      fontSize: 13,
                      color: const Color(0xFF0D631B),
                    ),
                  ),
                  const TextSpan(text: ' و '),
                  TextSpan(
                    text: 'الشروط والأحكام',
                    style: GoogleFonts.cairo(
                      fontWeight: FontWeight.w700,
                      fontSize: 13,
                      color: const Color(0xFF0D631B),
                    ),
                  ),
                  const TextSpan(text: ' أوافق على '),
                ],
              ),
            ),
            const SizedBox(width: 10),
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: controller.agreeToTerms.value
                    ? const Color(0xFF0D631B)
                    : Colors.white,
                borderRadius: BorderRadius.circular(6),
                border: Border.all(
                  color: controller.agreeToTerms.value
                      ? const Color(0xFF0D631B)
                      : const Color(0xFFBCC8B5),
                  width: 1.5,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: controller.agreeToTerms.value
                  ? const Icon(Icons.check, color: Colors.white, size: 16)
                  : null,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRegisterButton() {
    return Obx(
      () => GestureDetector(
        onTap: controller.isLoading.value ? null : controller.register,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          height: 60,
          decoration: BoxDecoration(
            color: const Color(0xFF0D631B),
            borderRadius: BorderRadius.circular(18),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF0D631B).withOpacity(0.4),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Center(
            child: controller.isLoading.value
                ? const CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2,
                  )
                : Text(
                    'إنشاء الحساب',
                    style: GoogleFonts.cairo(
                      fontWeight: FontWeight.w900,
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
          ),
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return Row(
      children: [
        Expanded(child: Container(height: 1, color: const Color(0xFFE0E8E0))),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'أو',
            style: GoogleFonts.cairo(
              fontSize: 14,
              color: const Color(0xFF707A6C),
            ),
          ),
        ),
        Expanded(child: Container(height: 1, color: const Color(0xFFE0E8E0))),
      ],
    );
  }

  Widget _buildGoogleButton() {
    return AuthGoogleButton(onTap: controller.loginWithGoogle);
  }

  Widget _buildLoginLink() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () => Get.back(),
          child: Text(
            'تسجيل الدخول',
            style: GoogleFonts.cairo(
              fontWeight: FontWeight.w900,
              fontSize: 15,
              color: const Color(0xFF0D631B),
              decoration: TextDecoration.underline,
              decorationColor: const Color(0xFF0D631B),
            ),
          ),
        ),
        const SizedBox(width: 4),
        Text(
          'لديك حساب بالفعل؟',
          style: GoogleFonts.cairo(
            fontSize: 15,
            color: const Color(0xFF707A6C),
          ),
        ),
      ],
    );
  }
}
