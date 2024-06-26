import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fca_education_app/src/auth/datasources/datasources/auth_remote_src.dart';
import 'package:fca_education_app/src/auth/datasources/repos/auth_repo_imp.dart';
import 'package:fca_education_app/src/auth/domain/auth_repo.dart/atuh_repo.dart';
import 'package:fca_education_app/src/auth/domain/usecases/forgot_password.dart';
import 'package:fca_education_app/src/auth/domain/usecases/sign_in.dart';
import 'package:fca_education_app/src/auth/domain/usecases/sign_up.dart';
import 'package:fca_education_app/src/auth/domain/usecases/update_user.dart';
import 'package:fca_education_app/src/auth/presentation/bloc/auth_bloc.dart';
import 'package:fca_education_app/src/course/data/datasources/course_remote_data_sources.dart';
import 'package:fca_education_app/src/course/data/repo/course_repo_impl.dart';
import 'package:fca_education_app/src/course/domain/repo/course_repo.dart';
import 'package:fca_education_app/src/course/domain/usecases/add_course.dart';
import 'package:fca_education_app/src/course/domain/usecases/get_course.dart';
import 'package:fca_education_app/src/course/features/exams/data/datasources/exam_remote_data_src.dart';
import 'package:fca_education_app/src/course/features/exams/data/repo/exam_repo_impl.dart';
import 'package:fca_education_app/src/course/features/exams/domain/%20usecases/get_exam_question.dart';
import 'package:fca_education_app/src/course/features/exams/domain/%20usecases/get_exams.dart';
import 'package:fca_education_app/src/course/features/exams/domain/%20usecases/get_user_course_exams.dart';
import 'package:fca_education_app/src/course/features/exams/domain/%20usecases/get_user_exam.dart';
import 'package:fca_education_app/src/course/features/exams/domain/%20usecases/submit_exam.dart';
import 'package:fca_education_app/src/course/features/exams/domain/%20usecases/update_exam.dart';
import 'package:fca_education_app/src/course/features/exams/domain/%20usecases/upload_exam.dart';
import 'package:fca_education_app/src/course/features/exams/domain/repo/exam_repo.dart';
import 'package:fca_education_app/src/course/features/exams/presentation/app/cubit/exam_cubit.dart';
import 'package:fca_education_app/src/course/features/materials/data/datasources/material_remote_data_src.dart';
import 'package:fca_education_app/src/course/features/materials/data/repo/material_repo_impl.dart';
import 'package:fca_education_app/src/course/features/materials/domain/repo/material_repo.dart';
import 'package:fca_education_app/src/course/features/materials/domain/usecases/add_material.dart';
import 'package:fca_education_app/src/course/features/materials/domain/usecases/get_material.dart';
import 'package:fca_education_app/src/course/features/materials/presentation/app/cubit/material_cubit.dart';
import 'package:fca_education_app/src/course/features/materials/presentation/app/providers/resource_controller.dart';
import 'package:fca_education_app/src/course/features/videos/data/datasourses/video_remote_data_src.dart';
import 'package:fca_education_app/src/course/features/videos/data/repo/video_repo_impl.dart';
import 'package:fca_education_app/src/course/features/videos/domain/repo/video_repo.dart';
import 'package:fca_education_app/src/course/features/videos/domain/usecases/add_video.dart';
import 'package:fca_education_app/src/course/features/videos/domain/usecases/get_videos.dart';
import 'package:fca_education_app/src/course/features/videos/presentation/cubit/video_cubit.dart';
import 'package:fca_education_app/src/course/presentation/cubit/course_cubit.dart';
import 'package:fca_education_app/src/notification/data/datasources/notication_remote_data_src.dart';
import 'package:fca_education_app/src/notification/data/repos/notification_repo_impl.dart';
import 'package:fca_education_app/src/notification/domain/repo/notification_repo.dart';
import 'package:fca_education_app/src/notification/domain/usecases/clear.dart';
import 'package:fca_education_app/src/notification/domain/usecases/clear_all.dart';
import 'package:fca_education_app/src/notification/domain/usecases/get_notifications.dart';
import 'package:fca_education_app/src/notification/domain/usecases/mark_as_read.dart';
import 'package:fca_education_app/src/notification/domain/usecases/send_notification.dart';
import 'package:fca_education_app/src/notification/presentation/cubit/notification_cubit.dart';
import 'package:fca_education_app/src/on_boarding/data/datasources/on_boarding_local_data_src.dart';
import 'package:fca_education_app/src/on_boarding/data/repo/on_boarding_repo_impl.dart';
import 'package:fca_education_app/src/on_boarding/domain/repo/on_boarding_repo.dart';
import 'package:fca_education_app/src/on_boarding/domain/usecase/cache_first_timer.dart';
import 'package:fca_education_app/src/on_boarding/domain/usecase/check_user_is_first_timer.dart';
import 'package:fca_education_app/src/on_boarding/presentation/cubit/on_boarding_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'injection_container.main.dart';
