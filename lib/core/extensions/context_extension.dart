import 'package:fca_education_app/core/common/app/providers/course_of_the_notifier.dart';
import 'package:fca_education_app/core/common/app/providers/tab_navigator.dart';
import 'package:fca_education_app/core/common/app/providers/user_providers.dart';
import 'package:fca_education_app/src/auth/domain/entites/local_user.dart';
import 'package:fca_education_app/src/course/domain/entites/entites.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

extension ContextExt on BuildContext {
  ThemeData get theme => Theme.of(this);

  MediaQueryData get mediaQuery => MediaQuery.of(this);
  Size get size => mediaQuery.size;
  double get height => mediaQuery.size.height;
  double get width => mediaQuery.size.width;

  UserProvider get userProvider => read<UserProvider>();

  LocalUser? get currentUser => userProvider.user;

  TabNavigator get tabNavigator => read<TabNavigator>();

  void pop() => tabNavigator.pop();

  void push(Widget page) => tabNavigator.push(TabItem(child: page));

  CourseOfTheDayNotifier get courseOfTheDayNotifier =>
      read<CourseOfTheDayNotifier>();

  Course get courseOfTheDay => courseOfTheDayNotifier.courseOfTheDay!;
}
