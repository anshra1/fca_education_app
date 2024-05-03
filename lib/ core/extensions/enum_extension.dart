import 'package:fca_education_app/%20core/enum/notification_enum.dart';

extension NotificationExt on String {
  NotificationCatgory get toNotificationCatogory {
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
