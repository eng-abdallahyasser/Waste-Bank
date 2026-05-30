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
                        const SizedBox(height: 40),
                        _buildForm(),
                        const SizedBox(height: 24),
                        _buildTermsCheckbox(),
                        const SizedBox(height: 32),
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

  Widget _buildForm() {
    return Column(
      children: [
        AuthTextField(
          controller: controller.registerNameController,
          label: 'الاسم الكامل',
          hint: 'أدخل اسمك الكامل',
          icon: Icons.person_outline,
          keyboardType: TextInputType.name,
        ),
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

  // Deprecated local _buildTextField; moved to shared AuthTextField widget.

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
