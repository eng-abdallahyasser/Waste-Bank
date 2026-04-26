import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'controller.dart';

class NotificationsPage extends GetView<NotificationsController> {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4FAFF),
      body: CustomScrollView(
        slivers: [
          _buildAppBar(),
          SliverPadding(
            padding: const EdgeInsets.all(24),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                const SizedBox(height: 16),
                _buildSectionHeader('اليوم', showDot: true),
                const SizedBox(height: 24),
                ...controller.todayNotifications
                    .asMap()
                    .entries
                    .map(
                      (entry) =>
                          _buildNotificationCard(entry.value, entry.key, true),
                    )
                    .toList(),
                const SizedBox(height: 40),
                _buildSectionHeader('سابقاً', showDot: false),
                const SizedBox(height: 24),
                ...controller.earlierNotifications
                    .asMap()
                    .entries
                    .map(
                      (entry) =>
                          _buildNotificationCard(entry.value, entry.key, false),
                    )
                    .toList(),
                const SizedBox(height: 40),
                _buildSpecialCard(),
                const SizedBox(height: 48),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppBar() {
    return SliverAppBar(
      pinned: true,
      backgroundColor: const Color(0xFFE6F6FF),
      elevation: 0,
      centerTitle: true,
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back_ios_new,
          color: Color(0xFF166534),
          size: 20,
        ),
        onPressed: () => Get.back(),
      ),
      title: Text(
        'التنبيهات',
        style: GoogleFonts.tajawal(
          fontWeight: FontWeight.w700,
          fontSize: 20,
          color: const Color(0xFF001F2A),
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.done_all, color: Color(0xFF166534), size: 20),
          onPressed: () {},
        ),
      ],
    );
  }

  Widget _buildSectionHeader(String title, {bool showDot = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          title,
          style: GoogleFonts.tajawal(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF40493D),
          ),
        ),
        if (showDot) ...[
          const SizedBox(width: 8),
          Container(
            width: 8,
            height: 8,
            decoration: const BoxDecoration(
              color: Color(0xFF0D631B),
              shape: BoxShape.circle,
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildNotificationCard(
    Map<String, dynamic> data,
    int index,
    bool isToday,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                data['time'],
                style: GoogleFonts.tajawal(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF707A6C),
                ),
              ),
              SizedBox(width: 8),
              if (data['unread'])
                Container(
                  margin: const EdgeInsets.only(right: 8),
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: Color(0xFF0D631B),
                    shape: BoxShape.circle,
                  ),
                ),
              const Spacer(),
              Text(
                data['title'],
                style: GoogleFonts.tajawal(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF001F2A),
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Content
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const SizedBox(height: 4),
                    Text(
                      data['body'],
                      textAlign: TextAlign.right,
                      style: GoogleFonts.tajawal(
                        fontSize: 14,
                        height: 1.6,
                        color: const Color(0xFF40493D),
                      ),
                    ),
                    if (data['type'] == 'action') ...[
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          _buildButton(
                            'رفض',
                            const Color(0xFFFDCDBC),
                            const Color(0xFF795548),
                          ),
                          const SizedBox(width: 8),
                          _buildButton(
                            'قبول العرض',
                            const Color(0xFF0D631B),
                            Colors.white,
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(width: 16),
              // Icon
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: _getIconBgColor(data['type']),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: SvgPicture.asset(
                    'assets/icons/${data['icon']}.svg',
                    width: 20,
                    colorFilter: ColorFilter.mode(
                      _getIconColor(data['type']),
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildButton(String text, Color bg, Color textCol) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(9999),
      ),
      child: Text(
        text,
        style: GoogleFonts.tajawal(
          fontWeight: FontWeight.w700,
          fontSize: 12,
          color: textCol,
        ),
      ),
    );
  }

  Widget _buildSpecialCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFF2E7D32),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF2E7D32).withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            left: -16,
            bottom: -16,
            child: Opacity(
              opacity: 0.1,
              child: Icon(Icons.eco, size: 90, color: const Color(0xFFCBFFC2)),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Icon(
                Icons.tips_and_updates,
                color: Color(0xFFCBFFC2),
                size: 32,
              ),
              const SizedBox(height: 16),
              Text(
                'نصيحة اليوم للبيئة',
                style: GoogleFonts.tajawal(
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                  color: const Color(0xFFCBFFC2),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'هل تعلم أن إعادة تدوير طن واحد من الورق توفر ١٧ شجرة و٧٠٠٠ جالون من الماء؟ استمر في عملك الرائع!',
                textAlign: TextAlign.right,
                style: GoogleFonts.tajawal(
                  fontSize: 14,
                  height: 1.5,
                  color: const Color(0xFFCBFFC2).withOpacity(0.9),
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: const Color(0xFF0D631B),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(9999),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 8,
                  ),
                  elevation: 0,
                ),
                child: Text(
                  'استكشف المزيد',
                  style: GoogleFonts.tajawal(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Color _getIconBgColor(String type) {
    switch (type) {
      case 'action':
        return const Color(0xFFA3F69C);
      case 'status':
        return const Color(0xFFABF4AC);
      case 'reward':
        return const Color(0xFFC9E7F7);
      default:
        return const Color(0xFFCEEDFD);
    }
  }

  Color _getIconColor(String type) {
    switch (type) {
      case 'action':
        return const Color(0xFF005312);
      case 'status':
        return const Color(0xFF07521D);
      case 'reward':
        return const Color(0xFF0D631B);
      default:
        return const Color(0xFF707A6C);
    }
  }
}
