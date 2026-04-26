import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'controller.dart';

class ProfilePage extends GetView<ProfileController> {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4FAFF),
      body: CustomScrollView(
        slivers: [
          _buildAppBar(),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                _buildUserHeader(),
                const SizedBox(height: 40),
                _buildImpactStatistics(),
                const SizedBox(height: 40),
                _buildMenuList(),
                const SizedBox(height: 32),
                _buildLogoutButton(),
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
      backgroundColor: const Color(0xFFF4FAFF),
      elevation: 0,
      centerTitle: true,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new, color: Color(0xFF2E7D32), size: 20),
        onPressed: () => Get.back(),
      ),
      title: Text(
        'الملف الشخصي',
        style: GoogleFonts.cairo(
          fontWeight: FontWeight.w900,
          fontSize: 20,
          color: const Color(0xFF001F2A),
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.more_vert, color: Color(0xFF166534), size: 20),
          onPressed: () {},
        ),
      ],
    );
  }

  Widget _buildUserHeader() {
    return Column(
      children: [
        Stack(
          children: [
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: const Color(0xFFC9E7F7), width: 2),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 15,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: ClipOval(
                child: Image.network(
                  'https://i.pravatar.cc/150?u=makram',
                  width: 120,
                  height: 120,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFF0D631B),
                  shape: BoxShape.circle,
                  border: Border.all(color: const Color(0xFFF4FAFF), width: 4),
                ),
                child: const Icon(Icons.edit, color: Colors.white, size: 14),
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        Text(
          controller.userName.value,
          style: GoogleFonts.cairo(
            fontWeight: FontWeight.w900,
            fontSize: 30,
            color: const Color(0xFF0D631B),
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              controller.userLocation.value,
              style: GoogleFonts.cairo(
                fontWeight: FontWeight.w500,
                fontSize: 16,
                color: const Color(0xFF40493D),
              ),
            ),
            const SizedBox(width: 8),
            const Icon(Icons.location_on, color: Color(0xFF40493D), size: 16),
          ],
        ),
      ],
    );
  }

  Widget _buildImpactStatistics() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(child: _buildStatCard(controller.impactStats[0])),
            const SizedBox(width: 16),
            Expanded(child: _buildStatCard(controller.impactStats[2])),
          ],
        ),
        const SizedBox(height: 16),
        _buildHighlightCard(controller.impactStats[1]),
      ],
    );
  }

  Widget _buildStatCard(Map<String, String> stat) {
    return Container(
      padding: const EdgeInsets.all(24),
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
          Text(
            stat['value']!,
            style: GoogleFonts.cairo(
              fontWeight: FontWeight.w900,
              fontSize: 24,
              color: const Color(0xFF2E7D32),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            stat['label']!,
            textAlign: TextAlign.center,
            style: GoogleFonts.cairo(
              fontWeight: FontWeight.w700,
              fontSize: 12,
              color: const Color(0xFF40493D),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHighlightCard(Map<String, String> stat) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 24),
      decoration: BoxDecoration(
        color: const Color(0xFF2E7D32),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF2E7D32).withOpacity(0.2),
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
              const Icon(Icons.star, color: Color(0xFFCBFFC2), size: 16),
              const SizedBox(width: 8),
              Text(
                '${stat['value']} ${stat['unit']}',
                style: GoogleFonts.cairo(
                  fontWeight: FontWeight.w900,
                  fontSize: 24,
                  color: const Color(0xFFCBFFC2),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            stat['label']!,
            style: GoogleFonts.cairo(
              fontWeight: FontWeight.w700,
              fontSize: 12,
              color: const Color(0xFFCBFFC2).withOpacity(0.9),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 8),
          child: Text(
            'الإعدادات والحساب',
            style: GoogleFonts.cairo(
              fontWeight: FontWeight.w900,
              fontSize: 14,
              color: const Color(0xFF40493D),
              letterSpacing: 1.4,
            ),
          ),
        ),
        const SizedBox(height: 12),
        ...controller.menuItems.map((item) => _buildMenuItem(item)).toList(),
      ],
    );
  }

  Widget _buildMenuItem(Map<String, String> item) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFE6F6FF),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Icon(Icons.arrow_back_ios, color: Color(0xFF707A6C), size: 12),
          Row(
            children: [
              Text(
                item['title']!,
                style: GoogleFonts.cairo(
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                  color: const Color(0xFF001F2A),
                ),
              ),
              const SizedBox(width: 16),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 2,
                      offset: const Offset(0, 1),
                    ),
                  ],
                ),
                child: Icon(_getIconData(item['icon']!), color: const Color(0xFF2E7D32), size: 16),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLogoutButton() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFBA1A1A).withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'تسجيل الخروج',
            style: GoogleFonts.cairo(
              fontWeight: FontWeight.w700,
              fontSize: 16,
              color: const Color(0xFFBA1A1A),
            ),
          ),
          const SizedBox(width: 16),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.logout, color: Color(0xFFBA1A1A), size: 18),
          ),
        ],
      ),
    );
  }

  IconData _getIconData(String iconName) {
    switch (iconName) {
      case 'person_outline': return Icons.person_outline;
      case 'settings_outlined': return Icons.settings_outlined;
      case 'payment_outlined': return Icons.payment_outlined;
      case 'security_outlined': return Icons.security_outlined;
      case 'help_outline': return Icons.help_outline;
      default: return Icons.info_outline;
    }
  }
}
