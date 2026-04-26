import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'controller.dart';

class OrdersPage extends GetView<OrdersController> {
  const OrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top;
    return Scaffold(
      backgroundColor: const Color(0xFFF4FAFF),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: EdgeInsets.only(top: 72 + topPadding, left: 16, right: 16, bottom: 128),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 24),
                _buildHeaderSection(),
                const SizedBox(height: 32),
                _buildTabs(),
                const SizedBox(height: 32),
                Obx(() => controller.selectedTab.value == 0 
                  ? _buildAvailableOrders() 
                  : _buildActiveOffers()),
              ],
            ),
          ),

          // Header
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Column(
              children: [
                Container(
                  height: topPadding,
                  color: const Color(0xFFECFDF5).withOpacity(0.8),
                ),
                _buildTopAppBar(),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: _buildFAB(),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
    );
  }

  Widget _buildTopAppBar() {
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          decoration: BoxDecoration(
            color: const Color(0xFFECFDF5).withOpacity(0.8),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Icon(Icons.notifications_none, color: Color(0xFF065F46)),
              Expanded(
                child: Text(
                  'Waste Bank',
                  textAlign: TextAlign.right,
                  style: GoogleFonts.beVietnamPro(
                    fontWeight: FontWeight.w900,
                    fontSize: 24,
                    color: const Color(0xFF064E3B),
                    letterSpacing: -1.2,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: const Color(0xFFC9E7F7),
                  border: Border.all(color: const Color(0xFFA3F69C), width: 2),
                  shape: BoxShape.circle,
                ),
                child: ClipOval(
                  child: Image.network(
                    'https://i.pravatar.cc/150?u=makram',
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => const Icon(Icons.person, color: Colors.blueGrey),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          'إدارة الشحنات',
          textAlign: TextAlign.right,
          style: GoogleFonts.cairo(
            fontWeight: FontWeight.w900,
            fontSize: 30,
            color: const Color(0xFF001F2A),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'تتبع طلبات النقل المتاحة وعروض التوصيل لمواردك الزراعية',
          textAlign: TextAlign.right,
          style: GoogleFonts.tajawal(
            fontSize: 16,
            color: const Color(0xFF40493D),
            height: 1.5,
          ),
        ),
      ],
    );
  }

  Widget _buildTabs() {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: const Color(0xFFE6F6FF),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(
            child: _buildTabButton('عروض النقل النشطة', 1),
          ),
          Expanded(
            child: _buildTabButton('طلبات النقل المتاحة', 0),
          ),
        ],
      ),
    );
  }

  Widget _buildTabButton(String title, int index) {
    return Obx(() {
      final isSelected = controller.selectedTab.value == index;
      return GestureDetector(
        onTap: () => controller.changeTab(index),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFFC9E7F7) : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
            boxShadow: isSelected 
                ? [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 2, offset: const Offset(0, 1))]
                : null,
          ),
          child: Center(
            child: Text(
              title,
              style: GoogleFonts.tajawal(
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                fontSize: 16,
                color: isSelected ? const Color(0xFF0D631B) : const Color(0xFF40493D),
              ),
            ),
          ),
        ),
      );
    });
  }

  Widget _buildAvailableOrders() {
    return Column(
      children: [
        _buildPendingShipmentCard(),
        const SizedBox(height: 24),
        _buildActiveShipmentCard(),
        const SizedBox(height: 24),
        _buildCompletedShipmentCard(),
      ],
    );
  }

  Widget _buildActiveOffers() {
    return Column(
      children: [
        _buildNewOpportunityCard(),
        const SizedBox(height: 24),
        _buildOfferAcceptanceCard(),
      ],
    );
  }

  Widget _buildPendingShipmentCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(32),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFDBCF),
                  borderRadius: BorderRadius.circular(9999),
                ),
                child: Text(
                  'بانتظار العروض',
                  style: GoogleFonts.cairo(
                    fontWeight: FontWeight.w700,
                    fontSize: 12,
                    color: const Color(0xFF603F33),
                  ),
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Text(
                    'كجم',
                    style: GoogleFonts.beVietnamPro(
                      fontWeight: FontWeight.w900,
                      fontSize: 14,
                      color: const Color(0xFF0D631B),
                    ),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '500',
                    style: GoogleFonts.beVietnamPro(
                      fontWeight: FontWeight.w900,
                      fontSize: 20,
                      color: const Color(0xFF0D631B),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 24),
          _buildLocationInfo(
            label: 'نقطة الاستلام',
            value: 'مزرعة البحيرة، دمنهور',
            dotColor: const Color(0xFF0D631B),
            isLast: false,
          ),
          _buildLocationInfo(
            label: 'وجهة التوصيل',
            value: 'مصنع التدوير، مدينة السادات',
            dotColor: const Color(0xFF7A5649),
            isLast: true,
          ),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFFE6F6FF),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildIconText('14 أكتوبر', 'assets/icons/timer pad.svg'),
                _buildIconText('نقل ثقيل', 'assets/icons/truck.svg'),
              ],
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF0D631B),
              foregroundColor: Colors.white,
              minimumSize: const Size(double.infinity, 56),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              elevation: 0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.add_circle_outline, size: 20),
                const SizedBox(width: 8),
                Text(
                  'تقديم عرض سعر',
                  style: GoogleFonts.tajawal(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActiveShipmentCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFFC9E7F7),
        borderRadius: BorderRadius.circular(32),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFFABF4AC),
                  borderRadius: BorderRadius.circular(9999),
                ),
                child: Text(
                  'جاري النقل',
                  style: GoogleFonts.cairo(
                    fontWeight: FontWeight.w700,
                    fontSize: 12,
                    color: const Color(0xFF07521D),
                  ),
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Text(
                    'طن',
                    style: GoogleFonts.beVietnamPro(
                      fontWeight: FontWeight.w900,
                      fontSize: 14,
                      color: const Color(0xFF0D631B),
                    ),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '1.2',
                    style: GoogleFonts.beVietnamPro(
                      fontWeight: FontWeight.w900,
                      fontSize: 20,
                      color: const Color(0xFF0D631B),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 24),
          _buildLocationInfo(
            label: 'نقطة الاستلام',
            value: 'صوامع طنطا',
            dotColor: const Color(0xFF0D631B),
            isLast: false,
          ),
          _buildLocationInfo(
            label: 'وجهة التوصيل',
            value: 'ميناء الإسكندرية',
            dotColor: const Color(0xFF7A5649),
            isLast: true,
          ),
          const SizedBox(height: 16),
          // Progress bar
          Stack(
            children: [
              Container(
                height: 8,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(9999),
                ),
              ),
              FractionallySizedBox(
                widthFactor: 0.66,
                child: Container(
                  height: 8,
                  decoration: BoxDecoration(
                    color: const Color(0xFF0D631B),
                    borderRadius: BorderRadius.circular(9999),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 2)],
                    ),
                    child: const Icon(Icons.phone, size: 18, color: Color(0xFF0D631B)),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'السائق',
                        style: GoogleFonts.tajawal(fontSize: 12, color: const Color(0xFF40493D)),
                      ),
                      Text(
                        'أحمد محمود',
                        style: GoogleFonts.tajawal(fontWeight: FontWeight.bold, fontSize: 14),
                      ),
                    ],
                  ),
                ],
              ),
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 2),
                  shape: BoxShape.circle,
                ),
                child: const ClipOval(
                  child: Icon(Icons.person),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          OutlinedButton(
            onPressed: () {},
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: Color(0xFF0D631B), width: 2),
              minimumSize: const Size(double.infinity, 60),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: Text(
              'تتبع الشحنة',
              style: GoogleFonts.tajawal(fontWeight: FontWeight.bold, fontSize: 16, color: const Color(0xFF0D631B)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCompletedShipmentCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFFE6F6FF).withOpacity(0.8),
        borderRadius: BorderRadius.circular(32),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFFA3F69C),
                  borderRadius: BorderRadius.circular(9999),
                ),
                child: Text(
                  'تم الاستلام',
                  style: GoogleFonts.cairo(
                    fontWeight: FontWeight.w700,
                    fontSize: 12,
                    color: const Color(0xFF005312),
                  ),
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Text(
                    'كجم',
                    style: GoogleFonts.beVietnamPro(
                      fontWeight: FontWeight.w900,
                      fontSize: 14,
                      color: const Color(0xFF0D631B),
                    ),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '850',
                    style: GoogleFonts.beVietnamPro(
                      fontWeight: FontWeight.w900,
                      fontSize: 20,
                      color: const Color(0xFF0D631B),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                'تمت في 10 أكتوبر 2023',
                style: GoogleFonts.tajawal(fontSize: 12, color: const Color(0xFF40493D)),
              ),
              const SizedBox(width: 8),
              const Icon(Icons.calendar_today, size: 14, color: Color(0xFF40493D)),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'موارد ذرة عضوية',
            textAlign: TextAlign.right,
            style: GoogleFonts.tajawal(fontWeight: FontWeight.bold, fontSize: 18, color: const Color(0xFF001F2A)),
          ),
          Text(
            'من المنصورة إلى القاهرة',
            textAlign: TextAlign.right,
            style: GoogleFonts.tajawal(fontSize: 14, color: const Color(0xFF40493D)),
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'السعر المدفوع',
                    style: GoogleFonts.tajawal(fontSize: 12, color: const Color(0xFF40493D)),
                  ),
                  Text(
                    '1,250 ج.م',
                    style: GoogleFonts.tajawal(fontWeight: FontWeight.bold, fontSize: 18, color: const Color(0xFF001F2A)),
                  ),
                ],
              ),
              Row(
                children: List.generate(5, (index) => Icon(
                  Icons.star,
                  size: 20,
                  color: index < 4 ? const Color(0xFF0D631B) : const Color(0xFFBFCABA),
                )),
              ),
            ],
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFC9E7F7),
              foregroundColor: const Color(0xFF001F2A),
              minimumSize: const Size(double.infinity, 56),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              elevation: 0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.description_outlined, size: 20),
                const SizedBox(width: 8),
                Text(
                  'عرض الفاتورة',
                  style: GoogleFonts.tajawal(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNewOpportunityCard() {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF2E7D32), Color(0xFF0D631B)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(32),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 15, offset: const Offset(0, 10)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(9999),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(width: 8, height: 8, decoration: const BoxDecoration(color: Color(0xFFA3F69C), shape: BoxShape.circle)),
                const SizedBox(width: 8),
                Text(
                  'فرصة جديدة',
                  style: GoogleFonts.tajawal(fontWeight: FontWeight.bold, fontSize: 12, color: const Color(0xFFCBFFC2)),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'نقل موارد بلاستيكية كبرى',
            textAlign: TextAlign.right,
            style: GoogleFonts.tajawal(fontWeight: FontWeight.bold, fontSize: 24, color: Colors.white),
          ),
          const SizedBox(height: 16),
          Text(
            'نبحث عن ناقل معتمد لنقل 5 طن من البلاستيك المضغوط من الفيوم إلى الجيزة. الدفع فوري عند التسليم.',
            textAlign: TextAlign.right,
            style: GoogleFonts.tajawal(fontSize: 16, color: const Color(0xFFCBFFC2).withOpacity(0.9), height: 1.5),
          ),
          const SizedBox(height: 32),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Colors.white.withOpacity(0.3)),
                    minimumSize: const Size(0, 56),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: Text('التفاصيل', style: GoogleFonts.tajawal(color: Colors.white, fontWeight: FontWeight.bold)),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: const Color(0xFF0D631B),
                    minimumSize: const Size(0, 56),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: Text('تقديم عرض الآن', style: GoogleFonts.tajawal(fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOfferAcceptanceCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(32),
        border: Border.all(color: const Color(0xFF2E7D32).withOpacity(0.2), width: 2),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: const BoxDecoration(color: Color(0xFFFFDAD6), shape: BoxShape.circle),
                child: Center(
                  child: Text('3', style: GoogleFonts.tajawal(fontWeight: FontWeight.bold, fontSize: 12, color: const Color(0xFFBA1A1A))),
                ),
              ),
              Text(
                'عروض توصيل لشحنتك',
                style: GoogleFonts.tajawal(fontWeight: FontWeight.bold, fontSize: 16, color: const Color(0xFF001F2A)),
              ),
            ],
          ),
          const SizedBox(height: 24),
          _buildOfferItem('شركة السريع للنقل', '950 ج.م', '4.9', 'خلال ساعتين'),
          const SizedBox(height: 16),
          _buildOfferItem('محمد علي (ناقل مستقل)', '800 ج.م', '4.7', 'غداً صباحاً'),
          const SizedBox(height: 24),
          TextButton(
            onPressed: () {},
            child: Text(
              'عرض جميع العروض المستلمة',
              style: GoogleFonts.tajawal(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: const Color(0xFF0D631B),
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOfferItem(String name, String price, String rating, String time) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFE6F6FF),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(price, style: GoogleFonts.tajawal(fontWeight: FontWeight.bold, fontSize: 16, color: const Color(0xFF0D631B))),
              Text(name, style: GoogleFonts.tajawal(fontWeight: FontWeight.bold, fontSize: 16, color: const Color(0xFF001F2A))),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              _buildIconText(time, 'assets/icons/timer pad.svg'),
              const SizedBox(width: 16),
              Row(
                children: [
                  Text(rating, style: GoogleFonts.tajawal(fontSize: 12, color: const Color(0xFF40493D))),
                  const SizedBox(width: 4),
                  const Icon(Icons.star, size: 14, color: Color(0xFF40493D)),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLocationInfo({
    required String label,
    required String value,
    required Color dotColor,
    required bool isLast,
  }) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  label,
                  style: GoogleFonts.cairo(fontSize: 12, color: const Color(0xFF40493D)),
                ),
                Text(
                  value,
                  style: GoogleFonts.tajawal(fontWeight: FontWeight.bold, fontSize: 16, color: const Color(0xFF001F2A)),
                ),
                if (!isLast) const SizedBox(height: 16),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Column(
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: dotColor,
                  shape: BoxShape.circle,
                  boxShadow: [BoxShadow(color: dotColor.withOpacity(0.2), blurRadius: 4, spreadRadius: 4)],
                ),
              ),
              if (!isLast)
                Expanded(
                  child: Container(
                    width: 2,
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    child: CustomPaint(
                      painter: DashLinePainter(color: const Color(0xFFBFCABA)),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildIconText(String text, String iconPath) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          text,
          style: GoogleFonts.tajawal(fontWeight: FontWeight.bold, fontSize: 14, color: const Color(0xFF001F2A)),
        ),
        const SizedBox(width: 8),
        SvgPicture.asset(iconPath, width: 20, height: 20, colorFilter: const ColorFilter.mode(Color(0xFF40493D), BlendMode.srcIn)),
      ],
    );
  }

  Widget _buildFAB() {
    return Container(
      margin: const EdgeInsets.only(bottom: 70),
      width: 64,
      height: 64,
      decoration: BoxDecoration(
        color: const Color(0xFF0D631B),
        borderRadius: BorderRadius.circular(16),
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

class DashLinePainter extends CustomPainter {
  final Color color;
  DashLinePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    double dashHeight = 5, dashSpace = 3, startY = 0;
    final paint = Paint()
      ..color = color
      ..strokeWidth = 2;
    while (startY < size.height) {
      canvas.drawLine(Offset(0, startY), Offset(0, startY + dashHeight), paint);
      startY += dashHeight + dashSpace;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}