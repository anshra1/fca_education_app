import 'package:cloud_firestore/cloud_firestore.dart';

class Course {
  Course({
    required this.id,
    required this.title,
    required this.description,
    required this.groupId,
    required this.createdAt,
    required this.updatedAt,
    required this.numberOfVideos,
    required this.numberOfExams,
    required this.numberOfMaterials,
    this.image,
    this.imageIsFile = false,
  });

    Course.empty()
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


  Course.emptys()
      : this(
          id: '',
          title: 'title',
          numberOfVideos: 1,
          numberOfExams: 1,
          numberOfMaterials: 1,
          groupId: 'groupId',
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
          description: 'description',
          image: 'image',
        );

  factory Course.fromMap(Map<String, dynamic> map) {
    return Course(
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

  final String id;
  final String title;
  final String? description;
  final String groupId;
  final String? image;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int numberOfVideos;
  final int numberOfExams;
  final int numberOfMaterials;
  final bool imageIsFile;

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

  Course copyWith({
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
    return Course(
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
