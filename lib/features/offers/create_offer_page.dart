import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'controller.dart';

class CreateOfferPage extends GetView<OfferController> {
  const CreateOfferPage({super.key});

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
                        const SizedBox(height: 32),
                        _buildForm(),
                        const SizedBox(height: 20),
                        _buildErrorBanner(),
                        const SizedBox(height: 20),
                        _buildSubmitButton(),
                        const SizedBox(height: 48),
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
          const Spacer(),
          Text(
            'إنشاء عرض جديد',
            style: GoogleFonts.cairo(
              fontWeight: FontWeight.w900,
              fontSize: 18,
              color: const Color(0xFF001F2A),
            ),
          ),
          const SizedBox(width: 48), // Balance the back button
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
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
          child: const Icon(Icons.post_add, color: Colors.white, size: 36),
        ),
        const SizedBox(height: 20),
        Text(
          'أضف عرضك الجديد',
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
          'قم بنشر مواردك الزراعية أو مخلفاتك للمساهمة في بيئة أنظف',
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
        // Title field
        _buildTextField(
          controller: controller.titleController,
          label: 'عنوان العرض',
          hint: 'مثال: قش أرز مفروم',
          icon: Icons.title_outlined,
        ),
        const SizedBox(height: 16),

        // Category dropdown
        _buildDropdownField(
          label: 'نوع المخلفات',
          hint: 'اختر نوع المخلفات',
          icon: Icons.category_outlined,
          selectedValue: controller.selectedCategory,
          options: OfferController.categories,
          onSelect: controller.setCategory,
        ),
        const SizedBox(height: 16),

        // Description
        _buildTextField(
          controller: controller.descriptionController,
          label: 'الوصف',
          hint: 'صف المنتج أو المخلفات بالتفصيل...',
          icon: Icons.description_outlined,
          maxLines: 4,
        ),
        const SizedBox(height: 16),

        // Quantity & Unit row
        Row(
          children: [
            Expanded(
              flex: 3,
              child: _buildTextField(
                controller: controller.quantityController,
                label: 'الكمية',
                hint: 'مثال: 500',
                icon: Icons.straighten_outlined,
                keyboardType: TextInputType.number,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              flex: 2,
              child: _buildUnitDropdown(),
            ),
          ],
        ),
        const SizedBox(height: 16),

        // Price
        _buildTextField(
          controller: controller.priceController,
          label: 'السعر',
          hint: 'مثال: 150',
          icon: Icons.monetization_on_outlined,
          keyboardType: TextInputType.number,
          suffix: Text(
            'ج.م',
            style: GoogleFonts.cairo(
              fontWeight: FontWeight.w700,
              fontSize: 14,
              color: const Color(0xFF707A6C),
            ),
          ),
        ),
        const SizedBox(height: 16),

        // Location
        _buildTextField(
          controller: controller.locationController,
          label: 'الموقع',
          hint: 'مثال: الدقهلية، المنصورة',
          icon: Icons.location_on_outlined,
        ),
        const SizedBox(height: 16),

        // Available date picker
        _buildDatePicker(),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    int maxLines = 1,
    TextInputType keyboardType = TextInputType.text,
    Widget? suffix,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          label,
          style: GoogleFonts.cairo(
            fontWeight: FontWeight.w700,
            fontSize: 14,
            color: const Color(0xFF001F2A),
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: TextField(
            controller: controller,
            keyboardType: keyboardType,
            textDirection: TextDirection.rtl,
            textAlign: TextAlign.right,
            maxLines: maxLines,
            style: GoogleFonts.cairo(
              fontSize: 15,
              color: const Color(0xFF001F2A),
            ),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: GoogleFonts.cairo(
                fontSize: 14,
                color: const Color(0xFF707A6C),
              ),
              suffixIcon: suffix ?? Padding(
                padding: const EdgeInsets.all(14),
                child: Icon(icon, color: const Color(0xFF2E7D32), size: 20),
              ),
              prefixIcon: suffix != null
                  ? Padding(
                      padding: const EdgeInsets.all(14),
                      child: suffix,
                    )
                  : null,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: Colors.white,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 18,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDropdownField({
    required String label,
    required String hint,
    required IconData icon,
    required RxString selectedValue,
    required List<String> options,
    required void Function(String) onSelect,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          label,
          style: GoogleFonts.cairo(
            fontWeight: FontWeight.w700,
            fontSize: 14,
            color: const Color(0xFF001F2A),
          ),
        ),
        const SizedBox(height: 8),
        Obx(() => GestureDetector(
          onTap: () => _showPickerSheet(
            title: label,
            subtitle: 'اختر من القائمة',
            options: options,
            selectedValue: selectedValue.value,
            onSelect: onSelect,
          ),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.04),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              children: [
                const Icon(Icons.keyboard_arrow_down_outlined,
                    color: Color(0xFF2E7D32), size: 20),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    selectedValue.value.isEmpty ? hint : selectedValue.value,
                    textAlign: TextAlign.right,
                    style: GoogleFonts.cairo(
                      fontSize: 15,
                      color: selectedValue.value.isEmpty
                          ? const Color(0xFF707A6C)
                          : const Color(0xFF001F2A),
                    ),
                  ),
                ),
                Icon(icon, color: const Color(0xFF2E7D32), size: 20),
              ],
            ),
          ),
        )),
      ],
    );
  }

  Widget _buildUnitDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          'الوحدة',
          style: GoogleFonts.cairo(
            fontWeight: FontWeight.w700,
            fontSize: 14,
            color: const Color(0xFF001F2A),
          ),
        ),
        const SizedBox(height: 8),
        Obx(() => GestureDetector(
          onTap: () => _showPickerSheet(
            title: 'الوحدة',
            subtitle: 'اختر وحدة القياس',
            options: OfferController.units,
            selectedValue: controller.selectedUnit.value,
            onSelect: controller.setUnit,
          ),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.04),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              children: [
                const Icon(Icons.keyboard_arrow_down_outlined,
                    color: Color(0xFF2E7D32), size: 20),
                const SizedBox(width: 8),
                Text(
                  controller.selectedUnit.value,
                  style: GoogleFonts.cairo(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF001F2A),
                  ),
                ),
              ],
            ),
          ),
        )),
      ],
    );
  }

  Widget _buildDatePicker() {
    return Obx(() => Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          'تاريخ التوفير (اختياري)',
          style: GoogleFonts.cairo(
            fontWeight: FontWeight.w700,
            fontSize: 14,
            color: const Color(0xFF001F2A),
          ),
        ),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: controller.pickDate,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.04),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              children: [
                const Icon(Icons.calendar_today_outlined,
                    color: Color(0xFF2E7D32), size: 20),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    controller.selectedDate.value ?? 'اختر تاريخ',
                    textAlign: TextAlign.right,
                    style: GoogleFonts.cairo(
                      fontSize: 15,
                      color: controller.selectedDate.value != null
                          ? const Color(0xFF001F2A)
                          : const Color(0xFF707A6C),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ));
  }

  /// Shows a bottom sheet with options to pick from
  void _showPickerSheet({
    required String title,
    required String subtitle,
    required List<String> options,
    required String selectedValue,
    required void Function(String) onSelect,
  }) {
    final height = MediaQuery.of(Get.context!).size.height;
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.fromLTRB(24, 24, 24, 40),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              title,
              textAlign: TextAlign.center,
              style: GoogleFonts.cairo(
                fontWeight: FontWeight.w900,
                fontSize: 20,
                color: const Color(0xFF001F2A),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: GoogleFonts.tajawal(
                fontSize: 14,
                color: const Color(0xFF707A6C),
              ),
            ),
            const SizedBox(height: 20),
            const Divider(height: 1, color: Color(0xFFE0E8E0)),
            const SizedBox(height: 8),
            ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: height * 0.5,
              ),
              child: ListView(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                children: options.map((option) => _buildOptionItem(
                  option: option,
                  isSelected: option == selectedValue,
                  onTap: () {
                    onSelect(option);
                    Get.back();
                  },
                )).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOptionItem({
    required String option,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        margin: const EdgeInsets.symmetric(vertical: 2),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFF0D631B).withOpacity(0.08)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Container(
              width: 22,
              height: 22,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected
                      ? const Color(0xFF0D631B)
                      : const Color(0xFFBCC8B5),
                  width: 2,
                ),
                color: isSelected
                    ? const Color(0xFF0D631B)
                    : Colors.transparent,
              ),
              child: isSelected
                  ? const Icon(Icons.check, color: Colors.white, size: 14)
                  : null,
            ),
            const SizedBox(width: 12),
            Text(
              option,
              style: GoogleFonts.cairo(
                fontSize: 16,
                fontWeight:
                    isSelected ? FontWeight.w700 : FontWeight.w500,
                color: const Color(0xFF001F2A),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorBanner() {
    return Obx(() {
      final error = controller.errorMessage.value;
      if (error == null || error.isEmpty) return const SizedBox.shrink();
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: const Color(0xFFFDE8E8),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFFFCA5A5)),
        ),
        child: Row(
          children: [
            const Icon(Icons.error_outline, color: Color(0xFFDC2626), size: 20),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                error,
                style: GoogleFonts.tajawal(
                  fontSize: 14,
                  color: const Color(0xFF991B1B),
                  height: 1.4,
                ),
              ),
            ),
            GestureDetector(
              onTap: controller.clearError,
              child: const Icon(Icons.close, color: Color(0xFFDC2626), size: 18),
            ),
          ],
        ),
      );
    });
  }

  Widget _buildSubmitButton() {
    return Obx(
      () => GestureDetector(
        onTap: controller.isLoading.value ? null : controller.createOffer,
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
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'نشر العرض',
                        style: GoogleFonts.cairo(
                          fontWeight: FontWeight.w900,
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Icon(Icons.send_rounded, color: Colors.white, size: 20),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
