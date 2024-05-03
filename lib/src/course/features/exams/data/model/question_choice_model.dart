import 'package:fca_education_app/%20core/utils/typedefs.dart';
import 'package:fca_education_app/src/course/features/exams/domain/%20entites/question_choices.dart';

class QuestionChoiceModel extends QuestionChoice {
  const QuestionChoiceModel({
    required super.questionId,
    required super.identifier,
    required super.choiceAnswer,
  });

  const QuestionChoiceModel.empty()
      : this(
    questionId: 'Test String',
    identifier: 'Test String',
    choiceAnswer: 'Test String',
  );

  QuestionChoiceModel.fromMap(DataMap map)
      : this(
    questionId: map['questionId'],
    identifier: map['identifier'],
    choiceAnswer: map['choiceAnswer'],
  );

  QuestionChoiceModel.fromUploadMap(DataMap map)
      : this(
    questionId:  map['questionId'],
    identifier: map['identifier'],
    choiceAnswer: map['Answer'],
  );

  QuestionChoiceModel copyWith({
    String? questionId,
    String? identifier,
    String? choiceAnswer,
  }) {
    return QuestionChoiceModel(
      questionId: questionId ?? this.questionId,
      identifier: identifier ?? this.identifier,
      choiceAnswer: choiceAnswer ?? this.choiceAnswer,
    );
  }

  DataMap toMap() {
    return <String, dynamic>{
      'questionId': questionId,
      'identifier': identifier,
      'choiceAnswer': choiceAnswer,
    };
  }
}
