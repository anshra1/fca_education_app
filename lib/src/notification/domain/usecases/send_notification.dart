import 'package:fca_education_app/%20core/usecases/usecases.dart';
import 'package:fca_education_app/%20core/utils/typedefs.dart';
import 'package:fca_education_app/src/notification/domain/entity/notification.dart';
import 'package:fca_education_app/src/notification/domain/repo/notification_repo.dart';

class SendNotification extends UseCaseWithParams<void, Notification> {
  SendNotification({
    required NotificationRepo notificationRepo,
  }) : _notificationRepo = notificationRepo;

  final NotificationRepo _notificationRepo;

  @override
  ResultFuture<void> call({required Notification params}) {
    return _notificationRepo.sendNotification(params);
  }
}
