import 'package:dartz/dartz.dart';
import 'package:fca_education_app/src/notification/domain/entity/notification.dart';
import 'package:fca_education_app/src/notification/domain/repo/notification_repo.dart';
import 'package:fca_education_app/src/notification/domain/usecases/get_notifications.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockNotificationRepo extends Mock implements NotificationRepo {}

void main() {
  late NotificationRepo repo;
  late GetNotifications useCase;

  setUp(
    () {
      repo = MockNotificationRepo();
      useCase = GetNotifications(notificationRepo: repo);
    },
  );

  group(
    'getNotification',
    () {
      test(
        // ignore: lines_longer_than_80_chars
        'should return a [Stream<List<Notification>>] from the [NotificationRepo]',
        () async {
          when(() => repo.getNotifications())
              .thenAnswer((_) => Stream.value(const Right([])));

          final result = useCase();

          expect(result, emits(const Right<dynamic, List<Notification>>([])));

          verify(() => repo.getNotifications()).called(1);

          verifyNoMoreInteractions(repo);
        },
      );
    },
  );
}
