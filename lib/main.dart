import 'package:fca_education_app/core/%20services/injection_container.dart';
import 'package:fca_education_app/core/%20services/router.dart';
import 'package:fca_education_app/core/common/app/providers/course_of_the_notifier.dart';
import 'package:fca_education_app/core/common/app/providers/notification_notifier.dart';
import 'package:fca_education_app/core/common/app/providers/user_providers.dart';
import 'package:fca_education_app/core/res/fonts.dart';
import 'package:fca_education_app/firebase_options.dart';
import 'package:fca_education_app/src/dashboard/presentation/provider/dashboard_controller.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
 // FirebaseUIAuth.configureProviders([EmailAuthProvider()]);
  await init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (BuildContext context) => UserProvider(),
        ),
        ChangeNotifierProvider(
          create: (BuildContext context) => DashBoardController(),
        ),
        ChangeNotifierProvider(
          create: (BuildContext context) => CourseOfTheDayNotifier(),
        ),
        ChangeNotifierProvider(
          create: (BuildContext context) =>
              NotificationsNotifier(sl<SharedPreferences>()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          fontFamily: Fonts.poppins,
          // brightness: Brightness.dark,
          // primarySwatch: Colors.blueGrey,
          // indicatorColor: Colors.blueGrey,
          appBarTheme: const AppBarTheme(
            color: Colors.transparent,
          ),
          colorScheme: ColorScheme.fromSwatch(
            accentColor: Colors.amberAccent,
          ),
        ),
        onGenerateRoute: generateRoute,
        //   home: const OnBoardingScreen(),
      ),
    );
  }
}
