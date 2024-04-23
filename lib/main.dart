import 'package:flutter/material.dart';

import 'src/views/ui/screens/onboarding_screen.dart';
import 'src/views/utils/route_constant.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: RouteConstant.ONBOARDING_SCREEN_ROUTE,
      routes: <String, WidgetBuilder>{
        RouteConstant.ONBOARDING_SCREEN_ROUTE: (BuildContext context) => const OnboardingScreen(),
      },
    );
  }
}
