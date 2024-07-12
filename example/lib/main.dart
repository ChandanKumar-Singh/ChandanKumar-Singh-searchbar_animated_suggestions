import 'package:flutter/material.dart';
import './saas/saas.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Color primaryColor = const Color(0xFF6200EE);
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: MaterialColor(
            primaryColor.value,
            <int, Color>{
              50: primaryColor.withOpacity(0.1),
              100: primaryColor.withOpacity(0.2),
              200: primaryColor.withOpacity(0.3),
              300: primaryColor.withOpacity(0.4),
              400: primaryColor.withOpacity(0.5),
              500: primaryColor.withOpacity(0.6),
              600: primaryColor.withOpacity(0.7),
              700: primaryColor.withOpacity(0.8),
              800: primaryColor.withOpacity(0.9),
              900: primaryColor.withOpacity(1),
            },
          ),
          primaryColor: primaryColor,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          appBarTheme: AppBarTheme(
            backgroundColor: primaryColor,
            foregroundColor: Colors.white,
            titleTextStyle: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          // scaffoldBackgroundColor: Colors.grey[100],
          // brightness: Brightness.dark,
          useMaterial3: true,
        ),
        home: const SaasTest());
  }
}
