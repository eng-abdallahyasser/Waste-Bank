import 'package:get/get.dart';

class NotificationsController extends GetxController {
  final todayNotifications = [
    {
      'title': 'عرض سعر جديد',
      'body': 'لقد تلقيت عرض سعر جديد لنقل مخلفات قش الأرز من شركة السريع للنقل.',
      'time': 'منذ ٥ دقائق',
      'type': 'action',
      'icon': 'money',
      'unread': true,
    },
    {
      'title': 'الشاحنة في الطريق',
      'body': 'الشاحنة رقم (م ص ٤٥٢) في طريقها لاستلام مخلفات النخيل الآن.',
      'time': 'منذ ساعتين',
      'type': 'status',
      'icon': 'truck',
      'unread': true,
    },
  ].obs;

  final earlierNotifications = [
    {
      'title': 'تم استلام الطلب',
      'body': 'تم استلام طلبك رقم #4521 بنجاح في مصنع تدوير السادات.',
      'time': 'أمس',
      'type': 'info',
      'icon': 'box',
      'unread': false,
    },
    {
      'title': 'تحديث في النقاط',
      'body': 'تمت إضافة 150 نقطة جديدة إلى رصيدك مقابل عملية التوريد الأخيرة.',
      'time': 'قبل يومين',
      'type': 'reward',
      'icon': 'money',
      'unread': false,
    },
  ].obs;

  void markAsRead(int index, bool isToday) {
    if (isToday) {
      todayNotifications[index]['unread'] = false;
      todayNotifications.refresh();
    } else {
      earlierNotifications[index]['unread'] = false;
      earlierNotifications.refresh();
    }
  }
}
