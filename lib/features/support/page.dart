import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:waste_bank/widgets/top_app_bar.dart';
import 'controller.dart';

class SupportPage extends GetView<SupportController> {
  const SupportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4FAFF),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: EdgeInsets.only(
              top: 80 + MediaQuery.of(context).padding.top,
              left: 24,
              right: 24,
              bottom: 120,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildHeroSection(),
                const SizedBox(height: 48),
                _buildQuickLinksGrid(),
                const SizedBox(height: 48),
                _buildFAQSection(),
                const SizedBox(height: 48),
                _buildLiveSupportCard(),
                const SizedBox(height: 48),
                _buildResourcesSection(),
              ],
            ),
          ),
          const Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SharedTopAppBar(title: 'مكرم علي'),
          ),
        ],
      ),
    );
  }

  Widget _buildHeroSection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: const Color(0xFFC9E7F7),
        borderRadius: BorderRadius.circular(40),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            'كيف يمكننا مساعدتك اليوم؟',
            textAlign: TextAlign.right,
            style: GoogleFonts.cairo(
              fontSize: 30,
              fontWeight: FontWeight.w900,
              color: const Color(0xFF0D631B),
              height: 1.25,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'ابحث عن إجابات لأسئلتك أو تواصل مع فريق الدعم الفني لدينا للحصول على المساعدة اللازمة.',
            textAlign: TextAlign.right,
            style: GoogleFonts.cairo(
              fontSize: 18,
              fontWeight: FontWeight.w400,
              color: const Color(0x40493D),
              height: 1.56,
            ),
          ),
          const SizedBox(height: 24),
          Container(
            height: 56,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  offset: const Offset(0, 1),
                  blurRadius: 2,
                ),
              ],
            ),
            child: TextField(
              textAlign: TextAlign.right,
              decoration: InputDecoration(
                hintText: 'ابحث عن موضوع...',
                hintStyle: GoogleFonts.cairo(color: const Color(0xFF6B7280)),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
                suffixIcon: const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Icon(Icons.search, color: Color(0xFF0D631B), size: 18),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickLinksGrid() {
    return Column(
      children: controller.quickLinks.map((link) => _buildQuickLinkCard(link)).toList(),
    );
  }

  Widget _buildQuickLinkCard(Map<String, String> link) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFFE6F6FF),
        borderRadius: BorderRadius.circular(32),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFF2E7D32),
              borderRadius: BorderRadius.circular(16),
            ),
            child: SvgPicture.asset(
              'assets/icons/${link['icon']}.svg',
              width: 19,
              height: 18,
              colorFilter: const ColorFilter.mode(Color(0xFFCBFFC2), BlendMode.srcIn),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            link['title']!,
            style: GoogleFonts.cairo(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF001F2A),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            link['subtitle']!,
            textAlign: TextAlign.right,
            style: GoogleFonts.cairo(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: const Color(0xFF40493D),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFAQSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              onPressed: () {},
              child: Text(
                'عرض الكل',
                style: GoogleFonts.cairo(
                  color: const Color(0xFF0D631B),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Row(
              children: [
                Text(
                  'الأسئلة الشائعة',
                  style: GoogleFonts.cairo(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF001F2A),
                  ),
                ),
                const SizedBox(width: 12),
                const Icon(Icons.help_outline, color: Color(0xFF0D631B), size: 20),
              ],
            ),
          ],
        ),
        const SizedBox(height: 24),
        ...controller.faqs.map((faq) => _buildFAQItem(faq)).toList(),
      ],
    );
  }

  Widget _buildFAQItem(Map<String, String> faq) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      child: ExpansionTile(
        tilePadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        trailing: const Icon(Icons.keyboard_arrow_down, color: Color(0xFF0D631B)),
        leading: const SizedBox.shrink(), // Empty to push title to right
        title: Text(
          faq['question']!,
          textAlign: TextAlign.right,
          style: GoogleFonts.cairo(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF001F2A),
          ),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 24, right: 24, bottom: 24),
            child: Text(
              faq['answer']!,
              textAlign: TextAlign.right,
              style: GoogleFonts.cairo(
                fontSize: 14,
                color: const Color(0xFF40493D),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLiveSupportCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF0D631B), Color(0xFF2E7D32), Color(0xFF1D622B)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(40),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'LIVE',
                style: GoogleFonts.cairo(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.7,
                ),
              ),
              const SizedBox(width: 8),
              Container(
                width: 12,
                height: 12,
                decoration: const BoxDecoration(
                  color: Color(0xFFBBF7D0),
                  shape: BoxShape.circle,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            'دعم مباشر',
            style: GoogleFonts.cairo(
              fontSize: 30,
              fontWeight: FontWeight.w900,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'تحدث مع أحد خبرائنا الآن للحصول على مساعدة فورية في أي استفسار لديك.',
            textAlign: TextAlign.center,
            style: GoogleFonts.cairo(
              fontSize: 18,
              color: const Color(0xFFCBFFC2),
            ),
          ),
          const SizedBox(height: 32),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: const Color(0xFF0D631B),
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.chat_bubble_outline),
                const SizedBox(width: 12),
                Text(
                  'ابدأ المحادثة',
                  style: GoogleFonts.cairo(
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),
          // Representative Image Placeholder
          Container(
            height: 192,
            width: 192,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.25),
                  offset: const Offset(0, 25),
                  blurRadius: 50,
                  spreadRadius: -12,
                ),
              ],
              image: const DecorationImage(
                image: NetworkImage('https://images.unsplash.com/photo-1573497019940-1c28c88b4f3e?q=80\u0026w=500'),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResourcesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          'المصادر والمقالات',
          style: GoogleFonts.cairo(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF001F2A),
          ),
        ),
        const SizedBox(height: 24),
        SizedBox(
          height: 220,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            reverse: true, // RTL feel
            itemCount: controller.resources.length,
            itemBuilder: (context, index) {
              final resource = controller.resources[index];
              return Container(
                width: 256,
                margin: const EdgeInsets.only(left: 16),
                decoration: BoxDecoration(
                  color: const Color(0xFFE6F6FF),
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      offset: const Offset(0, 1),
                      blurRadius: 2,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      height: 128,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                        image: DecorationImage(
                          image: NetworkImage('https://images.unsplash.com/photo-1532996122724-e3c354a0b15b?q=80\u0026w=500'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            resource['title']!,
                            style: GoogleFonts.cairo(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF001F2A),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            resource['category']!,
                            style: GoogleFonts.cairo(
                              fontSize: 12,
                              color: const Color(0xFF40493D),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
