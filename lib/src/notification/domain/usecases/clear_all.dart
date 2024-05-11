import 'package:fca_education_app/core/usecases/usecases.dart';
import 'package:fca_education_app/core/utils/typedefs.dart';
import 'package:fca_education_app/src/notification/domain/repo/notification_repo.dart';

class ClearAll extends UseCaseWithoutParam<void> {
  ClearAll({
    required NotificationRepo notificationRepo,
  }) : _notificationRepo = notificationRepo;

  final NotificationRepo _notificationRepo;

  @override
  ResultFuture<void> call() {
    return _notificationRepo.clearAll();
  }
}
