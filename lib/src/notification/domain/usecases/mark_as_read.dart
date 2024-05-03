import 'package:fca_education_app/%20core/usecases/usecases.dart';
import 'package:fca_education_app/%20core/utils/typedefs.dart';
import 'package:fca_education_app/src/notification/domain/repo/notification_repo.dart';

class MarkAsRead extends UseCaseWithoutParam<void> {
  MarkAsRead({
    required NotificationRepo notificationRepo,
  }) : _notificationRepo = notificationRepo;

  final NotificationRepo _notificationRepo;

  @override
  ResultFuture<void> call() {
    return _notificationRepo.clearAll();
  }
}
