import 'package:fca_education_app/core/enum/notification_enum.dart';


extension NotificationExtsss on String {
  NotificationCatgory get toNotificationCategory {
    switch (this) {
      case 'test':
        return NotificationCatgory.TEST;
      case 'video':
        return NotificationCatgory.VIDEO;
      case 'material':
        return NotificationCatgory.MATERIAL;
      case 'course':
        return NotificationCatgory.COURSE;
      default:
        return NotificationCatgory.NONE;
    }
  }
}
