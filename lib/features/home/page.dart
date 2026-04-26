import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:waste_bank/widgets/top_app_bar.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'controller.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top;
    return Scaffold(
      backgroundColor: const Color(0xFFF4FAFF),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: EdgeInsets.only(top: 72 + topPadding, left: 24, right: 24, bottom: 128),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildWelcomeHero(),
                const SizedBox(height: 40),
                _buildStatsGrid(),
                const SizedBox(height: 40),
                _buildRecentOffersHeader(),
                const SizedBox(height: 24),
                _buildOfferCard(
                  title: 'قش الأرز المفروم',
                  time: 'منذ ساعتين',
                  status: 'متوفر',
                  statusColor: const Color(0xFFA3F69C),
                  statusTextColor: const Color(0xFF005312),
                  location: 'الدقهلية، المنصورة',
                ),
                const SizedBox(height: 16),
                _buildOfferCard(
                  title: 'مخلفات عضوية',
                  time: 'منذ 5 ساعات',
                  status: 'قيد المراجعة',
                  statusColor: const Color(0xFFABF4AC),
                  statusTextColor: const Color(0xFF07521D),
                  location: 'الغربية، طنطا',
                ),
              ],
            ),
          ),

          // Header
          const Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SharedTopAppBar(title: 'مكرم علي'),
          ),
        ],
      ),
      floatingActionButton: _buildFAB(),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
    );
  }

  Widget _buildWelcomeHero() {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: const Color(0xFF0D631B),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            'مرحباً بك!',
            style: GoogleFonts.getFont(
              'Cairo',
              fontWeight: FontWeight.w900,
              fontSize: 30,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'نحن سعداء برؤيتك مرة أخرى في منصة بنك النفايات، ابدأ الآن بالمساهمة في بيئة أنظف.',
            textAlign: TextAlign.right,
            style: GoogleFonts.tajawal(
              fontSize: 18,
              color: const Color(0xFFCBFFC2),
              height: 1.5,
            ),
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              _buildHeroButton(
                text: 'إضافة طلب',
                backgroundColor: Colors.white,
                textColor: const Color(0xFF0D631B),
                icon: Icons.add,
              ),
              const SizedBox(width: 16),
              _buildHeroButton(
                text: 'استكشاف',
                backgroundColor: const Color(0xFF2E7D32),
                textColor: const Color(0xFFCBFFC2),
                borderColor: const Color(0x33CBFFC2),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHeroButton({
    required String text,
    required Color backgroundColor,
    required Color textColor,
    IconData? icon,
    Color? borderColor,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
        border: borderColor != null ? Border.all(color: borderColor) : null,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 20, color: textColor),
            const SizedBox(width: 8),
          ],
          Text(
            text,
            style: GoogleFonts.cairo(
              fontWeight: FontWeight.w700,
              fontSize: 14,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsGrid() {
    return Column(
      children: [
        _buildStatCard(
          label: 'إجمالي الأرباح',
          value: '450.50',
          unit: 'ج.م',
          overlayLabel: 'ربح اليوم',
          iconPath: 'assets/icons/money.svg',
          backgroundColor: Colors.white,
          textColor: const Color(0xFF001F2A),
          labelColor: const Color(0xFF707A6C),
        ),
        const SizedBox(height: 28),
        _buildStatCard(
          label: 'الطلبات النشطة',
          value: '12',
          unit: 'طلب',
          iconPath: 'assets/icons/box.svg',
          backgroundColor: Colors.white,
          textColor: const Color(0xFF001F2A),
          labelColor: const Color(0xFF707A6C),
        ),
        const SizedBox(height: 28),
        _buildStatCard(
          label: 'عروض معلقة',
          value: '5',
          unit: 'عرض',
          iconPath: 'assets/icons/timer pad.svg',
          backgroundColor: const Color(0xFFFDCDBC).withOpacity(0.2),
          textColor: const Color(0xFF603F33),
          labelColor: const Color(0xFF603F33),
          borderColor: const Color(0xFFFDCDBC).withOpacity(0.3),
          showDot: true,
        ),
      ],
    );
  }

  Widget _buildStatCard({
    required String label,
    required String value,
    required String unit,
    String? overlayLabel,
    required String iconPath,
    required Color backgroundColor,
    required Color textColor,
    required Color labelColor,
    Color? borderColor,
    bool showDot = false,
  }) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(24),
        border: borderColor != null ? Border.all(color: borderColor) : null,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (overlayLabel != null)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFFA3F69C).withOpacity(0.3),
                    borderRadius: BorderRadius.circular(9999),
                  ),
                  child: Text(
                    overlayLabel,
                    style: GoogleFonts.cairo(
                      fontWeight: FontWeight.w700,
                      fontSize: 12,
                      color: const Color(0xFF0D631B),
                    ),
                  ),
                )
              else if (showDot)
                Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: Color(0xFFBA1A1A),
                    shape: BoxShape.circle,
                  ),
                )
              else
                const SizedBox(),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFF2E7D32).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: SvgPicture.asset(
              iconPath,              
            ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Align(
            alignment: Alignment.centerRight,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  label,
                  style: GoogleFonts.tajawal(
                    fontSize: 14,
                    color: labelColor,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Text(
                      unit,
                      style: GoogleFonts.cairo(
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                        color: textColor.withOpacity(0.6),
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      value,
                      style: GoogleFonts.cairo(
                        fontWeight: FontWeight.w900,
                        fontSize: 30,
                        color: textColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentOffersHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'عرض الكل',
          style: GoogleFonts.cairo(
            fontWeight: FontWeight.w700,
            fontSize: 14,
            color: const Color(0xFF0D631B),
            decoration: TextDecoration.underline,
          ),
        ),
        Text(
          'أحدث العروض',
          style: GoogleFonts.cairo(
            fontWeight: FontWeight.w900,
            fontSize: 24,
            color: const Color(0xFF001F2A),
            letterSpacing: -0.6,
          ),
        ),
      ],
    );
  }

  Widget _buildOfferCard({
    required String title,
    required String time,
    required String status,
    required Color statusColor,
    required Color statusTextColor,
    required String location,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: [
          Container(
            height: 96,
            decoration: BoxDecoration(
              color: const Color(0xFFF4FAFF),
              borderRadius: BorderRadius.circular(16),
              image: const DecorationImage(
                image: NetworkImage('https://via.placeholder.com/300x100'),
                fit: BoxFit.cover,
                opacity: 0.1,
              ),
            ),
            child: const Center(child: Icon(Icons.image_outlined, color: Colors.blueGrey)),
          ),
          const SizedBox(height: 24),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    time,
                    style: GoogleFonts.cairo(
                      fontSize: 12,
                      color: const Color(0xFF707A6C),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: statusColor,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      status,
                      style: GoogleFonts.cairo(
                        fontWeight: FontWeight.w900,
                        fontSize: 10,
                        color: statusTextColor,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                title,
                style: GoogleFonts.cairo(
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                  color: const Color(0xFF001F2A),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                location,
                style: GoogleFonts.tajawal(
                  fontSize: 14,
                  color: const Color(0xFF707A6C),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: _buildOfferButton(
                  text: 'تفاصيل',
                  backgroundColor: const Color(0xFFC9E7F7),
                  textColor: const Color(0xFF001F2A),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _buildOfferButton(
                  text: 'قبول',
                  backgroundColor: const Color(0xFF0D631B),
                  textColor: Colors.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOfferButton({
    required String text,
    required Color backgroundColor,
    required Color textColor,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: Text(
          text,
          style: GoogleFonts.cairo(
            fontWeight: FontWeight.w700,
            fontSize: 16,
            color: textColor,
          ),
        ),
      ),
    );
  }

  Widget _buildFAB() {
    return Container(
      margin: const EdgeInsets.only(bottom:70),
      width: 64,
      height: 64,
      decoration: BoxDecoration(
        color: const Color(0xFF0D631B),
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            blurRadius: 50,
            offset: const Offset(0, 25),
          ),
        ],
      ),
      child: const Icon(Icons.add, color: Colors.white, size: 24),
    );
  }
}