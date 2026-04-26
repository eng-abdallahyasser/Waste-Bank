import 'package:get/get.dart';

class SupportController extends GetxController {
  final searchQuery = ''.obs;

  final quickLinks = [
    {'title': 'إدارة النفايات', 'subtitle': 'كيفية التخلص من النفايات بشكل صحيح', 'icon': 'box'},
    {'title': 'نقاط المكافأة', 'subtitle': 'تعرف على كيفية استبدال نقاطك', 'icon': 'money'},
    {'title': 'الشحن والخدمات', 'subtitle': 'تتبع شحناتك وطلباتك', 'icon': 'truck'},
  ].obs;

  final faqs = [
    {'question': 'كيف يمكنني تحويل نقاطي؟', 'answer': 'يمكنك تحويل نقاطك من خلال التوجه إلى المتجر واختيار المنتج المناسب.'},
    {'question': 'ما هي أنواع النفايات المقبولة؟', 'answer': 'نحن نقبل البلاستيك، الورق، والمعادن حالياً.'},
    {'question': 'كيف يمكنني التواصل مع الدعم الفني؟', 'answer': 'يمكنك بدء محادثة فورية مع فريقنا من خلال الزر أدناه.'},
  ].obs;

  final resources = [
    {'title': 'دليل الاستدامة', 'category': 'تعليمي'},
    {'title': 'دليل فرز النفايات', 'category': 'إرشادي'},
    {'title': 'التعامل مع المواد الخطرة', 'category': 'سلامة'},
  ].obs;

  void onSearch(String query) {
    searchQuery.value = query;
  }
}
