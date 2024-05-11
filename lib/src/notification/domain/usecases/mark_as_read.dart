import 'package:fca_education_app/core/usecases/usecases.dart';
import 'package:fca_education_app/core/utils/typedefs.dart';
import 'package:fca_education_app/src/notification/domain/repo/notification_repo.dart';

class MarkAsRead extends UseCaseWithParams<void, String> {
  MarkAsRead({
    required NotificationRepo notificationRepo,
  }) : _notificationRepo = notificationRepo;

  final NotificationRepo _notificationRepo;

  @override
  ResultFuture<void> call({required String params}) {
    return _notificationRepo.markAsRead(params);
  }
}
