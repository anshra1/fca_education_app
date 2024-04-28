import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fca_education_app/src/course/features/videos/domain/entity/video.dart';

class VideoModel extends Video {
  const VideoModel({
    required super.id,
    required super.videoURL,
    required super.courseId,
    required super.uploadData,
    super.thumbnailIsFile = false,
    super.thumbnail,
    super.title,
    super.tutor,
  });

  VideoModel.empty()
      : this(
          id: 'empty.id',
          videoURL: 'empty.url',
          courseId: 'empty.courseId',
          uploadData: DateTime.now(),
          thumbnailIsFile: false,
          thumbnail: null,
          title: null,
          tutor: null,
        );

  factory VideoModel.fromMap(Map<String, dynamic> map) {
    return VideoModel(
      id: map['id'],
      videoURL: map['videoURL'],
      courseId: map['courseId'],
      uploadData: (map['uploadData'] as Timestamp).toDate(),
      thumbnail: map['thumbnail'] as String?,
      title: map['title'] as String?,
      tutor: map['tutor'] as String?,
    );
  }
  @override
  VideoModel copyWith({
    String? id,
    String? videoURL,
    String? courseId,
    DateTime? uploadData,
    bool? thumbnailIsFile,
    String? thumbnail,
    String? title,
    String? tutor,
  }) {
    return VideoModel(
      id: id ?? this.id,
      videoURL: videoURL ?? this.videoURL,
      courseId: courseId ?? this.courseId,
      uploadData: uploadData ?? this.uploadData,
      thumbnailIsFile: thumbnailIsFile ?? this.thumbnailIsFile,
      thumbnail: thumbnail ?? this.thumbnail,
      title: title ?? this.title,
      tutor: tutor ?? this.tutor,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'videoURL': videoURL,
      'courseId': courseId,
      'uploadData': FieldValue.serverTimestamp(),
      'thumbnail': thumbnail,
      'title': title,
      'tutor': tutor,
    };
  }
}
