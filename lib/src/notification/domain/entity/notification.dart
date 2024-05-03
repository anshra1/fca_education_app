import 'package:equatable/equatable.dart';
import 'package:fca_education_app/%20core/enum/notification_enum.dart';

class Notification extends Equatable {
  const Notification({
    required this.id,
    required this.title,
    required this.body,
    required this.catgory,
    required this.seen,
    required this.sentAt,
  });

  Notification.empty()
      : id = 'test_id',
        title = 'test_title',
        body = 'test_body',
        catgory = NotificationCatgory.NONE,
        seen = false,
        sentAt = DateTime.now();

  final String id;
  final String title;
  final String body;
  final NotificationCatgory catgory;
  final bool seen;
  final DateTime sentAt;

  @override
  List<Object?> get props => [id];
}
