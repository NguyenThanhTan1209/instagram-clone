import 'package:flutter/material.dart';

import 'src/views/ui/screens/onboarding_screen.dart';
import 'src/views/utils/route_constant.dart';
import 'src/views/utils/string_constant.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        textTheme: const TextTheme(
          bodyMedium: TextStyle(
            fontFamily: StringConstant.mainFontName,
          ),
          bodyLarge: TextStyle(
            fontFamily: StringConstant.mainFontName,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      initialRoute: RouteConstant.ONBOARDING_SCREEN_ROUTE,
      routes: <String, WidgetBuilder>{
        RouteConstant.ONBOARDING_SCREEN_ROUTE: (BuildContext context) =>
            const OnboardingScreen(),
      },
    );
  }
}
