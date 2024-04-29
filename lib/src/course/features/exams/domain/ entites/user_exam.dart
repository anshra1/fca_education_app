import 'package:equatable/equatable.dart';
import 'package:fca_education_app/src/course/features/exams/domain/%20entites/use_choice.dart';

class UserExam extends Equatable {
  const UserExam({
    required this.examId,
    required this.courseId,
    required this.totalQuestions,
    required this.examTitle,
    required this.examImageUrl,
    required this.dataSubmitted,
    required this.answers,
  });

  UserExam.empty([DateTime? date])
      : this(
          examId: 'Test id',
          courseId: 'Test CourseId',
          totalQuestions: 0,
          examTitle: 'Test Title',
          examImageUrl: 'Test url',
          dataSubmitted: date ?? DateTime.now(),
          answers: const [],
        );

  final String examId;
  final String courseId;
  final int totalQuestions;
  final String examTitle;
  final String? examImageUrl;
  final DateTime dataSubmitted;
  final List<UserChoice> answers;

  @override
  List<Object?> get props => [examId, courseId];
}
