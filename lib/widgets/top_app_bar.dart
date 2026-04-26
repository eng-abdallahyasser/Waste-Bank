import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:waste_bank/routes/app_routes.dart';

class SharedTopAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  const SharedTopAppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: topPadding,
          color: const Color(0xFFECFDF5).withOpacity(0.8),
        ),
        ClipRect(
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
                  GestureDetector(
                    onTap: () => Get.toNamed(Routes.NOTIFICATIONS),
                    child: const Icon(Icons.notifications_none, color: Color(0xFF065F46)),
                  ),
                  Expanded(
                    child: Text(
                      title,
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
                  GestureDetector(
                    onTap: () => Get.toNamed(Routes.PROFILE),
                    child: Container(
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
                          errorBuilder: (context, error, stackTrace) =>
                              const Icon(Icons.person, color: Colors.blueGrey),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(120); // Estimated height including padding
}
