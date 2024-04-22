import 'package:fca_education_app/src/course/domain/entites/entites.dart';
import 'package:flutter/material.dart';

class CourseOfTheDayNotifier extends ChangeNotifier {
  Course? _courseOfTheDay;

  Course? get courseOfTheDay => _courseOfTheDay;

  void setCourseOfTheDay(Course course) {
    _courseOfTheDay ??= course;

    notifyListeners();

    // if (_courseOfTheDay == null) {
    //   _courseOfTheDay = course;
    // }

    // both code are same
  }
}
