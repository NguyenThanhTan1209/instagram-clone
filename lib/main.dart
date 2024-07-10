import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nested/nested.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'firebase_options.dart';
import 'src/business_logic/blocs/authentication/authentication_bloc.dart';
import 'src/business_logic/blocs/post/post_bloc.dart';
import 'src/business_logic/blocs/user/user_bloc.dart';
import 'src/views/ui/screens/add_post_screen.dart';
import 'src/views/ui/screens/edit_profile_screen.dart';
import 'src/views/ui/screens/home_screen.dart';
import 'src/views/ui/screens/log_in_screen.dart';
import 'src/views/ui/screens/new_post_info_input_screen.dart';
import 'src/views/ui/screens/onboarding_screen.dart';
import 'src/views/ui/screens/preview_media_screen.dart';
import 'src/views/ui/screens/sign_in_screen.dart';
import 'src/views/ui/screens/sign_up_screen.dart';
import 'src/views/ui/screens/social_log_in_screen.dart';
import 'src/views/utils/color_constant.dart';
import 'src/views/utils/route_constant.dart';
import 'src/views/utils/string_constant.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  String initialRoute;
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final bool? skipOnboarding = prefs.getBool('skipOnboarding');
  if (skipOnboarding != null && skipOnboarding) {
    initialRoute = RouteConstant.SIGN_IN_SCREEN_ROUTE;
  } else {
    initialRoute = RouteConstant.ONBOARDING_SCREEN_ROUTE;
  }

  runApp(
    MainApp(
      initialRoute: initialRoute,
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key, required this.initialRoute});

  final String initialRoute;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: <SingleChildWidget>[
        BlocProvider<AuthenticationBloc>(
          create: (BuildContext context) => AuthenticationBloc(),
        ),
        BlocProvider<UserBloc>(
          create: (BuildContext context) => UserBloc(),
        ),
        BlocProvider<PostBloc>(create: (BuildContext context) => PostBloc()),
      ],
      child: MaterialApp(
        theme: ThemeData(
          textTheme: const TextTheme(
            bodyMedium: TextStyle(
              fontFamily: StringConstant.mainFontName,
            ),
            titleSmall: TextStyle(
              fontFamily: StringConstant.mainFontName,
              fontWeight: FontWeight.w700,
              color: ColorConstant.FF262626,
            ),
            bodyLarge: TextStyle(
              fontFamily: StringConstant.mainFontName,
              fontWeight: FontWeight.w600,
              color: ColorConstant.FF262626,
            ),
            labelMedium: TextStyle(
              fontFamily: StringConstant.mainFontName,
              fontWeight: FontWeight.w500,
              color: ColorConstant.FF262626,
            ),
          ),
          scaffoldBackgroundColor: ColorConstant.WHITE,
        ),
        initialRoute: initialRoute,
        routes: <String, WidgetBuilder>{
          RouteConstant.ONBOARDING_SCREEN_ROUTE: (BuildContext context) =>
              const OnboardingScreen(),
          RouteConstant.SIGN_IN_SCREEN_ROUTE: (BuildContext context) =>
              const SignInScreen(),
          RouteConstant.SOCIAL_LOG_IN_SCREEN_ROUTE: (BuildContext context) =>
              const SocialLogInScreen(),
          RouteConstant.LOG_IN_SCREEN_ROUTE: (BuildContext context) =>
              const LogInScreen(),
          RouteConstant.HOME_SCREEN_ROUTE: (BuildContext context) =>
              const HomeScreen(),
          RouteConstant.EDIT_PROFILE_SCREEN_ROUTE: (BuildContext context) =>
              const EditProfileScreen(),
          RouteConstant.SIGN_UP_SCREEN_ROUTE: (BuildContext context) =>
              const SignUpScreen(),
          RouteConstant.ADD_POST_SCREEN_ROUTE: (BuildContext context) =>
              const AddPostScreen(),
          RouteConstant.PREVIEW_PICTURE_SCREEN_ROUTE: (BuildContext context) =>
              const PreviewMediaScreen(),
          RouteConstant.NEW_POST_INFO_INPUT_SCREEN_ROUTE:
              (BuildContext context) => const NewPostInfoInputScreen(),
        },
      ),
    );
  }
}
