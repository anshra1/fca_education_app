import 'package:equatable/equatable.dart';

class Video extends Equatable {
  const Video({
    required this.id,
    required this.videoURL,
    required this.courseId,
    required this.uploadData,
    this.thumbnailIsFile = false,
    this.thumbnail,
    this.title,
    this.tutor,
  });

  Video.empty()
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

  final String id;
  final String? thumbnail;
  final String videoURL;
  final String? title;
  final String? tutor;
  final String courseId;
  final DateTime uploadData;
  final bool thumbnailIsFile;

  Video copyWith({
    String? id,
    String? videoURL,
    String? courseId,
    DateTime? uploadData,
    bool? thumbnailIsFile,
    String? thumbnail,
    String? title,
    String? tutor,
  }) {
    return Video(
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

  @override
  List<Object?> get props => [id];
}
