import 'package:equatable/equatable.dart';

class LocalUser extends Equatable {
  const LocalUser({
    required this.uid,
    required this.email,
    required this.bio,
    required this.points,
    required this.fullName,
    this.groupId = const [],
    this.enrolledCourses = const [],
    this.following = const [],
    this.followers = const [],
    this.profilePic,
  });
  
  const LocalUser.empty()
      : this(
          uid: 'local uid',
          email: 'local mail',
          profilePic: 'local pic',
          bio: 'local bio',
          points: 10,
          fullName: 'local name',
          groupId: const [],
          enrolledCourses: const [],
          following: const [],
          followers: const [],
        );

  Map<String, dynamic> toMap() {
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

  final String uid;
  final String email;
  final String? bio;
  final int points;
  final String fullName;
  final List<String> groupId;
  final List<String> enrolledCourses;
  final List<String> following;
  final List<String> followers;
  final String? profilePic;

  @override
  String toString() {
    // ignore: lines_longer_than_80_chars
    return 'LocalUser{uid: $uid ,email: $email bio: $bio ,points: $points ,name: $fullName}';
  }

  @override
  List<Object?> get props => [uid, email];
}
