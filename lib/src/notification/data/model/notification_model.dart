import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fca_education_app/core/enum/notification_enum.dart';
import 'package:fca_education_app/core/extensions/enum_extension.dart';
import 'package:fca_education_app/core/utils/typedefs.dart';
import 'package:fca_education_app/src/notification/domain/entity/notification.dart';

class NotificationModel extends Notification {
  const NotificationModel({
    required super.id,
    required super.title,
    required super.body,
    required super.catgory,
    required super.sentAt,
    super.seen,
  });

  NotificationModel.fromMap(DataMap map)
      : super(
          id: map['id'],
          title: map['title'],
          body: map['body'],
          // ignore: noop_primitive_operations
          catgory: map['category'].toString().toNotificationCategory,
          seen: map['seen'] as bool,
          sentAt: (map['sentAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
        );

  NotificationModel.empty()
      : this(
          id: '_empty.id',
          title: '_empty.title',
          body: '_empty.body',
          catgory: NotificationCatgory.NONE,
          seen: false,
          sentAt: DateTime.now(),
        );

  NotificationModel copyWith({
    String? id,
    String? title,
    String? body,
    NotificationCatgory? catgory,
    bool? seen,
    DateTime? sentAt,
  }) {
    return NotificationModel(
      id: id ?? this.id,
      title: title ?? this.title,
      body: body ?? this.body,
      catgory: catgory ?? this.catgory,
      seen: seen ?? this.seen,
      sentAt: sentAt ?? this.sentAt,
    );
  }

  DataMap toMap() => {
        'id': id,
        'title': title,
        'body': body,
        'category': catgory.value,
        'seen': seen,
        'sentAt': FieldValue.serverTimestamp(),
      };
}
