import 'package:fca_education_app/core/usecases/usecases.dart';
import 'package:fca_education_app/core/utils/typedefs.dart';
import 'package:fca_education_app/src/notification/domain/entity/notification.dart';
import 'package:fca_education_app/src/notification/domain/repo/notification_repo.dart';

class GetNotifications extends StreamUseCaseWithoutParam<List<Notification>> {
  GetNotifications({
    required NotificationRepo notificationRepo,
  }) : _notificationRepo = notificationRepo;

  final NotificationRepo _notificationRepo;

  @override
  ResultStream<List<Notification>> call() {
    return _notificationRepo.getNotifications();
  }
}
