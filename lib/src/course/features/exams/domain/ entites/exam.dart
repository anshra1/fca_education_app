import 'package:equatable/equatable.dart';
import 'package:fca_education_app/src/course/features/exams/domain/%20entites/exam_question.dart';

class Exam extends Equatable {
  const Exam({
    required this.id,
    required this.courseId,
    required this.title,
    required this.description,
    required this.timeLimit,
    required this.questions,
    this.imageUrl,
  });

  const Exam.empty()
      : this(
          id: 'Test id',
          courseId: 'course id',
          title: 'Test title',
          description: 'Test description',
          timeLimit: 0,
          questions: const [],
        );

  final String id;
  final String courseId;
  final String title;
  final String? imageUrl;
  final String description;
  final int timeLimit;
  final List<ExamQuestion>? questions;

  @override
  List<Object?> get props => [id, courseId];
}
