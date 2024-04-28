import 'package:fca_education_app/%20core/%20services/injection_container.dart';
import 'package:fca_education_app/%20core/common/views/page_under_contruction.dart';
import 'package:fca_education_app/%20core/extensions/context_extension.dart';
import 'package:fca_education_app/src/auth/datasources/models/user_model.dart';
import 'package:fca_education_app/src/auth/presentation/bloc/auth_bloc.dart';
import 'package:fca_education_app/src/auth/presentation/views/screens/sign_in_screen.dart';
import 'package:fca_education_app/src/auth/presentation/views/screens/sign_up_screen.dart';
import 'package:fca_education_app/src/course/domain/entites/entites.dart';
import 'package:fca_education_app/src/course/presentation/views/course_detail_view.dart';
import 'package:fca_education_app/src/dashboard/presentation/views/dashboard.dart';
import 'package:fca_education_app/src/on_boarding/data/datasources/on_boarding_local_data_src.dart';
import 'package:fca_education_app/src/on_boarding/presentation/cubit/on_boarding_cubit.dart';
import 'package:fca_education_app/src/on_boarding/presentation/views/on_boarding_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart' as fui;
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'router.main.dart';
