import 'package:equatable/equatable.dart';
import 'package:fca_education_app/src/course/features/exams/domain/%20entites/question_choices.dart';

class ExamQuestion extends Equatable {
  const ExamQuestion({
    required this.id,
    required this.courseId,
    required this.examId,
    required this.questionText,
    required this.choices,
    this.correctAnswer,
  });

  ExamQuestion.empty()
      : this(
          id: 'empty id',
          courseId: 'course id',
          examId: 'exam id',
          questionText: 'question text',
          choices: [],
          correctAnswer: null,
          
        );

  final String id;
  final String courseId;
  final String examId;
  final String questionText;
  final String? correctAnswer;
  final List<QuestionChoice> choices;

  @override
  List<Object?> get props => [id, examId, courseId];
}
