import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'controller.dart';

class MarketPage extends GetView<MarketController> {
  const MarketPage({super.key});

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top;
    return Scaffold(
      backgroundColor: const Color(0xFFF4FAFF),
      body: Stack(
        children: [
          // Content
          SingleChildScrollView(
            padding: EdgeInsets.only(top: 72 + topPadding, left: 16, right: 16, bottom: 128),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildSearchAndFilter(),
                const SizedBox(height: 40),
                _buildListingCard(
                  title: 'سماد عضوي سائل',
                  price: '150',
                  unit: 'لتر',
                  location: 'الدقهلية، المنصورة',
                  weight: '25 كجم',
                  duration: '3 أشهر',
                  category: 'أسمدة',
                  categoryColor: const Color(0xFF0D631B),
                  imageUrl: 'https://www.maan-ctr.org/magazine/files/image/photos/issue139/alrased/2/2.jpg',
                ),
                const SizedBox(height: 24),
                _buildListingCard(
                  title: 'مخلفات أخشاب مفرومة',
                  price: '1200',
                  unit: 'طن',
                  location: 'الغربية، طنطا',
                  weight: '10 طن',
                  duration: '1 شهر',
                  category: 'أخشاب',
                  categoryColor: const Color(0xFF7A5649),
                  imageUrl: 'https://charcoalplant.com/wp-content/uploads/2022/05/wood-waste.jpg',
                ),
                const SizedBox(height: 24),
                _buildListingCard(
                  title: 'بلاستيك معاد تدويره',
                  price: '450',
                  unit: 'كجم',
                  location: 'القاهرة، العبور',
                  weight: '500 كجم',
                  duration: '6 أشهر',
                  category: 'بلاستيك',
                  categoryColor: const Color(0xFF0D631B),
                  imageUrl: 'https://www.wastetrade.com/wp-content/uploads/2023/03/Plastic-Recycling-PET.jpg.pagespeed.ce.Nfx4DXRwyw.jpg',
                ),
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
                _buildHeader(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
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
                  'مكرم علي',
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

  Widget _buildSearchAndFilter() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFFE6F6FF),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        children: [
          // Search Input
          Container(
            height: 56,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 2,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            child: Row(
              children: [
                const Icon(Icons.search, color: Color(0xFF707A6C)),
                const SizedBox(width: 12),
                Expanded(
                  child: TextField(
                    textAlign: TextAlign.right,
                    decoration: InputDecoration(
                      hintText: 'ابحث عن موارد...',
                      hintStyle: GoogleFonts.cairo(
                        color: const Color(0xFF707A6C).withOpacity(0.6),
                        fontSize: 16,
                      ),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          // Filter Buttons
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            reverse: true, // For RTL feel
            child: Row(
              children: [
                _buildFilterButton('الأحدث', 'assets/icons/timer pad.svg'),
                const SizedBox(width: 12),
                _buildFilterButton('النوع', 'assets/icons/box.svg'),
                const SizedBox(width: 12),
                _buildFilterButton('المكان', 'assets/icons/money.svg'), // Using available icons
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterButton(String label, String iconPath) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFC9E7F7),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: GoogleFonts.cairo(
              fontWeight: FontWeight.w600,
              fontSize: 14,
              color: const Color(0xFF001F2A),
            ),
          ),
          const SizedBox(width: 8),
          SvgPicture.asset(
            iconPath,
            width: 16,
            height: 16,
            colorFilter: const ColorFilter.mode(Color(0xFF0D631B), BlendMode.srcIn),
          ),
        ],
      ),
    );
  }

  Widget _buildListingCard({
    required String title,
    required String price,
    required String unit,
    required String location,
    required String weight,
    required String duration,
    required String category,
    required Color categoryColor,
    required String imageUrl,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(32),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Image Section
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
                child: Image.network(
                  imageUrl,
                  height: 224,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: 15,
                left: 13,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(9999),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 9.5),
                      color: categoryColor.withOpacity(0.9),
                      child: Text(
                        category,
                        style: GoogleFonts.cairo(
                          fontWeight: FontWeight.w700,
                          fontSize: 12,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          // Content Section
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Price
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          price,
                          style: GoogleFonts.cairo(
                            fontWeight: FontWeight.w900,
                            fontSize: 24,
                            color: const Color(0xFF0D631B),
                            letterSpacing: -0.6,
                          ),
                        ),
                        Text(
                          'ج.م / $unit',
                          style: GoogleFonts.cairo(
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                            color: const Color(0xFF707A6C),
                          ),
                        ),
                      ],
                    ),
                    // Title & Location
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            title,
                            textAlign: TextAlign.right,
                            style: GoogleFonts.cairo(
                              fontWeight: FontWeight.w900,
                              fontSize: 20,
                              color: const Color(0xFF001F2A),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                location,
                                style: GoogleFonts.cairo(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 14,
                                  color: const Color(0xFF1D622B),
                                ),
                              ),
                              const SizedBox(width: 4),
                              const Icon(Icons.location_on, size: 14, color: Color(0xFF1D622B)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                // Badges
                Row(
                  children: [
                    Expanded(
                      child: _buildInfoBadge('الكمية', weight, 'assets/icons/box.svg'),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildInfoBadge('الصلاحية', duration, 'assets/icons/timer pad.svg'),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                // Action Button
                Container(
                  height: 60,
                  decoration: BoxDecoration(
                    color: const Color(0xFF0D631B),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF0D631B).withOpacity(0.2),
                        blurRadius: 15,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      'شراء الآن',
                      style: GoogleFonts.cairo(
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                        color: Colors.white,
                      ),
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

  Widget _buildInfoBadge(String label, String value, String iconPath) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFE6F6FF),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  label,
                  style: GoogleFonts.cairo(
                    fontWeight: FontWeight.w400,
                    fontSize: 10,
                    color: const Color(0xFF707A6C),
                  ),
                ),
                Text(
                  value,
                  style: GoogleFonts.cairo(
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                    color: const Color(0xFF001F2A),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          SvgPicture.asset(
            iconPath,
            width: 20,
            height: 20,
            colorFilter: const ColorFilter.mode(Color(0xFF0D631B), BlendMode.srcIn),
          ),
        ],
      ),
    );
  }
}