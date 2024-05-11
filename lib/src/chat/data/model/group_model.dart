import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fca_education_app/core/utils/typedefs.dart';
import 'package:fca_education_app/src/chat/domain/entities/group.dart';

class GroupModel extends Group {
  const GroupModel({
    required super.id,
    required super.name,
    required super.courseId,
    required super.members,
    super.lastMessage,
    super.lastMessageSenderName,
    super.lastMessageTimestamp,
    super.groupImageUrl,
  });

  const GroupModel.empty()
      : this(
          id: 'id',
          name: 'name',
          courseId: 'courseId',
          members: const [],
          lastMessage: null,
          groupImageUrl: null,
          lastMessageTimestamp: null,
          lastMessageSenderName: null,
        );

  factory GroupModel.fromMap(Map<String, dynamic> map) {
    return GroupModel(
      id: map['id'],
      name: map['name'],
      courseId: map['courseId'],
      members: List<String>.from(map['members'] as List<dynamic>),

      // Or
      //members: (map['members'] as List<dynamic>).cast<String>(),

      // Or
      // members:
      //     (map['members'] as List<dynamic>).map((e) => e as String).toList(),

      lastMessage: map['lastMessage'] as String?,
      groupImageUrl: map['groupImageUrl'] as String?,
      lastMessageTimestamp:
          (map['lastMessageTimestamp'] as Timestamp?)?.toDate(),
      lastMessageSenderName: map['lastMessageSenderName'] as String?,
    );
  }

  GroupModel copyWith({
    required String? id,
    required String? name,
    required String? courseId,
    required List<String>? members,
    required String? lastMessage,
    required String? groupImageUrl,
    required DateTime? lastMessageTimestamp,
    required String? lastMessageSenderName,
  }) {
    return GroupModel(
      id: id ?? this.courseId,
      name: name ?? this.name,
      courseId: courseId ?? this.courseId,
      members: members ?? this.members,
      lastMessage: lastMessage ?? this.lastMessage,
      groupImageUrl: groupImageUrl ?? groupImageUrl,
      lastMessageTimestamp: lastMessageTimestamp ?? lastMessageTimestamp,
      lastMessageSenderName: lastMessageSenderName ?? lastMessageSenderName,
    );
  }

  DataMap toMap() {
    return {
      'id': id,
      'courseId': courseId,
      'name': name,
      'members': members,
      'lastMessage': lastMessage,
      'lastMessageSenderName': lastMessageSenderName,
      'lastMessageTimestamp':
          lastMessage == null ? null : FieldValue.serverTimestamp(),
      'groupImageUrl': groupImageUrl,
    };
  }
}
