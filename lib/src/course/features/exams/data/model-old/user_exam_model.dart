// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:fca_education_app/core/utils/typedefs.dart';
// import 'package:fca_education_app/src/course/features/exams/data/model-old/user_choice_model.dart';
// import 'package:fca_education_app/src/course/features/exams/domain/%20entites/use_choice.dart';
// import 'package:fca_education_app/src/course/features/exams/domain/%20entites/user_exam.dart';

// class UserExamModel extends UserExam {
//   const UserExamModel({
//     required super.examId,
//     required super.courseId,
//     required super.answers,
//     required super.examTitle,
//     required super.totalQuestions,
//     required super.dataSubmitted,
//     super.examImageUrl,
//   });

//   UserExamModel.empty([DateTime? date])
//       : this(
//           examId: 'Test String',
//           courseId: 'Test String',
//           totalQuestions: 0,
//           examTitle: 'Test String',
//           examImageUrl: 'Test String',
//           dataSubmitted: date ?? DateTime.now(),
//           answers: const [],
//         );

//   UserExamModel.fromMap(DataMap map)
//       : this(
//           examId: map['examId'],
//           courseId: map['courseId'],
//           totalQuestions: (map['totalQuestions'] as num).toInt(),
//           examTitle: map['examTitle'],
//           examImageUrl: map['examImageUrl'] as String?,
//           dataSubmitted: (map['dateSubmitted'] as Timestamp).toDate(),
//           answers: List<DataMap>.from(map['answers'] as List<dynamic>)
//               .map(UserChoiceModel.fromMap)
//               .toList(),
//         );

//   UserExamModel copyWith({
//     String? examId,
//     String? courseId,
//     int? totalQuestions,
//     String? examTitle,
//     String? examImageUrl,
//     DateTime? dataSubmitted,
//     List<UserChoice>? answers,
//   }) {
//     return UserExamModel(
//       examId: examId ?? this.examId,
//       courseId: courseId ?? this.courseId,
//       totalQuestions: totalQuestions ?? this.totalQuestions,
//       examTitle: examTitle ?? this.examTitle,
//       examImageUrl: examImageUrl ?? this.examImageUrl,
//       dataSubmitted: dataSubmitted ?? this.dataSubmitted,
//       answers: answers ?? this.answers,
//     );
//   }

//   DataMap toMap() {
//     return <String, dynamic>{
//       'examId': examId,
//       'courseId': courseId,
//       'totalQuestions': totalQuestions,
//       'examTitle': examTitle,
//       'examImageUrl': examImageUrl,
//       'dateSubmitted': FieldValue.serverTimestamp(),
//       'answers':
//           answers.map((answer) => 
//         (answer as UserChoiceModel).toMap()).toList(),
//     };
//   }
// }
