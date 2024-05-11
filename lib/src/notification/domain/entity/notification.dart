import 'package:equatable/equatable.dart';
import 'package:fca_education_app/core/enum/notification_enum.dart';

class Notification extends Equatable {
  const Notification({
    required this.id,
    required this.title,
    required this.body,
    required this.catgory,
    required this.sentAt,
    this.seen = false,
  });

  Notification.empty()
      : id = 'test_id',
        title = 'test_title',
        body = 'test_body',
        catgory = NotificationCatgory.MATERIAL,
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
