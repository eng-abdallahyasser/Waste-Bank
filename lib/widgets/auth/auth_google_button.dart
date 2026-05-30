import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AuthGoogleButton extends StatelessWidget {
  final VoidCallback onTap;

  const AuthGoogleButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 60,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: const Color(0xFFE0E8E0), width: 1.5),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/icons/google.png', width: 28, height: 28),
            const SizedBox(width: 12),
            Text(
              'المتابعة مع Google',
              style: GoogleFonts.cairo(
                fontWeight: FontWeight.w700,
                fontSize: 16,
                color: const Color(0xFF001F2A),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
