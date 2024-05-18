import 'dart:async';

import 'package:fca_education_app/src/course/features/exams/data/model/user_choice_model.dart';
import 'package:fca_education_app/src/course/features/exams/domain/%20entites/exam.dart';
import 'package:fca_education_app/src/course/features/exams/domain/%20entites/exam_question.dart';
import 'package:fca_education_app/src/course/features/exams/domain/%20entites/question_choices.dart';
import 'package:fca_education_app/src/course/features/exams/domain/%20entites/use_choice.dart';
import 'package:fca_education_app/src/course/features/exams/domain/%20entites/user_exam.dart';
import 'package:flutter/foundation.dart';

class ExamController extends ChangeNotifier {
  ExamController({
    required Exam exam,
    required List<ExamQuestion> questions,
  })  : _exam = exam,
        _questions = questions;

  final Exam _exam;
  Exam get exam => _exam;

  final List<ExamQuestion> _questions;
  int get totalQuestions => _questions.length;

  late UserExam _userExam;
  UserExam get userExam => _userExam;

  late int _remainingTime;
  int get remainingTimeInSeconds => _remainingTime;

  bool get isTimeUp => _remainingTime == 0;

  bool _examStarted = false;
  bool get examStarted => _examStarted;

  Timer? _timer;

  String get remainingTime {
    final minutes = (_remainingTime ~/ 60).toString().padLeft(2, '0');
    final seconds = (_remainingTime % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  int _currentIndex = 0;
  int get currentIndex => _currentIndex;

  ExamQuestion get currentQuestion => _questions[_currentIndex];

  void startTimer() {
    _examStarted = true;
    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        if (_remainingTime > 0) {
          _remainingTime--;
          notifyListeners();
        } else {
          timer.cancel();
        }
      },
    );
  }

  void stopTimer() {
    _timer?.cancel();
  }

  UserChoice? get userAnswer {
    final answers = _userExam.answers;
    var noAnswer = false;
    final questionId = currentQuestion.id;
    final userChoice = answers.firstWhere(
      (answer) => answer.questionId == questionId,
      orElse: () {
        noAnswer = true;
        return const UserChoice.empty();
      },
    );
    return noAnswer ? null : userChoice;
  }

  void changeIndex() {
    if (!examStarted) startTimer();
    if (_currentIndex < _questions.length - 1) {
      _currentIndex++;
      notifyListeners();
    }
  }

  void previousQuestion() {
    if (_currentIndex > 0) {
      _currentIndex--;
      notifyListeners();
    }
  }

  void answer(QuestionChoice choice) {
    if (!_examStarted && currentIndex == 0) startTimer();

    final answer = List<UserChoice>.of(_userExam.answers);

    final userChoice = UserChoiceModel(
      questionId: choice.questionId,
      correctChoice: currentQuestion.correctAnswer!,
      userChoice: choice.identifier,
    );
  }
}
