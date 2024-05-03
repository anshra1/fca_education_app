import 'package:fca_education_app/%20core/utils/typedefs.dart';
import 'package:fca_education_app/src/notification/domain/entity/notification.dart';

abstract class NotificationRepo {
  const NotificationRepo();

  ResultFuture<void> markAsRead(String notificationId);

  ResultFuture<void> clearAll();

  ResultFuture<void> clear(String notificationId);

  ResultFuture<void> sendNotification(Notification notification);
  
  ResultStream<List<Notification>> getNotifications();
}
