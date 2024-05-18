
import 'package:fca_education_app/core/utils/typedefs.dart';
import 'package:fca_education_app/src/course/features/exams/data/model/question_choice_model.dart';
import 'package:fca_education_app/src/course/features/exams/domain/%20entites/exam_question.dart';
import 'package:fca_education_app/src/course/features/exams/domain/%20entites/question_choices.dart';

class ExamQuestionModel extends ExamQuestion {
  const ExamQuestionModel({
    required super.id,
    required super.courseId,
    required super.examId,
    required super.questionText,
    required super.choices,
    super.correctAnswer,
  });

  const ExamQuestionModel.empty()
      : this(
          id: 'Test String',
          examId: 'Test String',
          courseId: 'Test String',
          questionText: 'Test String',
          choices: const [],
          correctAnswer: 'Test String',
        );

  ExamQuestionModel.fromMap(DataMap map)
      : this(
          id: map['id'],
          examId: map['examId'],
          courseId: map['courseId'],
          questionText: map['questionText'],
          correctAnswer: map['correctAnswer'],
          choices: List<DataMap>.from(map['choices'] as List<dynamic>)
              .map(QuestionChoiceModel.fromMap)
              .toList(),
        );

  ExamQuestionModel.fromUploadMap(DataMap map)
      : this(
          id: map['id'] as String? ?? '',
          examId: map['examId'] as String? ?? '',
          courseId: map['courseId'] as String? ?? '',
          questionText: map['question'],
          correctAnswer: map['correct_answer'],
          choices: List<DataMap>.from(map['answers'] as List<dynamic>)
              .map(QuestionChoiceModel.fromUploadMap)
              .toList(),
        );

  ExamQuestionModel copyWith({
    String? id,
    String? examId,
    String? courseId,
    String? questionText,
    List<QuestionChoice>? choices,
    String? correctAnswer,
  }) {
    return ExamQuestionModel(
      id: id ?? this.id,
      examId: examId ?? this.examId,
      courseId: courseId ?? this.courseId,
      questionText: questionText ?? this.questionText,
      choices: choices ?? this.choices,
      correctAnswer: correctAnswer ?? this.correctAnswer,
    );
  }

  DataMap toMap() {
    return <String, dynamic>{
      'id': id,
      'examId': examId,
      'courseId': courseId,
      'questionText': questionText,
      'choices': choices
          .map((choice) => (choice as QuestionChoiceModel).toMap())
          .toList(),
      'correctAnswer': correctAnswer,
    };
  }
}
