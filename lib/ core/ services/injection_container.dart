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
import 'package:fca_education_app/src/course/presentation/cubit/course_cubit.dart';
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
