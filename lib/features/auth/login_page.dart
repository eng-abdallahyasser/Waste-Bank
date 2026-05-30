import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../routes/app_routes.dart';
import 'controller.dart';
import '../../widgets/auth/auth_text_field.dart';
import '../../widgets/auth/auth_google_button.dart';


class LoginPage extends GetView<AuthController> {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4FAFF),
      body: Stack(
        children: [
          // Background decorative circles
          Positioned(
            top: -80,
            right: -60,
            child: Container(
              width: 220,
              height: 220,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF0D631B).withOpacity(0.08),
              ),
            ),
          ),
          Positioned(
            top: 80,
            right: -20,
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF2E7D32).withOpacity(0.1),
              ),
            ),
          ),
          Positioned(
            bottom: -60,
            left: -40,
            child: Container(
              width: 180,
              height: 180,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF0D631B).withOpacity(0.06),
              ),
            ),
          ),

          // Main content
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 40),
                  _buildHeader(),
                  const SizedBox(height: 48),
                  _buildForm(),
                  const SizedBox(height: 24),
                  _buildForgotPassword(),
                  const SizedBox(height: 32),
                  _buildLoginButton(),
                  const SizedBox(height: 32),
                  _buildDivider(),
                  const SizedBox(height: 32),
                  _buildGoogleButton(),
                  const SizedBox(height: 40),
                  _buildRegisterLink(),
                  const SizedBox(height: 32),
                ],
              ),
            ),
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
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: const Color(0xFF0D631B),
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF0D631B).withOpacity(0.3),
                blurRadius: 24,
                offset: const Offset(0, 12),
              ),
            ],
          ),
          child: const Icon(Icons.recycling, color: Colors.white, size: 40),
        ),
        const SizedBox(height: 24),
        Text(
          'مرحباً بعودتك!',
          textAlign: TextAlign.center,
          style: GoogleFonts.cairo(
            fontWeight: FontWeight.w900,
            fontSize: 32,
            color: const Color(0xFF001F2A),
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'سجّل دخولك للمتابعة في بنك النفايات',
          textAlign: TextAlign.center,
          style: GoogleFonts.tajawal(
            fontSize: 16,
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
          controller: controller.loginEmailController,
          label: 'البريد الإلكتروني',
          hint: 'example@email.com',
          icon: Icons.email_outlined,
          keyboardType: TextInputType.emailAddress,
        ),
        const SizedBox(height: 16),
        Obx(() => AuthTextField(
          controller: controller.loginPasswordController,
          label: 'كلمة المرور',
          hint: '••••••••',
          icon: Icons.lock_outline,
          obscureText: !controller.isLoginPasswordVisible.value,
          suffixIcon: IconButton(
            icon: Icon(
              controller.isLoginPasswordVisible.value
                  ? Icons.visibility_outlined
                  : Icons.visibility_off_outlined,
              color: const Color(0xFF707A6C),
              size: 20,
            ),
            onPressed: controller.toggleLoginPasswordVisibility,
          ),
        )),
      ],
    );
  }

  Widget _buildForgotPassword() {
    return Align(
      alignment: Alignment.centerLeft,
      child: GestureDetector(
        onTap: () {},
        child: Text(
          'نسيت كلمة المرور؟',
          style: GoogleFonts.cairo(
            fontWeight: FontWeight.w700,
            fontSize: 14,
            color: const Color(0xFF0D631B),
            decoration: TextDecoration.underline,
            decorationColor: const Color(0xFF0D631B),
          ),
        ),
      ),
    );
  }

  Widget _buildLoginButton() {
    return Obx(() => GestureDetector(
          onTap: controller.isLoading.value ? null : controller.login,
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
                      'تسجيل الدخول',
                      style: GoogleFonts.cairo(
                        fontWeight: FontWeight.w900,
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
            ),
          ),
        ));
  }

  Widget _buildDivider() {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 1,
            color: const Color(0xFFE0E8E0),
          ),
        ),
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
        Expanded(
          child: Container(
            height: 1,
            color: const Color(0xFFE0E8E0),
          ),
        ),
      ],
    );
  }

  // Google button widget moved to shared AuthGoogleButton widget.
  // See lib/widgets/auth/auth_google_button.dart for implementation.
  Widget _buildGoogleButton() {
    return AuthGoogleButton(onTap: controller.loginWithGoogle);
  }

  Widget _buildRegisterLink() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () => Get.toNamed(Routes.REGISTER),
          child: Text(
            'إنشاء حساب',
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
          'ليس لديك حساب؟',
          style: GoogleFonts.cairo(
            fontSize: 15,
            color: const Color(0xFF707A6C),
          ),
        ),
      ],
    );
  }
}
