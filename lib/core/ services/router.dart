import 'package:fca_education_app/core/%20services/injection_container.dart';
import 'package:fca_education_app/core/common/views/page_under_contruction.dart';
import 'package:fca_education_app/core/extensions/context_extension.dart';
import 'package:fca_education_app/src/auth/datasources/models/user_model.dart';
import 'package:fca_education_app/src/auth/presentation/bloc/auth_bloc.dart';
import 'package:fca_education_app/src/auth/presentation/views/screens/sign_in_screen.dart';
import 'package:fca_education_app/src/auth/presentation/views/screens/sign_up_screen.dart';
import 'package:fca_education_app/src/course/domain/entites/entites.dart';
import 'package:fca_education_app/src/course/features/exams/domain/%20entites/exam.dart';
import 'package:fca_education_app/src/course/features/exams/presentation/app/cubit/exam_cubit.dart';
import 'package:fca_education_app/src/course/features/exams/presentation/views/add_exam_view.dart';
import 'package:fca_education_app/src/course/features/exams/presentation/views/course_exam_view.dart';
import 'package:fca_education_app/src/course/features/exams/presentation/views/exams_details_view.dart';
import 'package:fca_education_app/src/course/features/materials/presentation/app/cubit/material_cubit.dart';
import 'package:fca_education_app/src/course/features/materials/presentation/views/add_material_view.dart';
import 'package:fca_education_app/src/course/features/materials/presentation/views/course_material_view.dart';
import 'package:fca_education_app/src/course/features/videos/presentation/cubit/video_cubit.dart';
import 'package:fca_education_app/src/course/features/videos/presentation/views/add_video_view.dart';
import 'package:fca_education_app/src/course/features/videos/presentation/views/course_videos_view.dart';
import 'package:fca_education_app/src/course/features/videos/presentation/views/video_player_view.dart';
import 'package:fca_education_app/src/course/presentation/cubit/course_cubit.dart';
import 'package:fca_education_app/src/course/presentation/views/course_detail_view.dart';
import 'package:fca_education_app/src/dashboard/presentation/views/dashboard.dart';
import 'package:fca_education_app/src/notification/presentation/cubit/notification_cubit.dart';
import 'package:fca_education_app/src/on_boarding/data/datasources/on_boarding_local_data_src.dart';
import 'package:fca_education_app/src/on_boarding/presentation/cubit/on_boarding_cubit.dart';
import 'package:fca_education_app/src/on_boarding/presentation/views/on_boarding_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'router.main.dart';
