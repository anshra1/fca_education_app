import 'package:fca_education_app/%20core/%20services/%20depandency_injection.dart';
import 'package:fca_education_app/%20core/%20services/router.dart';
import 'package:fca_education_app/%20core/res/fonts.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
    );
  }
}
