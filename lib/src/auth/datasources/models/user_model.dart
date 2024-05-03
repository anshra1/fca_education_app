import 'package:fca_education_app/%20core/utils/typedefs.dart';
import 'package:fca_education_app/src/auth/domain/entites/local_user.dart';

class LocalUserModel extends LocalUser {
  const LocalUserModel({
    required super.uid,
    required super.email,
    required super.points,
    required super.fullName,
    required super.profilePic,
    super.bio,
    super.groupId,
    super.enrolledCourses,
    super.following,
    super.followers,
  });

  LocalUserModel.fromMap({
    required DataMap map,
  }) : super(
          uid: map['uid'],
          email: map['email'],
          bio: map['bio'] as String?,
          points: (map['points'] as num).toInt(),
          fullName: map['fullName'],
          profilePic: map['profilePic'] as String?,
          groupId: (map['groupId'] as List).cast<String>(),
          enrolledCourses: (map['enrolledCourses'] as List).cast<String>(),
          following: (map['following'] as List).cast<String>(),
          followers: (map['followers'] as List).cast<String>(),
        );

  const LocalUserModel.empty()
      : this(
          uid: 'local uid',
          email: 'local mail',
          bio: 'local bio',
          points: 0,
          fullName: 'local name',
          profilePic: 'local pic',
        );

  @override
  String toString() {
    // ignore: lines_longer_than_80_chars
    return 'LocalUserModel{uid: $uid ,email: $email ,bio: $bio ,points: $points ,name: $fullName, profilePic: $profilePic}';
  }

  LocalUserModel copyWith({
    String? uid,
    String? email,
    String? bio,
    int? points,
    String? fullName,
    String? profilePic,
    List<String>? groupId,
    List<String>? enrolledCourses,
    List<String>? following,
    List<String>? followers,
  }) {
    return LocalUserModel(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      bio: bio ?? this.bio,
      points: points ?? this.points,
      fullName: fullName ?? this.fullName,
      profilePic: profilePic ?? this.profilePic,
      groupId: groupId ?? this.groupId,
      enrolledCourses: enrolledCourses ?? this.enrolledCourses,
      following: following ?? this.following,
      followers: followers ?? this.followers,
    );
  }

  @override
  DataMap toMap() {
    return {
      'uid': uid,
      'email': email,
      'bio': bio,
      'points': points,
      'fullName': fullName,
      'groupId': groupId,
      'enrolledCourses': enrolledCourses,
      'following': following,
      'followers': followers,
      'profilePic': profilePic,
    };
  }
}
