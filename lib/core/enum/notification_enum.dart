// ignore_for_file: constant_identifier_names

import 'package:fca_education_app/core/res/media_res.dart';

enum NotificationCatgory {
  TEST(value: 'test', image: MediaResources.test),
  VIDEO(value: 'video,', image: MediaResources.video),
  MATERIAL(value: 'material', image: MediaResources.material),
  COURSE(value: 'course', image: MediaResources.course),
  NONE(value: 'none', image: MediaResources.course);

  const NotificationCatgory({required this.value, required this.image});
  final String value;
  final String image;
}
