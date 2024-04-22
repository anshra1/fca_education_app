import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fca_education_app/src/course/domain/entites/entites.dart';

class CourseModel extends Course {
  CourseModel({
    required super.id,
    required super.title,
    required super.numberOfVideos,
    required super.numberOfExams,
    required super.numberOfMaterials,
    required super.groupId,
    required super.createdAt,
    required super.updatedAt,
    super.description,
    super.image,
    super.imageIsFile = false,
  });

  CourseModel.empty()
      : this(
          id: '_empty.id',
          title: '_empty.title',
          description: '_empty.description',
          image: 'null',
          groupId: '_empty.groupId',
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
          numberOfVideos: 0,
          numberOfExams: 0,
          numberOfMaterials: 0,
        );

  factory CourseModel.fromMap(Map<String, dynamic> map) {
    return CourseModel(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      groupId: map['groupId'],
      image: map['image'],
      createdAt: (map['createdAt'] as Timestamp).toDate(),
      updatedAt: (map['updatedAt'] as Timestamp).toDate(),
      numberOfVideos: (map['numberOfVideos'] as num).toInt(),
      numberOfExams: (map['numberOfExams'] as num).toInt(),
      numberOfMaterials: (map['numberOfMaterials'] as num).toInt(),
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'groupId': groupId,
      'image': image,
      'createdAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
      'numberOfVideos': numberOfVideos,
      'numberOfExams': numberOfExams,
      'numberOfMaterials': numberOfMaterials,
    };
  }

  @override
  CourseModel copyWith({
    String? id,
    String? title,
    int? numberOfVideos,
    int? numberOfExams,
    int? numberOfMaterials,
    String? groupId,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? description,
    String? image,
    bool? imageIsFile,
  }) {
    return CourseModel(
      id: id ?? this.id,
      title: title ?? this.title,
      numberOfExams: numberOfExams ?? this.numberOfExams,
      numberOfMaterials: numberOfMaterials ?? this.numberOfMaterials,
      groupId: groupId ?? this.groupId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      description: description ?? this.description,
      image: image ?? this.image,
      imageIsFile: imageIsFile ?? this.imageIsFile,
      numberOfVideos: numberOfVideos ?? this.numberOfVideos,
    );
  }
}
