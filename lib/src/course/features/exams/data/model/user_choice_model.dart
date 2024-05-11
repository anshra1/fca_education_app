

import 'package:fca_education_app/core/utils/typedefs.dart';
import 'package:fca_education_app/src/course/features/exams/domain/%20entites/use_choice.dart';

class UserChoiceModel extends UserChoice {
  const UserChoiceModel({
    required super.questionId,
    required super.correctChoice,
    required super.userChoice,
  });

  const UserChoiceModel.empty()
      : this(
          questionId: 'Test String',
          correctChoice: 'Test String',
          userChoice: 'Test String',
        );

  UserChoiceModel.fromMap(DataMap map)
      : this(
          questionId: map['questionId'],
          correctChoice: map['correctChoice'],
          userChoice: map['userChoice'],
        );

  UserChoiceModel copyWith({
    String? questionId,
    String? correctChoice,
    String? userChoice,
  }) {
    return UserChoiceModel(
      questionId: questionId ?? this.questionId,
      correctChoice: correctChoice ?? this.correctChoice,
      userChoice: userChoice ?? this.userChoice,
    );
  }

  DataMap toMap() {
    return <String, dynamic>{
      'questionId': questionId,
      'correctChoice': correctChoice,
      'userChoice': userChoice,
    };
  }
}
