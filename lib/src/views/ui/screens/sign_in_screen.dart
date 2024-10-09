import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../business_logic/blocs/authentication/authentication_bloc.dart';
import '../../../business_logic/blocs/authentication/authentication_event.dart';
import '../../../business_logic/blocs/authentication/authentication_state.dart';
import '../../utils/color_constant.dart';
import '../../utils/dimension_constant.dart';
import '../../utils/path_constant.dart';
import '../../utils/route_constant.dart';
import '../../utils/string_constant.dart';
import '../widgets/horizontal_or_line_widget.dart';
import '../widgets/outline_sign_in_button_widget.dart';
import '../widgets/sign_in_button_widget.dart';
import '../widgets/sign_in_footer_widget.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    void navigateToSocialLogInScreeen() {
      Navigator.of(context).pushNamed(RouteConstant.LOG_IN_SCREEN_ROUTE);
    }

    void navigateToSignUpScreen() {
      Navigator.of(context).pushNamed(RouteConstant.SIGN_UP_WITH_PHONE_SCREEN_ROUTE);
    }

    return Scaffold(
      body: SafeArea(
        child: BlocListener<AuthenticationBloc, AuthenticationState>(
          listener: (BuildContext context, AuthenticationState state) {
            if (state is AuthenticationSuccess) {
              Navigator.of(context).pop();
              final SnackBar snackBar = SnackBar(
                elevation: 0,
                behavior: SnackBarBehavior.floating,
                backgroundColor: Colors.transparent,
                content: AwesomeSnackbarContent(
                  title: 'Success',
                  message: 'Login successfully',
                  contentType: ContentType.success,
                ),
              );
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(snackBar);
              Navigator.of(context).pushNamedAndRemoveUntil(
                RouteConstant.HOME_SCREEN_ROUTE,
                (Route<dynamic> route) => false,
              );
            }
            if (state is AuthenticationFailed) {
              final SnackBar snackBar = SnackBar(
                elevation: 0,
                behavior: SnackBarBehavior.floating,
                backgroundColor: Colors.transparent,
                content: AwesomeSnackbarContent(
                  title: 'Failed',
                  message: 'Login with Facebook failed. Please try again.',
                  contentType: ContentType.failure,
                ),
              );
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(snackBar);
            }
          },
          child: Center(
            child: Column(
              children: <Widget>[
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image.asset(
                        PathConstant.INSTA_BLACK_LOGO_PATH,
                        width: DimensionConstant.SIZE_175,
                        height: DimensionConstant.SIZE_50,
                      ),
                      const SizedBox(
                        height: DimensionConstant.SIZE_20,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: DimensionConstant.SIZE_20,
                        ),
                        child: Text(
                          StringConstant.SIGN_IN_INTRODUCE_LABEL,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.montserrat(
                            color: ColorConstant.FF8E8E93,
                            fontSize: DimensionConstant.SIZE_14,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  children: <Widget>[
                    SignInButtonWidget(
                      onPressed: () {
                        context
                            .read<AuthenticationBloc>()
                            .add(SignInWithFacebook());
                      },
                      iconPath: PathConstant.FACEBOOK_ICON_PATH,
                      title: StringConstant.LOG_IN_WITH_FACEBOOK_TITLE,
                      backgroundColor: ColorConstant.FF3797EF,
                      textColor: ColorConstant.WHITE,
                    ),
                    const SizedBox(
                      height: DimensionConstant.SIZE_26,
                    ),
                    const HorizontalOrLineWidget(),
                    const SizedBox(
                      height: DimensionConstant.SIZE_26,
                    ),
                    OutlineSignInButtonWidget(
                      title: StringConstant.SIGN_UP_WITH_PHONE_AND_EMAIL_TITLE,
                      iconPath: '',
                      onPressed: navigateToSignUpScreen,
                    ),
                    const SizedBox(
                      height: DimensionConstant.SIZE_53,
                    ),
                    SignInFooterWidget(
                      label: StringConstant.ALREADY_HAVE_AN_ACCOUNT_LABEL,
                      actionLabel: StringConstant.SIGN_IN_LABEL,
                      actionColor: ColorConstant.FF262626,
                      onPressed: navigateToSocialLogInScreeen,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
